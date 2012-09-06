
package :nginx do
  description "Vanilla nginx install with modules"
  requires :dotdeb_repository
  requires :pcre
  requires :nginx_apt
  requires :nginx_helper_bins
  requires :nginx_conf
end

package :nginx_apt do
  description "Nginx install apt"
  apt 'nginx' do
    pre :install, 'apt-get update'
  end

  verify do
    has_apt "nginx"
  end
end



package :nginx_helper_bins do
  description "Install helpers scripts"

  transfer File.join(::FIXTURES_DIR, 'nginx', 'nginxdissite'), '/usr/local/bin/nginxdissite' do
    post :install, 'chmod +x /usr/local/bin/nginxdissite'
  end

  transfer File.join(::FIXTURES_DIR, 'nginx', 'nginxensite'), '/usr/local/bin/nginxensite' do
    post :install, 'chmod +x /usr/local/bin/nginxensite'
  end

  verify do
    has_file '/usr/local/bin/nginxdissite'
    has_file '/usr/local/bin/nginxensite'
  end
end

package :nginx_conf do
  description "Transfer nginx config"

  transfer File.join(::FIXTURES_DIR, 'nginx', 'nginx.conf'), '/etc/nginx/nginx.conf', render: true do
    pre  :install, "mkdir -p /var/log/nginx"
    post :install, "/etc/init.d/nginx restart"
  end

end
