#
# rub as sprinkle -v -c -s ebike.rb

::BASE_DIR     = File.expand_path(File.dirname(__FILE__))
::PACKAGES_DIR = File.join(BASE_DIR, 'packages')
::FIXTURES_DIR = File.join(BASE_DIR, 'fixtures')
::KEYS_DIR     = File.join(BASE_DIR, 'keys')
Dir.glob(PACKAGES_DIR + '/*.rb').each { |f| require f }

# IP:           37.59.247.208
# Benutzername: root
# Passwort:     Msm2aujM9aaH
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
  requires :database
  requires :postgres_configuration
  requires :deploy
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
