#' Database connector objects
#'
#' Implementation of two R6 classes and their generators for creating database connector objects.
#' Class "DBpub" implements all standard database interaction methods
#' (as in package \pkg{DBI}) as \emph{public} methods.
#' Class "DBprv" is identical, but with these methods implemented as \emph{private} methods.
#'
#' @format R6 class generator objects
#'
#' @section Methods:
#' Implemented methods:
#' \describe{
#' \item{get_query(...)}{execute arbitrary SQL query, see \code{\link{dbGetQuery}}}
#' \item{list_tables(...)}{list tables in DB}
#' \item{list_fields(...)}{list fields of a table}
#' \item{send_query(...)}{send query}
#' \item{write_table(...)}{write a data frame to a DB table}
#' \item{read_table(...)}{read a DB table, return a data frame}
#' \item{has_tables(table_names)}{check if tables with names \code{table_names} exist in DB}
#' }
#'
#' @docType class
#' @importFrom R6 R6Class
#' @keywords data
#' @example man-roxygen/db.R




#' @export
#' @rdname DB
DBpub <- R6::R6Class(
  "DBpub",
  inherit=DB,
  public = list(
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
    },

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
DBprv <- R6::R6Class(
  "DBprv",
  inherit=DB,
  private = list(
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
    },

    has_tables = function(table_names) {
      stopifnot(is.character(table_names))
      rval <- table_names %in% self$list_tables()
      names(rval) <- table_names
      rval
    }
  )
)
