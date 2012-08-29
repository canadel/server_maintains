
package :sqlite3 do
  description "SQLite3 Database"
  apt "libsqlite3-dev"

  verify do
    has_executable 'sqlite3'
  end

end
