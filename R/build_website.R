#' @export
#' @importFrom bookdown render_book
html_document <- function(output_dir = "_public",
                          ...){

  # locations of resource files in the package
  pkg_resource <- function(...) {
    system.file(..., package = "utilitr")
  }

 invisible(
   check_structure()
 )

  css <- c(list.files(
    sprintf("%s/rmarkdown/resources/css",
            pkg_resource()),
    full.names = TRUE
  ), css)

  bookdown::render_book(output_dir = output_dir,
                        css = css,...)


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
