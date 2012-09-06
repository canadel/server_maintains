
package :setup_monit do
  description "Setup monit project config"

  config = File.join(::PROJECT_FIXTURES_DIR, 'monit.rc.project')
  target = "/etc/monit/conf.d/monit.rc.#{PROJECT_NAME}"

  transfer config, target, render: true do
    post :install, "/etc/init.d/monit restart"
  end

  verify do
    has_file "/etc/monit/conf.d/monit.rc.#{PROJECT_NAME}"
  end
end
