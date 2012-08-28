package :ruby193 do
  description "Ruby 1.9.3 from source"
  requires :ruby_dependencies
  version '1.9.3-p194'

  binaries = %w(erb gem irb rake rdoc ruby)
  source "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{version}.tar.gz" do
    post :install, "gem install bundler"
  end

  verify do
    has_executable_with_version "ruby", "p194"
    has_executable 'bundle'
  end
end

package :ruby_dependencies do
  apt %w(zlib1g-dev libreadline6-dev libssl-dev)
  requires :essentials

  verify do
    has_apt "zlib1g-dev"
    has_apt "libreadline6-dev"
    has_apt "libssl-dev"
  end
end
