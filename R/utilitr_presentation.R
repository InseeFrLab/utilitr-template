utilitr_dependencies <- function(
){

  files <- c("default.css", "default-fonts",
             "metropolis.css",
             "custom.css")


  default_dep <- list(htmltools::htmlDependency(
    'utilitr-default', utils::packageVersion('utilitr'),
    src = pkg_resource('rmarkdown/resources'),
    stylesheet = paste0("css/", files)#,
#    script = paste0("js/", script)
  ))

  return(default_dep)
}

#' @export
utilitr_presentation <- function(extra_dependencies = list(),
                          ...) {
  extra_dependencies <- c(
    utilitr_dependencies_presentation(),
    extra_dependencies
  )

  xaringan::moon_reader(
    extra_dependencies = extra_dependencies,
    ...
  )


}
