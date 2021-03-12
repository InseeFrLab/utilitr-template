# inspired by mitchell O'Hara-Wild vitae package : https://github.com/mitchelloharawild/vitae/blob/master/tests/testthat/test-template.R
# borrowed from https://github.com/spyrales/gouvdown/blob/master/tests/testthat/test-rmarkdown.R

expect_render <- function(template){

  outputdir <- tempfile()
  dir.create(outputdir)
  file.copy(system.file("rmarkdown", "templates", template, "skeleton", package = "utilitr"),
            outputdir,
            recursive = TRUE)
  file <- file.path(outputdir, "skeleton", "skeleton.Rmd")
  testthat::expect_output(
    testthat::expect_message(
      rmarkdown::render(
        file,
        output_dir = outputdir),
      "Output created"),
    "pandoc")
}

testthat::test_that("utilitr_html_document", {
  expect_render("utilitr")
})


# outputdir <- paste0(tempdir(), "/test_rmd")
# outputdir <- getwd()
# if (!dir.exists(outputdir)) dir.create(outputdir)
# rmarkdown::draft(sprintf("%s/index.Rmd", outputdir),
#                  template="utilitr", package="utilitr",
#                  edit = FALSE)
# testthat::test_that("We create skeleton", {
#   testthat::expect_equal(
#     list.files(outputdir, recursive = TRUE),
#     c("_bookdown.yml", "_output.yml", "chapter1/example.Rmd",
#       "index.Rmd")
#   )
#   testthat::expect_output(
#     testthat::expect_message(
#       bookdown::render_book(sprintf("%s/index.Rmd", outputdir), output_dir = "_public", output_format = "utilitr::html_document"),
#       "Output created"),
#     "pandoc")
#
#   # utilitr::pdf_document()
#
# })
#
