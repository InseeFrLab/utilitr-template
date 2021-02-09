#' `html_paged` version for utilitR
#'
#' @param extra_dependencies Additional HTML dependencies
#' @inheritParams pagedown::html_paged
#' @export

html_paged <- function(..., extra_dependencies = NULL){

  extra_dependencies <- c(
    utilitr_dependencies(type = "pdf"),
    # rmarkdown::html_dependency_font_awesome(),
    extra_dependencies
  )

  pagedown::html_paged(..., extra_dependencies = extra_dependencies,
                       new_session = TRUE,
                       toc = TRUE,
                       toc_depth = 2,
                       self_contained = FALSE,
                       copy_resources = TRUE,
                       pandoc_args = c("--lua-filter",
                                         pkg_resource("rmarkdown/resources/scripts/nbsp.lua")))

}

#' Front-user function to build PDF
#' @inheritParams bookdown::render_book
#' @inheritParams pagedown::chrome_print
#' @importFrom bookdown render_book
#' @importFrom pagedown chrome_print
#' @export

pdf_document <- function(...,
                         extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = 600,
                         verbose = 1){

  # css_default <- c(
  #   pkg_resource("/rmarkdown/resources/css/default.css"),
  #   pkg_resource("/rmarkdown/resources/css/style.css"),
  #   pkg_resource("/rmarkdown/resources/css/default-fonts.css"),
  #   pkg_resource("/rmarkdown/resources/css/default-page.css")
  # )
  #
  # css <- c(css_default, css)
  #
  # bookdown::render_book("index.Rmd", ..., css = css,
  #                       output_format = 'pagedown::html_paged',
  #                       output_file = '_pagedown_output/index.html')

  bookdown::render_book('index.Rmd',
                        ..., output_format = 'utilitr::html_paged',
                        output_file = '_pagedown_output/index.html')

  pagedown::chrome_print('_pagedown_output/index.html', '_pagedown_output/DocumentationR.pdf',
                         extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = timeout,
                         options = list(transferMode = 'ReturnAsStream'),
                         verbose = verbose)

}

