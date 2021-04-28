# Modèle de documents pour le projet `utilitR`

<!-- badges: start -->
[![R build status](https://github.com/InseeFrLab/utilitr-template/workflows/R-CMD-check/badge.svg)](https://github.com/InseeFrLab/utilitr-template/actions)
[![Exemple output](https://github.com/InseeFrLab/utilitr-template/workflows/Example%20output/badge.svg)](https://github.com/InseeFrLab/utilitr-template/actions)
<!-- badges: end -->

This package aims to simplify the formatting of [utilitR](www.book.utilitr.org)
documentation. A series of function to customize `rmarkdown` output is proposed
in this package. An example website built using this package
can be found [here](https://awesome-volhard-d6d842.netlify.app)

You can use 

```r
rmarkdown::draft('index.Rmd', template="utilitr", package="utilitr", edit = FALSE)
```

or `File > new File > R Markdown > FromTemplate > Modèle documentation utilitR`
(in that case make sure to change the `.Rmd` filename into `index.Rmd`) to 
create a MWE of the output format. 

You can either generate a static website or a PDF book using our package:

* Static website can be generated using `bookdown` with the following 
command: 
```r
bookdown::render_book("index.Rmd", output_dir = "_public", output_format = "utilitr::html_document")
```
* PDF book can be generated using our `pdf_document` function that uses
`pagedown` package under the hood:
```r
utilitr::pdf_document()
```
