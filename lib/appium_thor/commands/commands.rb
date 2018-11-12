# Define Thor tasks in the top level Default namespace.
class Default < Thor
  desc 'info', 'prints config info for this gem'
  def info
    puts <<-MSG
    gem_name: #{gem_name}
 github_name: #{github_name}
github_owner: #{github_owner}
version_file: #{version_file}
    MSG
  end

  desc 'bumpx', 'Bump the x version number, set y & z to zero, update the date.'
  def bumpx
    _bump :x
  end

  desc 'bumpy', 'Bump the y version number, set z to zero, update the date.'
  def bumpy
    _bump :y
  end

  desc 'bump', 'Bump the z version number and update the date.'
  def bump
    _bump :z
  end

  desc 'publish', 'Build and release a new gem to rubygems.org'
  def publish
    _publish
  end

  desc 'release', 'Build and release a new gem to rubygems.org (same as publish)'
  def release
    _publish
  end

  desc 'build', 'Build a new gem'
  def build
    _build_gem
  end

  # uninstall is a reserved task name
  # https://github.com/erikhuda/thor/issues/428
  desc 'gem_uninstall', 'Uninstall gem'
  def gem_uninstall
    _uninstall
  end

  # install is a reserved task name
  # https://github.com/erikhuda/thor/issues/428
  desc 'gem_install', 'Install gem'
  def gem_install
    _install
  end

  desc 'docs', 'Update docs'
  def docs
    instance_eval &docs_block if docs_block
  end

  desc 'notes', 'Update release notes'
  def notes
    update_release_notes
  end

  desc 'byte', 'Remove non-ascii bytes from all *.rb files in the current dir'
  def byte
    remove_non_ascii_from_cwd
  end
end