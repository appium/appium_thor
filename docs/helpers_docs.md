##### [_build_gem](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L6) common

> def _build_gem

Sets the permissions on the gem credentials
Runs gem build gemspec

--

##### [tag_exists](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L12) common

> def tag_exists(tag_name)

Returns true if the tag exists on the master branch.

--

##### [sh](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L18) common

> def sh(command)

Runs command. Raises an exception if the command doesn't execute successfully.

--

##### [version_rgx](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L30) common

> def version_rgx

Used to parse the version number from version_file

--

##### [version](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L35) common

> def version

Returns the version number from version_file as a string

--

##### [_bump](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L46) common

> def _bump(value)

Updates the date and version in version_file.
Prints the new version and date to the console.
The date is not printed if it hasn't changed.

x.y.z

__Parameters:__

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[symbol] value - value is either :x, :y, or :z. Default is z.

--

##### [update_release_notes](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L86) common

> def update_release_notes

Creates release_notes.md based on changes between tags.
Note that the first tag won't contain notes.

--

##### [_install](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L150) common

> def _install

Installs the local gem. It's fast due to the flags

--no-rdoc = skip rdoc
--no-ri   = skip ri
--local   = only install from the local disk

--

##### [_uninstall](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L157) common

> def _uninstall

Uninstalls all versions of the gem

--

##### [_publish](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L168) common

> def _publish

Publishes the master branch to github
Creates a version tag
Updates release notes and documentation
Builds the gem
Publishes the gem to rubygems

--

##### [remove_non_ascii_from_cwd](https://github.com/appium/appium_thor/blob/5c7025a14e9a6dba1ff0f69b733983d965e9c2ee/lib/appium_thor/helpers.rb#L200) common

> def remove_non_ascii_from_cwd

Remove non-ascii bytes from all rb files in the current working directory.
Used to purge byte order marks that mess up YARD

--

