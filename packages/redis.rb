
package :redis do
  requires :build_essentials
  REDIS_VERSION = "2.4.16"
  source "http://redis.googlecode.com/files/redis-#{REDIS_VERSION}.tar.gz" do
    pre :install, "killall -9 redis-server || true"
    custom_install 'make install'
  end
  verify do
    has_executable 'redis-server'
    has_executable_with_version('redis-server', REDIS_VERSION, '--version')
  end
end

package :redis_service do
  REDIS_CONFIG = File.join(File.dirname(__FILE__), '..', 'fixtures', 'redis.conf')
  requires :redis
  transfer REDIS_CONFIG, 'redis.conf', :sudo => true do
    pre :install, "rm -f /etc/redis.conf"
    pre :install, "sudo adduser redis --system --no-create-home --disabled-password --disabled-login --group"
    post :install, "sudo mkdir -p /etc/redis"
    post :install, "sudo mkdir -p /var/db/redis"
    post :install, "sudo mv redis.conf /etc/redis/6379.conf"
  end
  transfer REDIS_CONFIG, 'redis', :sudo => true do
    post :install, "cp redis /etc/init.d/redis"
    post :install, "sudo chmod +x /etc/init.d/redis"
    post :install, "sudo update-rc.d redis defaults"
    # need a sleep here so the shell can actually fork before we terminate the session
    post :install, "sudo /etc/init.d/redis start && sleep 1"
  end

  verify do
    has_file '/etc/init.d/redis'
    has_process 'redis'
  end
end
