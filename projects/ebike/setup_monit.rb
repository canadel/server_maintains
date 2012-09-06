package :setup_monit do
  description "Setup monit project config"

  config = File.join(PROJECT_FIXTURES_DIR, 'monit.rc.project')
  target = "/etc/monit/conf.d/monit.rc.#{PROJECT_NAME}"

  project_name = PROJECT_NAME
  project_user = DEPLOY_USER
  project_deploy_path = PROJECT_DEPLOY_PATH
  transfer config, target, render: true do
  end

  verify do
    has_file "/etc/monit/conf.d/monit.rc.#{PROJECT_NAME}"
  end
end
