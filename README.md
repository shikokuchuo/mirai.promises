
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mirai.promises

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/mirai.promises?color=112d4e)](https://CRAN.R-project.org/package=mirai.promises)
[![mirai.promises status
badge](https://shikokuchuo.r-universe.dev/badges/mirai.promises?color=24a60e)](https://shikokuchuo.r-universe.dev)
[![R-CMD-check](https://github.com/shikokuchuo/mirai.promises/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/shikokuchuo/mirai.promises/actions/workflows/R-CMD-check.yaml)
[![Codecov](https://codecov.io/gh/shikokuchuo/mirai.promises/branch/main/graph/badge.svg)](https://app.codecov.io/gh/shikokuchuo/mirai.promises)
<!-- badges: end -->

`mirai.promises` allows the use of ‘mirai’ as ‘promises’ for easy
integration in ‘plumber’ or ‘shiny’ pipelines.

### Installation

Install the latest release from CRAN:

``` r
install.packages("mirai.promises")
```

or the development version from rOpenSci R-universe:

``` r
install.packages("mirai.promises", repos = "https://shikokuchuo.r-universe.dev")
```

### Example

Below, a plot function requiring a long compute is simulated in a
‘shiny’ app.

This app takes \~2s to start compared to the 8s that it would take if
the ‘long-running’ computations were not running in parallel workers.

``` r
library(shiny)
library(promises)
library(mirai)
library(mirai.promises)

# set 4 persistent workers
daemons(n = 4L)

ui <- fluidPage(
  fluidRow(
    plotOutput("one"),
    plotOutput("two"),
  ),
  fluidRow(
    plotOutput("three"),
    plotOutput("four"),
  )
)

make_plot <- function(time) {
  Sys.sleep(time)
  runif(10)
}

server <- function(input, output, session) {
  output$one <- renderPlot(mirai(make_plot(time), make_plot = make_plot, time = 2) %...>% plot())
  output$two <- renderPlot(mirai(make_plot(time), make_plot = make_plot, time = 2) %...>% plot())
  output$three <- renderPlot(mirai(make_plot(time), make_plot = make_plot, time = 2) %...>% plot())
  output$four <- renderPlot(mirai(make_plot(time), make_plot = make_plot, time = 2) %...>% plot())
  session$onSessionEnded(stopApp)
}

shinyApp(ui = ui, server = server)
```

### Thanks

[Daniel Falbel](https://github.com/dfalbel/) for the original version of
this example and consenting to its use here, as well as providing the
use case which motivated this package.

### Links

`mirai` website: <https://shikokuchuo.net/mirai/><br /> `mirai` on CRAN:
<https://cran.r-project.org/package=mirai>

Listed in CRAN Task View: <br /> - High Performance Computing:
<https://cran.r-project.org/view=HighPerformanceComputing>
