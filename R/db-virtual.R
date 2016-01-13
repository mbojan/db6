# Virtual class for database connectors
DB <- R6::R6Class(
  "DB",
  public = list(
    con=NA,

    initialize = function(con) {
      if( !missing(con) ) self$con <- con
    },

    is_valid = function() {
      DBI::dbIsValid(self$con)
    },

    show = function() {
      cat("DB connection", class(self$con),
          ifelse( self$is_valid(), "IS", "IS NOT"),
          "valid\n")
      cat("Database name:", self$con@dbname)
    },

    disconnect = function() {
      DBI::dbDisconnect(self$con)
    }
  )
)
