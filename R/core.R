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
NULL

#' Make 'Mirai' 'Promise'
#'
#' Creates a 'promise' from a 'mirai'.
#'
#' @param x an object of class 'mirai'.
#'
#' @return A 'promise' object.
#'
#' @details This function is an S3 method for the generic \code{\link{as.promise}}
#'     for class 'mirai'.
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
          later(query, delay = 0.1) else
            if (is_error_value(value <- .subset2(x, "data")))
              reject(value) else
                resolve(value)
      query()
    }
  )

}
