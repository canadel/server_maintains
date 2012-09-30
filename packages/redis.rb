
package :redis do
  description "Redis key-value cache"
  requires :dotweb_repository

  apt "redis-server" do
    pre :install, "apt-get update"
  end

  verify do
    has_executable 'redis-server'
  end
end
