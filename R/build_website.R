#' Import dependencies for utilitR template
#'
#' @importFrom htmltools htmlDependency
#' @param type Which format should we handle ?

utilitr_dependencies <- function(type = c("html","pdf"), to_list = FALSE){

  type <- match.arg(type)
  files <- c("default.css", "style.css")
  if (type == "pdf") files <- c(files, "default-fonts.css",
                                "default-page.css")

  if (to_list) return(paste0(pkg_resource('rmarkdown/resources/css/'), files))

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
#' @param extra_dependencies Additional HTML dependencies
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
gitbook_utilitr <- function(extra_dependencies = list(),
                         ...) {
  extra_dependencies <- c(
    utilitr_dependencies(),
    extra_dependencies
  )

  bookdown::gitbook(extra_dependencies = extra_dependencies, ,
                    new_session = TRUE,
                    ...)

}

#' @rdname gitbook_utilitr
#' @export
html_document <- gitbook_utilitr





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
