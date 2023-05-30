library(mirai.promises)
`%...>%` <- promises::`%...>%`
nanotest <- function(x) invisible(x || stop("is not TRUE when expected to be TRUE"))
nanotest(promises::is.promise(p1 <- promises::as.promise(mirai::mirai("completed"))))
Sys.sleep(2.5)
nanotest(promises::is.promise(p2 <- mirai::mirai("completed") %...>% identity()))
Sys.sleep(2.5)
