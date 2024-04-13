# mirai.promises 0.5.0

* Updates promises method for improved integration with Shiny (thanks @jcheng5).
* Adds is.promising() method for 'recvAio'.
* Requires promises >= 1.3.0 and nanonext >= 0.13.3.

# mirai.promises 0.4.1

* Performance enhancements.

# mirai.promises 0.4.0

* Modified dependencies to be minimal and support more use cases:
  - No longer depends on any packages, these should be attached as required.
  - Imports `nanonext` instead of `mirai`.
  - Suggests `mirai`.
* Performance enhancements.

# mirai.promises 0.3.1

* Documents that importing `polling()` in a package allows access to the S3 methods.
* Depends on `mirai` and `promises` so no longer necessary to attach all 3 packages.

# mirai.promises 0.3.0

* Implements `polling()` as a more efficient mechanism for setting the polling time for promise resolution, retiring the option 'mirai.promises'.

# mirai.promises 0.2.0

* Switches to using the option 'mirai.promises' rather than an environment variable to set the polling time (deault 0.1s).
* Permits using `options(mirai.promises = <numeric value>)` to set and `getOption("mirai.promises")` to view the set value at any time.

# mirai.promises 0.1.2

* The `MIRAI_PROMISES` environment variable is now checked on package load for a custom frequency with which to poll for promise resolution.
* Performance enhancements.

# mirai.promises 0.1.1

* Adds `as.promise.recvAio` as an alias, supporting 'recvAio' asynchronous message receives from the `nanonext` package.

# mirai.promises 0.1.0

* Initial CRAN release.

# mirai.promises 0.0.2

* Adds readme example (thanks @dfalbel).

# mirai.promises 0.0.1

* Initial release.
