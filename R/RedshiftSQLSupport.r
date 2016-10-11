redshiftsqlNewConnection <- function(drv, user = "", password = "",
                                    host = "", dbname = "",
                                    port = "", tty = "", options = "", forceISOdate=TRUE) {
  if(!RPostgreSQL::isPostgresqlIdCurrent(drv))
    stop("expired manager")
  if(is.null(user))
    stop("user argument cannot be NULL")
  if(is.null(password))
    stop("password argument cannot be NULL")
  if(is.null(dbname))
    stop("dbname argument cannot be NULL")
  if(is.null(port))
    stop("port argument cannot be NULL")
  if(is.null(tty))
    stop("tty argument cannot be NULL")

  con.params <- as.character(c(user, password, host,
                               dbname, port,
                               tty, options))

  drvId <- methods::as(drv, "integer")
  conId <- .Call("RS_PostgreSQL_newConnection", drvId, con.params, PACKAGE = .PostgreSQLPkgName)
  con <- methods::new("RedshiftSQLConnection", Id = conId)
  if(forceISOdate){
    DBI::dbGetQuery(con, "set datestyle to ISO")
  }
  con
}
