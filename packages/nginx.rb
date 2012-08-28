
package :nginx do
  description "Vanilla nginx install with modules"
  requires :dotweb_repository, :pcre

  apt 'nginx' do
    pre :install, 'apt-get update'
  end

  verify do
    has_apt "nginx"
  end
end
