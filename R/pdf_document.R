
#' @importFrom pagedown html_paged chrome_print
#' @export

pdf_document <- function(..., css = NULL,
                         extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = timeout,
                         verbose = verbose){

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

  extra_dependencies <- c(
    utilitr_dependencies(type = "pdf"),
    extra_dependencies
  )

  bookdown::render_book('index.Rmd',
                        ..., output_format = 'pagedown::html_paged',
                        output_file = '_pagedown_output/index.html',
                        extra_dependencies = extra_dependencies)

  pagedown::chrome_print('_pagedown_output/index.html', '_pagedown_output/DocumentationR.pdf',
                         extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = 600,
                         options = list(transferMode = 'ReturnAsStream'),
                         verbose = 1)

}

