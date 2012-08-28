package :dotweb_repository do
  description 'Dotweb packages repository'

  apt_list = '/etc/apt/sources.list'
  dotweb_repo = %q[
deb http://packages.dotdeb.org squeeze all
deb-src http://packages.dotdeb.org squeeze all
]
  push_text dotweb_repo, apt_list, :sudo => true do
    pre :install, 'wget -q http://www.dotdeb.org/dotdeb.gpg -O -| sudo apt-key add -'
    pre :install, 'sudo apt-get update'
  end

  verify do
    file_contains "/etc/apt/sources.list", "dotdeb"
  end
end
