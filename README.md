<!-- README.md is generated from README.Rmd. Please edit that file -->
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/EDiLD/rartenfinder?branch=master&svg=true)](https://ci.appveyor.com/project/EDiLD/rartenfinder) [![Travis-CI Build Status](https://travis-ci.org/EDiLD/rartenfinder.svg?branch=master)](https://travis-ci.org/EDiLD/rartenfinder) [![Coverage Status](https://img.shields.io/codecov/c/github/EDiLD/rartenfinder/master.svg)](https://codecov.io/github/EDiLD/rartenfinder?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rartenfinder)](https://cran.r-project.org/package=rartenfinder)

rartenfinder
============

R Client for the artenfinder API (<http://artenfinder.rlp.de>)

Installation
------------

### Development version from GitHub

``` r
install.packages("devtools")
devtools::install_github("EDiLD/rartenfinder")
```

``` r
library('rartenfinder')
library('magrittr')
```

taxagroups
----------

This is a basic example which shows you how to solve a common problem:

``` r
get_taxagroups() %>%
  head()
#>   id         name_deutsch is_animal
#> 1 28 Gefäß-Sporenpflanzen     FALSE
#> 2 26          Nachtfalter      TRUE
#> 3 25              Spinnen      TRUE
#> 4 24          Zweiflügler      TRUE
#> 5 23          Netzflügler      TRUE
#> 6 22               Wanzen      TRUE
```
