library(mirai.promises)
library(promises)
nanotest <- function(x) invisible(x || stop("is not TRUE when expected to be TRUE"))

nanotest(promises::is.promise(p1 <- promises::as.promise(mirai::mirai("completed"))))
nanotest(promises::is.promise(p2 <- promises::as.promise(mirai::mirai(mirai::mirai()))))
nanotest(promises::is.promise(p3 <- mirai::mirai("completed") %...>% identity()))
