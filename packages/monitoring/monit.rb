
package :monit do
  description 'Monit - Provides process monitoring'
  apt 'monit'

  verify do
    has_executable 'monit'

    has_file '/etc/init.d/monit'
    has_file '/etc/logrotate.d/monit'
  end
end


package :monit_nginx do
  description 'Monitoring nginx'
  requires :monit, :nginx

  config = File.join(FIXTURES_DIR, 'monitoring', 'monit.rc.nginx')
  target = "/etc/monit/conf.d/monit.rc.nginx"
  transfer config, target

  verify do
    has_file '/etc/monit/conf.d/monit.rc.nginx'
  end
end


package :monit_ssh do
  description 'Monitoring sshd daemon'
  requires :monit

  config = File.join(FIXTURES_DIR, 'monitoring', 'monit.rc.ssh')
  target = "/etc/monit/conf.d/monit.rc.ssh"
  transfer config, target

  verify do
    has_file '/etc/monit/conf.d/monit.rc.ssh'
  end
end
