
package :backports_repository do
  description 'Debian squeeze backport repository'

  apt_list = '/etc/apt/sources.list'
  repo = %q[
deb http://backports.debian.org/debian-backports squeeze-backports   main
]
  push_text repo, apt_list, :sudo => true do
    post :install, 'sudo apt-get update'
  end

  verify do
    file_contains "/etc/apt/sources.list", "squeeze-backports"
  end
end
