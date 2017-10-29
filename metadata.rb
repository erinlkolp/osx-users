name 'osx-users'
maintainer 'Erin L. Kolp'
maintainer_email 'erinlkolpfoss@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures osx-users'
long_description 'Installs/Configures osx-users'
version '0.2.1'

chef_version '>= 12.15' if respond_to?(:chef_version)

issues_url 'https://github.com/erinlkolp/osx-users/issues'
source_url 'https://github.com/erinlkolp/osx-users'

%w{mac_os_x darwin}.each do |os|
  supports os
end

