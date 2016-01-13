# Using public version

z <- DBpub$new( DBI::dbConnect(RSQLite::SQLite(), dbname=":memory:") )
z$show()
z$list_tables()
z$write_table(name="mtcars", value=mtcars)
z$list_tables()
z$read_table("mtcars")
z$disconnect()
z$show()


# Implementing an encapsulated interface.
#
# Useful in large computations in which it is useful to have a *persistent*
# status of cases that need to be processed. Persistence is useful if something
# goes wrong (R crashes etc.)
#
# Possible usecases:
#
# - Lengthy simulations that need to be run on many parameter configurations.
# - www harvesting

# Interface
dblog <- R6::R6Class(
  "dblog",
  inherit=DBprv,
  public = list(

    check_status = function(i) {
      super$get_query( paste0("SELECT status FROM chunks WHERE id=", i))
    },

    set_done = function(i) {
      super$get_query(paste0("UPDATE chunks SET status=1 WHERE id=", i))
    },

    show_notdone = function() {
      super$get_query(paste0("SELECT id FROM chunks WHERE status=0"))
    }
  )
  )

# Connect
db <- dblog$new( DBI::dbConnect(RSQLite::SQLite(), dbname=":memory:") )

# Set up the table with case ids
d <- data.frame(id=1:5, status=0)
DBI::dbWriteTable(db$con, "chunks", d)

db$show_notdone()

# ...
# processing for id=3
# ...

# mark as done
db$set_done(3)

# what's left to do?
db$show_notdone()

# destroy
db$disconnect()
