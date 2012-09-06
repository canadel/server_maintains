
package :monit do
  description 'Monit - Provides process monitoring'
  apt 'monit'

  verify do
    has_executable 'monit'

    has_file '/etc/init.d/monit'
    has_file '/etc/logrotate.d/monit'
  end
end
