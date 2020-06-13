module Appium
  module Thor
    module Helpers
      # Sets the permissions on the gem credentials
      # Runs gem build gemspec
      def _build_gem
        `chmod 0600 ~/.gem/credentials`
        sh "gem build #{gem_name}.gemspec"
      end

      # Returns true if the tag exists on the master branch.
      def tag_exists(tag_name)
        cmd = %Q(git branch -a --contains "#{tag_name}")
        POSIX::Spawn::Child.new(cmd).out.include? "* #{branch}"
      end

      # Runs command. Raises an exception if the command doesn't execute successfully.
      def sh(command)
        process = POSIX::Spawn::Child.new command

        unless process.success?
          raise "Command #{command} failed. out: #{process.out}\nerr: #{process.err}"
        end

        out = process.out
        out ? out.strip : out
      end

      # Used to parse the version number from version_file
      def version_rgx
        /\s*VERSION\s*=\s*'([^']+)'/m
      end

      # Returns the version number from version_file as a string
      def version
        @version ||= File.read(version_file).match(version_rgx)[1]
      end

      # Updates the date and version in version_file.
      # Prints the new version and date to the console.
      # The date is not printed if it hasn't changed.
      #
      # x.y.z
      #
      # @param value [symbol] value is either :x, :y, or :z. Default is z.
      def _bump(value)
        data = File.read version_file

        v_line = data.match version_rgx
        d_line = data.match /\s*DATE\s*=\s*'([^']+)'/m

        old_v = v_line[0]
        old_d = d_line[0]

        old_num     = v_line[1]
        new_num     = old_num.split('.')
        new_num[-1] = new_num[-1].to_i + 1

        if value == :y
          new_num[-1] = 0 # x.y.Z -> x.y.0
          new_num[-2] = new_num[-2].to_i + 1 # x.Y -> x.Y+1
        elsif value == :x
          new_num[-1] = 0 # x.y.Z -> x.y.0
          new_num[-2] = 0 # x.Y.z -> x.0.z
          new_num[-3] = new_num[-3].to_i + 1
        end

        new_num = new_num.join '.'

        new_v = old_v.sub old_num, new_num
        puts "#{old_num} -> #{new_num}"

        old_date = d_line[1]
        new_date = Date.today.to_s
        new_d    = old_d.sub old_date, new_date
        puts "#{old_date} -> #{new_date}" unless old_date == new_date

        data.sub! old_v, new_v
        data.sub! old_d, new_d

        File.write version_file, data
      end

      # Creates release_notes.md based on changes between tags.
      # Note that the first tag won't contain notes.
      def update_release_notes
        tag_sort = ->(tag1, tag2) do
          tag1_numbers = tag1.match(/\.?v(\d+\.\d+\.\d+)$/)
          # avoid indexing into a nil match. nil[1]
          tag1_numbers = tag1_numbers[1].split('.').map! { |n| n.to_i } if tag1_numbers
          tag2_numbers = tag2.match(/\.?v(\d+\.\d+\.\d+)$/)
          tag2_numbers = tag2_numbers[1].split('.').map! { |n| n.to_i } if tag2_numbers
          tag1_numbers <=> tag2_numbers
        end

        tags = `git tag`.split "\n"
        begin
          tags.sort! &tag_sort
        rescue
          message = 'Skipping release notes (unable to sort)'
          $stderr.puts message
          fail message
        end
        pairs = []
        tags.each_index { |a| pairs.push tags[a] + '...' + tags[a+1] unless tags[a+1].nil? }

        notes = ''

        dates = `git log --tags --simplify-by-decoration --pretty="format:%d %ad" --date=short`.split "\n"

        pairs.sort! &tag_sort
        pairs.reverse! # pairs are in reverse order.

        tag_date = []
        pairs.each do |pair|
          tag = pair.split('...').last
          dates.each do |line|
            # regular tag, or tag on master.
            if line.include?(tag + ')') || line.include?(tag + ',')
              tag_date.push tag + ' ' + line.match(/\d{4}-\d{2}-\d{2}/)[0]
              break
            end
          end
        end

        pairs.each_index do |a|
          data     =`git log --pretty=oneline #{pairs[a]}`
          new_data = ''
          data.split("\n").each do |line|
            hex     = line.match(/[a-zA-Z0-9]+/)[0]
            # use first 7 chars to match GitHub
            comment = line.gsub(hex, '').strip
            next if comment == 'Update release notes'
            new_data.concat("- [#{hex[0...7]}](https://github.com/#{github_owner}/#{github_name}/commit/#{hex}) #{comment}\n")
          end
          data  = "#{new_data}\n"

          # last pair is the released version.
          notes.concat("#### #{tag_date[a]}\n\n#{data}\n")
        end

        File.open('release_notes.md', 'w') { |f| f.write notes.to_s.strip }
      end

      # Installs the local gem. It's fast due to the flags
      #
      # --no-rdoc = skip rdoc
      # --no-ri   = skip ri
      # --local   = only install from the local disk
      def _install
        _build_gem
        _uninstall
        sh "gem install --no-rdoc --no-ri --local #{gem_name}-#{version}.gem"
      end

      # Uninstalls all versions of the gem
      def _uninstall
        cmd = "gem uninstall -aIx #{gem_name}"
        # rescue from errors. avoids gem not installed error.
        sh "#{cmd}" rescue nil
      end

      # Publishes the master branch to github
      # Creates a version tag
      # Updates release notes and documentation
      # Builds the gem
      # Publishes the gem to rubygems
      def _publish
        unless `git branch`.include? "* #{branch}"
          puts 'Master branch required to release.'
          exit!
        end

        # ensure gems are installed
        `bundle update`

        # Commit then pull before pushing.
        tag_name = "v#{version}"
        raise 'Tag already exists!' if tag_exists tag_name

        # Commit then pull before pushing.
        sh "git commit --allow-empty -am 'Release #{version}'"
        sh 'git pull'
        sh "git tag #{tag_name}"

        notes_failed = false

        # update notes now that there's a new tag
        notes rescue notes_failed = true
        docs
        sh "git commit --allow-empty -am 'Update release notes'" unless notes_failed
        sh "git push origin #{branch}"
        sh "git push origin #{tag_name}"
        _build_gem
        puts "Please run 'gem push #{gem_name}-#{version}.gem'"
      end

      # Remove non-ascii bytes from all rb files in the current working directory.
      # Used to purge byte order marks that mess up YARD
      def remove_non_ascii_from_cwd
        glob = File.expand_path File.join(Dir.pwd, '**', '*.rb')
        Dir.glob(glob) do |path|
          path = File.expand_path path
          next if File.directory? path

          data = File.read path
          data = data.encode('US-ASCII', invalid: :replace, undef: :replace, replace: '')
          data = data.encode('UTF-8')
          File.open(path, 'w') { |f| f.write data }
        end
      end
    end # module Helpers
  end # module Thor
end # module Appium
