
package :mongodb_repository do
  description 'Mongodb packages repository'

  apt_list = '/etc/apt/sources.list'
  mongodb_repo = %q[
# mongodb repository
deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen
]
  push_text mongodb_repo, apt_list, :sudo => true do
    pre  :install, "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    post :install, "sudo apt-get update"
  end

  verify do
    file_contains "/etc/apt/sources.list", "mongodb"
  end
end
