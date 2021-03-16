testthat::context("Manual check for the documentation")


destdir <- tempdir()

unlink(sprintf("%s/test-utilitr", destdir))
dir.create(sprintf("%s/test-utilitr", destdir))

setwd(sprintf("%s/test-utilitr", destdir))


rmarkdown::draft("index.Rmd", template='utilitr', package='utilitr', edit = FALSE)

testthat::test_that(
  "We produce the html", {
    testthat::skip_on_ci()
    bookdown::render_book(sprintf("%s/test-utilitr/index.Rmd", destdir),
                          output_dir = sprintf("%s/test-utilitr/_public", destdir),
                          output_format = 'utilitr::html_document')
    rstudioapi::viewer("_public/index.html")
  }
)

