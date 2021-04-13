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
                                 extra_dependencies = NULL,
                          ...) {

  css_modele <-
    c(
      list.files(
        pkg_resource('rmarkdown/resources/css'),
        recursive = FALSE,
        pattern = "default.css", full.names = TRUE),
      list.files(
        pkg_resource('rmarkdown/resources/css'),
        recursive = FALSE,
        pattern = "style-utilitr.css", full.names = TRUE),
      list.files(
        pkg_resource('rmarkdown/resources/css'),
        recursive = FALSE,
        pattern = "icones-fa.css", full.names = TRUE),
      list.files(
        pkg_resource('rmarkdown/resources/css'),
        recursive = FALSE,
        pattern = "default-fonts.css", full.names = TRUE),
      list.files(
        pkg_resource('rmarkdown/resources/css/slides'),
        recursive = FALSE,
        pattern = "metropolis.css", full.names = TRUE),
      list.files(
        pkg_resource('rmarkdown/resources/css/slides'),
        recursive = FALSE,
        pattern = "custom.css", full.names = TRUE)
    )

  css <- c(css_modele, css)

  extra_dependencies <- c(extra_dependencies,
                          rmarkdown::html_dependency_font_awesome())

  xaringan::moon_reader(
    css = css,
    nature = nature,
    self_contained = self_contained,
    lib_dir = lib_dir,
    extra_dependencies = extra_dependencies,
    ...
  )


}
