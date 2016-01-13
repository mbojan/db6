#' Database connector object
#'
#' Creating and using database connector objects.
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @format An R6 class generator object
#' @keywords data
#' @rdname DB
#' @examples
#' z <- db( RSQLite::SQLite(), dbname=":memory:")
#' z$show()
#' z$list_tables()
#' z$write_table(name="mtcars", value=mtcars)
#' z$list_tables()
#' z$read_table("mtcars")
#' z$disconnect()
#' z$show()


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
    },

    get_query = function(...) {
      DBI::dbGetQuery(self$con, ...)
    },

    list_tables = function(...) {
      DBI::dbListTables(self$con, ...)
    },

    list_fields = function(...) {
      DBI::dbListFields(self$con, ...)
    },

    send_query = function(...) {
      DBI::dbSendQuery(self$con, ...)
    },

    write_table = function(...) {
      DBI::dbWriteTable(self$con, ...)
    },

    read_table = function(...) {
      DBI::dbReadTable(self$con, ...)
    }
  ),
  private = list (
    has_tables = function(table_names) {
      stopifnot(is.character(table_names))
      rval <- table_names %in% self$list_tables()
      names(rval) <- table_names
      rval
    }
  )
)




#' @export
#' @rdname DB
#' @aliases db
#' @param drv database driver object, see \code{\link{dbConnect}}
#' @details
#' Function \code{db} is used
db <- function(drv, ...) {
  DB$new(
    DBI::dbConnect(drv=drv, ...)
  )
}





if(FALSE) {
  z <- db( RSQLite::SQLite(), dbname=":memory:")
  z$show()
  z$list_tables()
  z$write_table(name="mtcars", value=mtcars)
  z$list_tables()
  z$read_table("mtcars")
  z$disconnect()
  z$show()
}
