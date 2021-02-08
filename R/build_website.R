#' @inheritParams bookdown::render_book
#' @export
#' @importFrom bookdown render_book
html_document <- function(extra_dependencies = NULL, ...){

  # locations of resource files in the package
  pkg_resource <- function(...) {
    system.file(..., package = "utilitr")
  }

  # invisible(
  #   check_structure()
  # )

  # css_default <- c(
  #   pkg_resource("/rmarkdown/resources/css/default.css"),
  #   pkg_resource("/rmarkdown/resources/css/style.css")
  # )

  # if (is.null(css)){
  #   css <- css_default
  # } else{
  #   css <- c(css_default, css)
  # }

  extra_dependencies <- c(
    utilitr_dependencies(),
    extra_dependencies
  )

  rmarkdown::html_document(
    extra_dependencies = extra_dependencies,
    # includes = includes,
    ...
  )


}

#' @importFrom htmltools htmlDependency


utilitr_dependencies <- function() {
  # default CSS stylesheet
  default_dep <- list(htmltools::htmlDependency(
    'utilitr-default', utils::packageVersion('utilitr'),
    src = pkg_resource('css'), stylesheet = c(
      file.path("default.css"),
      file.path("style.css")
    )
  ))

  return(default_dep)
}

# locations of resource files in the package
pkg_resource <- function(...) {
  system.file(..., package = "utilitr")
}


#' #' @inheritParams bookdown::render_site
#' #' @export
#' # importFrom bookdown clean_book load_config render_book_script find_book_dir find_book_name
#'
#' render_site <- function(input, ...)  {
#'   on.exit(opts$restore(), add = TRUE)
#'   oldwd = setwd(input)
#'   on.exit(setwd(oldwd), add = TRUE)
#'   config = load_config()
#'   name = find_book_name(config, basename(normalizePath(input)))
#'   book_dir = find_book_dir(config)
#'   render = function(input_file, output_format, envir, quiet,
#'                     encoding, ...) {
#'     if (is.null(input_file)) {
#'       in_dir(input, render_book_script(output_format,
#'                                        envir, quiet))
#'     }
#'     else {
#'       render_book(input_file, output_format, envir = envir,
#'                   preview = TRUE)
#'     }
#'   }
#'   clean = function() {
#'     suppressMessages(bookdown::clean_book(clean = FALSE))
#'   }
#'   list(name = name, output_dir = book_dir, render = render,
#'        clean = clean)
#' }
#'
#'
#'
#' # render_book_script <- function(output_format = NULL, envir = globalenv(), quiet = TRUE){
#' #   result = 0
#' #   if (length(script <- existing_r("_render", TRUE))) {
#' #     result = Rscript(c(if (quiet) "--quiet", script, shQuote(output_format)))
#' #   }
#' #   else if (file.exists("Makefile")) {
#' #     result = system2("make")
#' #   }
#' #   else {
#' #     render_book("index.Rmd", output_format = output_format,
#' #                 envir = envir)
#' #   }
#' #   if (result != 0)
#' #     stop("Error ", result, " attempting to render book")
#' # }



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
