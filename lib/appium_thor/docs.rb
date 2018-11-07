module Appium
  module Thor
    module Docs
      def space amount
        '&nbsp;' * amount
      end

      def last_sha
        `git rev-parse --verify HEAD`.strip
      end

      def mobj_to_md obj
        out = ''
        # skip objects without method signatures
        sig = obj.signature
        return out unless sig

        # skip class vars
        if sig.start_with?('@@') ||
          # skip methods marked private
          obj.tag('private') ||
          # skip date and version from version.rb
          obj.name.match(/DATE|VERSION/)
          return out
        end

        method_path = obj.file.split('/lib/').last
        os = method_path.downcase.match /ios|android/
        out.concat("##### [#{obj.name.to_s}](https://github.com/#{github_owner}/#{github_name}/blob/#{last_sha}/lib/#{method_path}#L#{obj.line}) #{os}\n\n")
        out.concat("> #{obj.signature}\n\n")
        out.concat("#{obj.docstring}\n\n")


        indent = space 5
        params = obj.tags.select { |tag| tag.tag_name == 'param' }
        unless params.empty?
          out.concat("__Parameters:__\n\n")
          params.each do |param|
            out.concat("#{indent}[#{param.types.join ', '}] ")
            out.concat("#{param.name} - #{param.text}\n\n")
          end
        end

        ret = obj.tag 'return'
        if ret
          out.concat("__Returns:__\n\n")
          out.concat("#{indent}[#{ret.types.join ', '}] #{ret.text}\n\n")
        end
        out.concat("--\n\n")

        out
      end

      def run(out_file, globs)
        YARD::Registry.clear
        puts "Globbing: #{globs}"
        puts "Writing: #{out_file}"
        FileUtils.mkdir_p File.dirname out_file
        YARD::Parser::SourceParser.parse globs
        File.open(out_file, 'w') do |file|
          entries        = YARD::Registry.entries
          entries_length = entries.length
          puts "Processing: #{entries_length} entries"
          raise 'No entries to process' if entries_length <= 0
          YARD::Registry.entries.each do |entry|
            file.write mobj_to_md entry
          end
        end

        raise 'Empty file generated' if File.size(out_file) <= 0
      end

      def globs(paths)
        # Convert single string to array for map
        paths = [paths] unless paths.kind_of? Array
        # Adjust path based on system
        paths.map! { |path| "#{Dir.pwd}#{path}" }
      end
    end
  end
end