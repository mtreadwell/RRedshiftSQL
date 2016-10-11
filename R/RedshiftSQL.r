#' @import DBI
#' @import RPostgreSQL
NULL

.PostgreSQLPkgName <- "RPostgreSQL"

setClass('RedshiftSQLDriver', contains = getClassDef('PostgreSQLDriver', package = 'RPostgreSQL'))
setAs('PostgreSQLDriver', 'RedshiftSQLDriver',
      def = function(from) methods::new('RedshiftSQLDriver', Id = methods::as(from, 'integer')))

#' Instantiate a Redshift client
#'
#' This function creates and initializes a PostgreSQL client with class
#' RedshiftSQLDriver which is simply a superclass of PostgreSQLDriver
#'
#' @export
#' @examples
#' \dontrun{
#' con <- dbConnect(RedshiftSQL(), user="u", password = "p", host="h", dbname="n", port = "5439")
#' query <- dbSendQuery(con, "SELECT * FROM table")
#' }
RedshiftSQL <- function() {
  pg <- RPostgreSQL::PostgreSQL()

  pg <- methods::as(pg, 'RedshiftSQLDriver')

  return(pg)
}

setClass('RedshiftSQLConnection', contains = getClassDef('PostgreSQLConnection', package = 'RPostgreSQL'))
setAs('PostgreSQLConnection', 'RedshiftSQLConnection',
      def = function(from) methods::new('RedshiftSQLConnection'))

setMethod("dbConnect", "RedshiftSQLDriver",
          def = function(drv, ...) redshiftsqlNewConnection(drv, ...),
          valueClass = "RedshiftSQLConnection"
)
