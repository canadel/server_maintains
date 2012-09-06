
package :nginx do
  description "Vanilla nginx install with modules"
  requires :dotweb_repository, :pcre, :nginx_helper_bins

  apt 'nginx' do
    pre :install, 'apt-get update'
  end

  verify do
    has_apt "nginx"
  end
end


package :nginx_helper_bins do
  description "Install helpers scripts"

  transfer File.join(FIXTURES_DIR, 'nginxdissite'), '/usr/local/bin/nginxdissite' do
    post :install, 'chmod +x /usr/local/bin/nginxdissite'
  end

  transfer File.join(FIXTURES_DIR, 'nginxensite'), '/usr/local/bin/nginxensite' do
    post :install, 'chmod +x /usr/local/bin/nginxensite'
  end

end
