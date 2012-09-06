#
# run as sprinkle -v -c -s ebike.rb

::PROJECT_NAME = 'ebike'

::BASE_DIR     = File.expand_path(File.dirname(__FILE__))
::PACKAGES_DIR = File.join(BASE_DIR, 'packages')
::FIXTURES_DIR = File.join(BASE_DIR, 'fixtures')
::KEYS_DIR     = File.join(BASE_DIR, 'keys')

::PROJECT_FIXTURES_DIR = File.join(FIXTURES_DIR, 'projects', PROJECT_NAME)
############################################################
# Configurations for current server setup
#
::IP           = '37.59.247.208'

::DEPLOY_USER  = "deploy"
::DEPLOY_GROUP = "deploy"

::DB           = "ebike_production"
::DB_ROOT_PWD  = "F64cPwmYRTmpAj"
::DB_USER      =  PROJECT_NAME
::DB_PWD       = "Pod434ooASw882"
############################################################

Dir.glob(PACKAGES_DIR + '/**/*.rb').each { |f| require f }

# In case of mistakes, just run:
# sudo apt-get clean
# sudo apt-get autoclean
# sudo apt-get autoremove
#
# http://stackoverflow.com/questions/2748607/how-to-thoroughly-purge-and-reinstall-postgresql-on-ubuntu
# apt-get --purge remove postgresql\*
# rm -r /etc/postgresql/
# rm -r /etc/postgresql-common/
# rm -r /var/lib/postgresql/
# userdel -r postgres
# groupdel postgres


policy :setup, :roles => :app do
  requires :sudo
  requires :essentials
  requires :locales
  requires :htop
  requires :logrotate
  requires :scm
  requires :imagemagick
  requires :ruby193
  requires :mysql
  requires :deploy_user
  requires :nginx

  requires :monit

end

deployment do
  delivery :capistrano do
    set  :user,     'root'
    set  :password, 'Msm2aujM9aaH'
    role :app,       IP
    default_run_options[:pty] = true
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
