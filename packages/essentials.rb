
package :sudo do
  description "Install sudo in case if it not installed yet"
  apt 'sudo'
  verify do
    has_executable 'sudo'
  end
end

package :locales do
  description "Configure locales"
  apt "debconf" do
    pre "apt-get update"
    post "dpkg-reconfigure locales"
  end

  verify do
    has_apt "debconf"
  end
end


package :essentials do
  description 'Build tools required for building linux apps from source'
  apt %w( build-essential
          libxslt1-dev libxml2 libxml2-dev
          libreadline6-dev libreadline6
          libyaml-dev
          autoconf automake bison
          libc6-dev libncurses5-dev
          zlib1g zlib1g-dev
          libssl-dev
          curl ) do
    pre :install, ['aptitude update', 'aptitude safe-upgrade', 'aptitude full-upgrade']
  end

  verify do
    has_apt "build-essential"
    has_apt "libxslt1-dev"
    has_apt "libxml2"
    has_apt "libreadline6-dev"
    has_apt "libreadline6"
    has_apt "libc6-dev"
    has_apt "libncurses5-dev"
    has_apt "libyaml-dev"
    has_apt "libssl-dev"
    has_apt "autoconf"
    has_apt "automake"
    has_apt "bison"
    has_apt "curl"
  end
end

package :htop do
  description "More powerful version of top utilite"
  apt 'htop'

  verify do
    has_executable 'htop'
  end
end

package :logrotate do
  apt 'logrotate'

  verify do
    has_executable 'logrotate'
  end
end


package :pcre do
  description "RegExp library (for nginx)"
  apt %w( libpcre3 libpcre3-dev libpcrecpp0 )

  verify do
    has_apt "libpcre3"
    has_apt "libpcre3-dev"
    has_apt "libpcrecpp0"
  end
end
