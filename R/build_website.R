# #' @export
# #' @importFrom bookdown render_book
# html_document <- function(extra_dependencies = NULL, ...){
#
#   # locations of resource files in the package
#   pkg_resource <- function(...) {
#     system.file(..., package = "utilitr")
#   }
#
#   # invisible(
#   #   check_structure()
#   # )
#
#   # css_default <- c(
#   #   pkg_resource("/rmarkdown/resources/css/default.css"),
#   #   pkg_resource("/rmarkdown/resources/css/style.css")
#   # )
#
#   # if (is.null(css)){
#   #   css <- css_default
#   # } else{
#   #   css <- c(css_default, css)
#   # }
#
#   extra_dependencies <- c(
#     utilitr_dependencies(),
#     extra_dependencies
#   )
#
#   rmarkdown::html_document(
#     extra_dependencies = extra_dependencies,
#     # includes = includes,
#     ...
#   )
#
#
# }

#' @importFrom htmltools htmlDependency

utilitr_dependencies <- function(type = c("html","pdf")){

  type <- match.arg(type)
  files <- c("default.css", "style.css")
  if (type == "pdf") files <- c(files, "default-fonts.css",
                                "default-page.css")

  # default CSS stylesheet
  default_dep <- list(htmltools::htmlDependency(
    'utilitr-default', utils::packageVersion('utilitr'),
    src = pkg_resource('rmarkdown/resources/css'), stylesheet = files
  ))

  return(default_dep)
}

# locations of resource files in the package
pkg_resource <- function(...) {
  system.file(..., package = "utilitr")
}



#' The utilitR GitBook output format
#'
#' @param ... Additional arguments passed to \code{bookdown::\link{gitbook}()}.
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
gitbook_utilitr <- function(extra_dependencies = list(),
                         ...) {
  extra_dependencies <- c(
    utilitr_dependencies(),
    extra_dependencies
  )

  bookdown::gitbook(extra_dependencies = extra_dependencies, ...)

}


#' @export
html_document <- gitbook_utilitr


#' The utilitR PDF output format
#'
#' @param ... Additional arguments passed to \code{pagedown::\link{gitbook}()}.
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
pdf_utilitr <- function(extra_dependencies = list(),
                            ...) {

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



check_structure <- function(){

  pkg_resource <- function(...) {
    system.file(..., package = "utilitr")
  }

  default_files <- list.files(sprintf("%s/rmarkdown/resources",
                                      pkg_resource()), recursive = TRUE)
  default_files <- default_files[!startsWith(default_files, "css")]
  default_dir <- list.dirs(sprintf("%s/rmarkdown/resources",
                                   pkg_resource()), recursive = TRUE,
                           full.names = FALSE)
  default_dir <- default_dir[!grepl(default_dir, pattern = "(^|css)$")]

  lapply(default_dir, function(fl){
    if (isFALSE(dir.exists(fl))) dir.create(fl)
  })

  lapply(default_files, function(fl){

    if (isFALSE(file.exists(fl))) file.copy(from = sprintf("%s/rmarkdown/resources/%s",
                                                           pkg_resource(), fl),
                                            to = fl)

  })

}
