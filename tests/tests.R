library(mirai.promises)
library(nanonext)
library(promises)
nanotest <- function(x) invisible(x || stop("is not TRUE when expected to be TRUE"))

s <- socket()
r <- recv_aio(s)
nanotest(is.promise(as.promise(r)))
close(s)
if (requireNamespace("mirai", quietly = TRUE)) {
  nanotest(is.promise(p1 <- as.promise(mirai::mirai("completed"))))
  nanotest(is.promise(p2 <- mirai::mirai("completed") %...>% identity()))
  nanotest(mirai.promises:::.[["freq"]] == 0.1)
  nanotest(is.null(polling(freq = 1000)))
  nanotest(mirai.promises:::.[["freq"]] == 1L)
  nanotest(is.null(polling()))
  nanotest(mirai.promises:::.[["freq"]] == 0.1)
}
Sys.sleep(3L)
