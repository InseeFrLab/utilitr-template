# inspired by mitchell O'Hara-Wild vitae package : https://github.com/mitchelloharawild/vitae/blob/master/tests/testthat/test-template.R
# borrowed from https://github.com/spyrales/gouvdown/blob/master/tests/testthat/test-rmarkdown.R

expect_render <- function(template){

  outputdir <- tempfile()
  dir.create(outputdir)
  dir.create(file.path(outputdir,'www'))
  file.copy(system.file("rmarkdown", "templates", template, "skeleton", "skeleton.Rmd", package = "utilitr"),outputdir)
  file <- file.path(outputdir,"skeleton.Rmd")
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
