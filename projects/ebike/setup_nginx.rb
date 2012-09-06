
package :setup_nginx do
  description "Setup nginx config for application"

  target = "/etc/nginx/sites-available/#{::PROJECT_NAME}"
  transfer File.join(FIXTURES_DIR, 'nginx', 'app.production.conf'), target, render: true do
    post :install,
       "/usr/local/bin/nginxensite #{::PROJECT_NAME}",
       "/etc/init.d/nginx restart"
  end
end
