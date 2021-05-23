#' Import dependencies for utilitR template
#'
#' @importFrom htmltools htmlDependency
#' @param output What is the output format? Choice between "gitbook", "bs4" and "pagedown"

utilitr_dependencies <- function(
  output = c("gitbook","bs4", "pagedown")
){

  output <- match.arg(output)

  css_files <- c("default.css", "style-utilitr.css", "icones-fa.css",
                 "default-fonts.css", "default-page.css")

  if (output %in% c("gitbook", "bs4")) {
    css_files <- c(css_files, "customize.css")
  }
  if (output == "bs4"){
    css_files <- c(css_files, "customize-bs4.css")
    script <- "date-header.js"
  } else{
    css_files <- c("reset.css", css_files)
    script <- "book.js"
  }

  if (output == "pagedown") {
    return(paste0(pkg_resource('rmarkdown/resources/css/'), css_files))
  }

  default_dep <- list(htmltools::htmlDependency(
    'utilitr-default', utils::packageVersion('utilitr'),
    src = pkg_resource('rmarkdown/resources'),
    stylesheet = paste0("css/", css_files),
    script = paste0("js/", script)
  ))

  return(default_dep)
}

# locations of resource files in the package
pkg_resource <- function(...) {
  system.file(..., package = "utilitr", mustWork = TRUE)
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
                    includes = rmarkdown::includes(
                      in_header = pkg_resource("rmarkdown/resources/html/header_polyfill.html"),
                      before_body = pkg_resource("rmarkdown/resources/html/print_button.html"),
                    ),
                    anchor_sections = FALSE,
                    in_header = pkg_resource("rmarkdown/resources/header.html"),
                    pandoc_args = c("--lua-filter",
                                    pkg_resource("rmarkdown/resources/scripts/nbsp.lua")),
                    ...)

}

#' UtilitR bs4 format
#'
#' An output format customizing bs4 format
#'
#' @inheritParams rmarkdown::render
#' @inheritParams bookdown::bs4_book
#' @param extra_dependencies Additional HTML dependencies. When left empty,
#'  a few default formatting properties are applied
#' @param includes Specify additional content to be included within an output document.
#' @param theme Bookdown theme. Default uses \code{bookdown::\link{bs4_book_theme}}
#' @param pandoc_args Additional pandoc arguments passed to \code{rmarkdown::\link{render}()}.
#' @param primary,secondary Colors for the theme
#' @param new_session Logical indicating whether each Rmd should be compiled in a
#'  brand-new directory
#' @param  ... Additional arguments passed to \code{bookdown::\link{bs4_book}}
#'
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
bs4_utilitr <-
  function(
    extra_dependencies = list(),
    includes = rmarkdown::includes(
      in_header = pkg_resource("rmarkdown/resources/html/header_polyfill.html"),
      before_body = pkg_resource("rmarkdown/resources/html/print_button.html"),
    ),
    theme = bookdown::bs4_book_theme,
    pandoc_args = c("--lua-filter",
                    pkg_resource("rmarkdown/resources/scripts/nbsp.lua")),
    primary = "#3c5c5c",
    secondary = "#cf581b",
    new_session = TRUE,
    ...) {

    extra_dependencies <- c(
      utilitr_dependencies(output = "bs4"),
      extra_dependencies
    )

  bookdown::bs4_book(
    extra_dependencies = extra_dependencies,
    includes = includes,
    theme = theme(primary = primary,
                  secondary = secondary
    ),
    pandoc_args = pandoc_args,
    new_session = new_session,
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



