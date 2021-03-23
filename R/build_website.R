#' Import dependencies for utilitR template
#'
#' @importFrom htmltools htmlDependency
#' @param type Which output format should we handle ?
#' @param to_list Logical indicating whether we want to return result as
#' htmltools dependency or simple filepaths list

utilitr_dependencies <- function(type = c("html","pdf"), model = c("gitbook","bs4"),
                                 to_list = FALSE){

  type <- match.arg(type)
  model <- match.arg(model)

  files <- c("reset.css", "default.css", "style-utilitr.css", "icones-fa.css",
             "default-fonts.css", "default-page.css")

  if (type == "html") {
    files <-
      c(files, "customize.css")
  }

  if (model == "bs4"){
    files <- "customize-bs4.css"
    script <- NULL
  } else{
    script <- "js/book.js"
  }

  if (to_list) return(paste0(pkg_resource('rmarkdown/resources/css/'), files))

  # default CSS stylesheet
  # default_dep <- list(htmltools::htmlDependency(
  #   'utilitr-default', utils::packageVersion('utilitr'),
  #   src = pkg_resource('rmarkdown/resources/css'), stylesheet = files
  # ))
  default_dep <- list(htmltools::htmlDependency(
    'utilitr-default', utils::packageVersion('utilitr'),
    src = pkg_resource('rmarkdown/resources'),
    stylesheet = paste0("css/", files),
    script = script
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
html_document <- function(extra_dependencies = list(),
                          ...) {
  extra_dependencies <- c(
    utilitr_dependencies(),
    extra_dependencies
  )

  bookdown::gitbook(extra_dependencies = extra_dependencies,
                    new_session = TRUE,
                    template = pkg_resource("templates/gitbook.html"),
                    anchor_sections = FALSE,
                    # css = pkg_resource('rmarkdown/templates/utilitr/skeleton/style.css'),
                    in_header = pkg_resource("rmarkdown/resources/header.html"),
                    pandoc_args = c("--lua-filter",
                                    pkg_resource("rmarkdown/resources/scripts/nbsp.lua")),
                    ...)

}

#' @export
bs4_utilitr <- function(extra_dependencies = list(),
                        ...) {
  extra_dependencies <- c(
    utilitr_dependencies(model = "bs4"),
    extra_dependencies
  )

  bookdown::bs4_book(
    extra_dependencies = extra_dependencies,
    includes = rmarkdown::includes(
      in_header = c(
        pkg_resource("rmarkdown/resources/html/print_button.html")
      )
    ),
    new_session = TRUE,
    theme = bookdown::bs4_book_theme(primary = "#93bcbc",
                                     secondary = "#cf581b"),
    pandoc_args = c("--lua-filter",
                    pkg_resource("rmarkdown/resources/scripts/nbsp.lua")),
    ...)

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




