build_website <- function(...){

  # locations of resource files in the package
  pkg_resource <- function(...) {
    system.file(..., package = "utilitr")
  }

  css <- list.files(
    sprintf("%s/rmarkdown/templates/resources/css",
            pkg_resource()),
    full.names = TRUE
  )




}
