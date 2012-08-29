
package :mongodb do
  description "Mongo document oriented database"
  requires :mongodb_repository
  apt "mongodb-10gen"
  verify do
    has_executable "mongod"
    has_executable "mongo"
  end
end
