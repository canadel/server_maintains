# Mysql creation


package :setup_db do
  description "Create database and user"
  requires :add_db
  requires :add_db_user
end




package :add_db do
  description "Create db"

  noop do
    cmd = <<CMD
mysql -e "CREATE DATABASE IF NOT EXISTS #{DB};" -uroot -p#{DB_ROOT_PWD}
CMD
    runner cmd
  end
end




package :add_db_user do
  description "Add DB user"

  noop do
    cmd = <<CMD
mysql -e "GRANT ALL PRIVILEGES ON #{DB}.* TO #{DB_USER}@localhost IDENTIFIED BY '#{DB_PWD}'; FLUSH PRIVILEGES;" -uroot -p#{DB_ROOT_PWD}
CMD
    runner cmd
  end

  verify do
    cmd = <<CMD
mysql -e "use mysql; select user from user;" -uroot -p#{DB_ROOT_PWD} | grep #{DB_USER}
CMD
    @commands << cmd
  end
end
