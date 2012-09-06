package :setup_unicorn do
  description "Setup unicorn runner service"

  unicorn_runner = File.join(::PROJECT_FIXTURES_DIR, 'unicorn')
  target_service = "/etc/init.d/unicorn_#{::PROJECT_NAME}"

  transfer unicorn_runner, target_service, render: true do
    post :install,
          "/etc/init.d/monit restart",
          "chmod +x /etc/init.d/unicorn_#{::PROJECT_NAME}"
  end

  verify do
    has_file "/etc/init.d/unicorn_#{PROJECT_NAME}"
  end
end
