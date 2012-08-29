
package :mysql_prerequisites do
  cnf = <<CNF
mysql-server-5.5 mysql-server/root_password password #{DB_ROOT_PWD}
mysql-server-5.5 mysql-server/root_password_again password #{DB_ROOT_PWD}
mysql-server-5.5 mysql-server/start_on_boot boolean true
CNF
  push_text cnf, "/tmp/mysql_preseed"
  runner "debconf-set-selections /tmp/mysql_preseed"
end


package :mysql_apt do
  description 'MySQL Database'
  requires :dotdeb_repository
  requires :asyncio_innodb
  apt %w( mysql-server-5.5 mysql-client-5.5 libmysqlclient-dev )

  verify do
    has_apt 'mysql-server-5.5'
  end
end

package :mysql_conf do
  MY_CONFIG = File.join(::FIXTURES_DIR, "mysql_utf8.cnf")
  transfer MY_CONFIG, '/etc/mysql/conf.d/utf8.cnf', sudo: true
  runner "/etc/init.d/mysql restart"

  verify do
    has_file '/etc/mysql/conf.d/utf8.cnf'
  end
end

package :mysql_db_user do
  description "Create database and user"

  cmd = <<CMD
mysql -e "CREATE DATABASE #{DB}; GRANT ALL PRIVILEGES ON #{DB}.* TO #{DB_USER}@localhost IDENTIFIED BY '#{DB_PWD}'; FLUSH PRIVILEGES;" -u root -p #{DB_ROOT_PWD}
CMD
  runner cmd

  verify do

  end
end

package :asyncio_innodb do
  description "AsyncIO for InnoDB"
  apt %w( libaio-dev libaio1 )
  verify do
    has_apt "libaio-dev"
    has_apt "libaio1"
  end
end

package :mysql do
  requires :mysql_prerequisites
  requires :mysql_apt
  requires :mysql_conf
  requires :mysql_db_user
end
