package :postgres_configuration do
  description ' Configure PostgreSQL database'
  requires :postgresql

  PG_CONFIG = File.join(::FIXTURES_DIR, "pg_hba.conf")

  transfer PG_CONFIG, '/etc/postgresql/9.2/main/pg_hba.conf', sudo: true
  runner "/etc/init.d/postgresql restart"

end

# http://stackoverflow.com/questions/2748607/how-to-thoroughly-purge-and-reinstall-postgresql-on-ubuntu
# apt-get --purge remove postgresql\*
# rm -r /etc/postgresql/
# rm -r /etc/postgresql-common/
# rm -r /var/lib/postgresql/
# userdel -r postgres
# groupdel postgres

package :postgresql do
  description 'PostgreSQL database'
  requires :pgapt_repository

  apt %w( postgresql-9.2 postgresql-client-9.2 libpq-dev )

  verify do
    has_executable 'psql'
    has_version    'psql', '9.2', '-V'
  end
end

package :pg_user do

end


package :pg_install do
  requires :postgresql
  requires :postgres_configuration
  requires :pg_user
end
