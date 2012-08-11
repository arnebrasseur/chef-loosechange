maintainer        "Arne Brasseur"
maintainer_email  "arne.brasseur@gmail.com"
license           "Apache 2.0"
description       "Assorted small Chef recipes"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "make-backups", "Install make_backups.sh"

%w{ ubuntu debian fedora suse }.each do |os|
  supports os
end

%w{ redhat centos scientific }.each do |el|
  supports el, ">= 6.0"
end

