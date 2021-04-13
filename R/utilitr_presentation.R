utilitr_dependencies_presentation <- function(){

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
utilitr_presentation <- function(css = NULL,
                                 nature = list(highlightStyle = "github",
                                               highlightLines = TRUE,
                                               countIncrementalSlides = TRUE),
                                 self_contained = TRUE,
                                 lib_dir = "libs",
                          ...) {

  css <- c(css,
           list.files(pkg_resource('rmarkdown/resources/slides'),
                    recursive = TRUE,
                    pattern = "*.css", full.names = TRUE)
  )

  xaringan::moon_reader(
    css = css,
    nature = nature,
    self_contained = self_contained,
    lib_dir = lib_dir,
    ...
  )


}
