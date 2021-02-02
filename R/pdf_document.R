
#' @importFrom pagedown html_paged chrome_print
#' @export

pdf_document <- function(output_dir = "_public",
                         extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = timeout,
                         verbose = verbose,
                         ...){

  bookdown::render_book(input,
                        output_format = 'pagedown::html_paged',
                        output_file = '_pagedown_output/index.html')

  pagedown::chrome_print('_pagedown_output/index.html',
                         '_pagedown_output/DocumentationR.pdf',
                         extra_args = extra_args,
                         timeout = timeout,
                         options = list(transferMode = 'ReturnAsStream'),
                         verbose = verbose)

}

