#
# run as sprinkle -v -c -s ebike.rb
############################################################
::BASE_DIR     = File.expand_path(File.dirname(__FILE__))
::PACKAGES_DIR = File.join(BASE_DIR, 'packages')
::FIXTURES_DIR = File.join(BASE_DIR, 'fixtures')
::KEYS_DIR     = File.join(BASE_DIR, 'keys')

::DEPLOY_USER  = "deploy"
::DEPLOY_GROUP = "deploy"

::DB           = "ebike_production"
::DB_ROOT_PWD  = "F64cPwmYRTmpAj"
::DB_USER      = "ebike"
::DB_PWD       = "Pod434ooASw882"

Dir.glob(PACKAGES_DIR + '/*.rb').each { |f| require f }

############################################################
# sudo apt-get clean
# sudo apt-get autoclean
# sudo apt-get autoremove

IP = '37.59.247.208'

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
