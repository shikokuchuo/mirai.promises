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

#' @importFrom mirai is_error_value unresolved
#' @importFrom later later
#' @importFrom promises as.promise promise
#'
.. <- NULL

.onLoad <- function(libname, pkgname) .. <<- `[[<-`(new.env(hash = FALSE), "freq", 0.1)

#' Make 'Mirai' 'Promise'
#'
#' Creates a 'promise' from a 'mirai' or 'recvAio'.
#'
#' @param x an object of class 'mirai' or 'recvAio'.
#'
#' @return A 'promise' object.
#'
#' @details This function is an S3 method for the generic \code{\link{as.promise}}
#'     for class 'mirai' or 'recvAio'.
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

  promise(
    function(resolve, reject) {
      query <- function()
        if (unresolved(x))
          later(query, delay = ..[["freq"]]) else
            if (is_error_value(value <- parent.env(x)[["result"]]))
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

  `[[<-`(.., "freq", freq / 1000L)
  invisible()

}
