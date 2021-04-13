#' A xaringan template for presentations
#'
#' An opinionated template
#' @inheritParams xaringan::moon_reader
#' @param lib_dir JS dependencies librairies location
#' @export

utilitr_presentation <- function(css = NULL,
                                 nature = list(highlightStyle = "github",
                                               highlightLines = TRUE,
                                               countIncrementalSlides = TRUE),
                                 self_contained = TRUE,
                                 lib_dir = "libs",
                          ...) {

  css <- c(list.files(pkg_resource('rmarkdown/resources/slides'),
                    recursive = TRUE,
                    pattern = "*.css", full.names = TRUE),
           css
  )

  xaringan::moon_reader(
    css = css,
    nature = nature,
    self_contained = self_contained,
    lib_dir = lib_dir,
    ...
  )


}
