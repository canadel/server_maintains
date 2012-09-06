package :setup_unicorn do
  description "Setup unicorn runner service"

  unicorn_runner = File.join(PROJECT_FIXTURES_DIR, 'unicorn')
  target_service = "/etc/init.d/unicorn_#{PROJECT_NAME}"

  project_name = PROJECT_NAME
  project_user = DEPLOY_USER
  project_deploy_path = PROJECT_DEPLOY_PATH
  transfer unicorn_runner, target_service, render: true do
  end

  verify do
    has_file "/etc/init.d/unicorn_#{PROJECT_NAME}"
  end
end
