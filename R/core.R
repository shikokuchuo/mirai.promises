# Copyright (C) 2023 Hibiki AI Limited <info@hibiki-ai.com>
#
# This file is part of mirai.promises.
#
# mirai.promises is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# mirai.promises is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# mirai.promises. If not, see <https://www.gnu.org/licenses/>.

# mirai.promises ---------------------------------------------------------------

#' mirai.promises: Make 'Mirai' 'Promises'
#'
#' Allows 'mirai' objects encapsulating asynchronous computations, from the
#'     \CRANpkg{mirai} package by Gao (2023), to be used interchangeably with
#'     'promise' objects from the \CRANpkg{promises} package by Cheng (2021).
#'     This facilitates their use with packages \CRANpkg{plumber} by Schloerke
#'     and Allen (2022) and \CRANpkg{shiny} by Cheng, Allaire, Sievert,
#'     Schloerke, Xie, Allen, McPherson, Dipert and Borges (2022).
#'
#' @section Notes:
#'
#'     This package provides the methods \code{\link{as.promise.mirai}} and
#'     \code{\link{as.promise.recvAio}} for the S3 generic
#'     \code{\link{as.promise}} exported by the 'promises' package.
#'
#'     An auxiliary function \code{\link{polling}} provides the additional
#'     option to tune the frequency at which 'mirai' are checked for resolution.
#'
#'     Package authors wishing to use the S3 methods may simply import the
#'     function \code{\link{polling}} to make them available.
#'
#' @section Links:
#'
#'     \CRANpkg{mirai} website: \url{https://shikokuchuo.net/mirai/}
#'
#'     \CRANpkg{nanonext} website: \url{https://shikokuchuo.net/nanonext/}
#'
#'     NNG website: \url{https://nng.nanomsg.org/}
#'
#' @encoding UTF-8
#' @author Charlie Gao \email{charlie.gao@@shikokuchuo.net}
#'     (\href{https://orcid.org/0000-0002-0750-061X}{ORCID})
#'
#' @importFrom nanonext is_error_value unresolved
#' @importFrom promises as.promise promise
#'
#' @docType package
#' @name mirai.promises-package
#'
NULL

# nocov start
# tested implicitly

.onLoad <- function(libname, pkgname) {

  as.promise.recvAio <<- as.promise.mirai <<- as.promise.mirai()

}

# nocov end

#' Make 'Mirai' 'Promise'
#'
#' Creates a 'promise' from a 'mirai' or 'recvAio'.
#'
#' @param x an object of class 'mirai' or 'recvAio'.
#'
#' @return A 'promise' object.
#'
#' @details This function is an S3 method for the generic
#'     \code{\link{as.promise}} for class 'mirai' or 'recvAio'.
#'
#'     \code{\link{polling}} may be used to customise the frequency with which
#'     to poll for promise resolution (defaults to every 100 milliseconds).
#'
#' @examples
#' if (interactive()) {
#' # Only run examples in interactive R sessions
#'
#' p <- promises::as.promise(mirai::mirai("example"))
#' print(p)
#' promises::is.promise(p)
#'
#' }
#'
#' @method as.promise mirai
#' @export
#'
as.promise.mirai <- function(x) {
  later <- .getNamespace("later")[["later"]]
  pollfreq <- 0.1
  function(x)
    promise(
      function(resolve, reject) {
        query <- function()
          if (unresolved(x))
            later(query, delay = pollfreq) else
              if (is_error_value(value <- .subset2(x, "value")))
                reject(value) else
                  resolve(value)
        query()
      }
    )
}

#' @rdname as.promise.mirai
#' @method as.promise recvAio
#' @export
#'
as.promise.recvAio <- as.promise.mirai

#' Set Polling Frequency
#'
#' Set the frequency with which to poll for promise resolution (the default
#'     being 100 milliseconds).
#'
#' @param freq [default 100L] integer number of milliseconds.
#'
#' @return Invisible NULL.
#'
#' @examples
#' # set polling frequency to 1s
#' polling(freq = 1000L)
#'
#' # reset polling frequency to default 100 ms
#' polling()
#'
#' @export
#'
polling <- function(freq = 100L) {

  is.numeric(freq) || stop("'freq' must be a numeric value")
  `[[<-`(environment(as.promise.mirai), "pollfreq", freq / 1000L)
  invisible()

}
