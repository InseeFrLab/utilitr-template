#' HTML paged version for utilitR document
#'
#' This function presents an output format necessary
#'  to build a PDF version of the documentation. This
#'  is a paged HTML document which means an HTML with
#'  usueal features for PDFs (page number, A4 formatting, etc.)
#'
#' @seealso [html_paged](pagedown::html_paged)
#'  which is used as a customizable
#'  basis to render R Markdown documents
#' @param ... Additional arguments passed to [pagedown::html_paged()].
#' @inheritParams rmarkdown::html_document
#' @export
html_paged <- function(
  ..., toc = TRUE, toc_depth = 2, extra_dependencies = NULL, pandoc_args = NULL
){
  extra_dependencies <- c(
    utilitr_dependencies(output = "pagedown"),
    # rmarkdown::html_dependency_font_awesome(),
    extra_dependencies
  )

  pandoc_args <- c(
    "--lua-filter",
    pkg_resource("rmarkdown/resources/scripts/nbsp.lua"),
    pandoc_args
  )

  of <- pagedown::html_paged(
    ...,
    extra_dependencies = extra_dependencies,
    toc = toc,
    toc_depth = toc_depth,
    pandoc_args = pandoc_args
  )

  # tweak figures
  of$knitr$opts_chunk <- list(out.width = '75%', fig.align = 'center')

  of
}

#' Front-user function to build PDF
#'
#' This function must be used in the `R` console. This will generate
#'  the documentation in a `_pagedown_output` directory
#' @inheritParams bookdown::render_book
#' @inheritParams pagedown::chrome_print
#' @param asHTML Logical indicating wether we prefer a HTML or a PDF (default)
#'  file
#'
#' @importFrom bookdown render_book
#' @importFrom pagedown chrome_print html_paged
#' @import callr
#' @export
pdf_document <- function(extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = 1000,
                         verbose = 1,
                         asHTML = FALSE){

  if (!dir.exists("_pagedown_output")) dir.create("_pagedown_output")
  if (!file.exists("index.Rmd") && (file.exists("skeleton.Rmd"))){
    message("Renaming skeleton.Rmd into index.Rmd to match bookdown rules")
    file.rename("skeleton.Rmd", "index.Rmd")
  }
  if (!file.exists("index.Rmd") && (file.exists("Untitled.Rmd"))){
    message("Renaming Untitled.Rmd into index.Rmd to match bookdown rules")
    file.rename("Untitled.Rmd", "index.Rmd")
  }

  message("--------------------------------------------------------")
  message("Knitting document in background. This may take some time")

  callr::r(function(){


    bookdown::render_book('index.Rmd',
                          # envir = new.env(),
                          config_file = "_bookdown.yml",
                          # self_contained = FALSE,
                          output_format = 'utilitr::html_paged',
                          output_file = '_pagedown_output/index.html')

  }, timeout = timeout)

  if (isTRUE(asHTML)){
    message("Only compiling in HTML since asHTML is TRUE")
    return(NULL)
  }

  message("--------------------------------------------------------")
  message("Converting into PDF. This may also take some time")

  pagedown::chrome_print('_pagedown_output/index.html',
                         '_pagedown_output/DocumentationR.pdf',
                         extra_args = c('--disable-gpu', '--no-sandbox'),
                         timeout = timeout,
                         options = list(transferMode = 'ReturnAsStream'),
                         verbose = verbose)


}
