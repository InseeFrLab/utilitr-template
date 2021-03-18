#' Render an Rmd file asis
#'
#' @param x Filepath
#' @return The Rmd formatted into a unique string
#' @export

render_rmd <- function(x) return(cat(htmltools::includeText(x)))


compresser_image <-
  function(file_in,
           file_out = NA, ratio_compression = 2,
           xmax = 300, quality = 0.7, cutoff = 3000) {
    # Fonction de compression d'une image png
    # xmax <- 1920  # y pixel max
    # quality <- 0.7  # passed on to jpeg::writeJPEG()
    # cutoff <- 100000  # files smaller than this will not be touched
    # file_out <- "test.jpg"
    dossier_images <- './pics' # This folder must exist in the repo
    dossier_images_compressees <- './pics_resized'

    if (is.na(file_out)) {
      file_out <- sub(dossier_images, dossier_images_compressees, file_in)
    }
    if (is.na(file.size(file_in))) {
      stop(paste0("File ", file_in, " not found."))
    }
    else if (file.size(file_in) < cutoff) {  # in this case, just copy file
      if (!(file_in == file_out)) {
        file.copy(from = file_in, to = file_out, overwrite = TRUE)
      }
    } else {# if larger than cutoff
      # magick workflow
      image_raw <- magick::image_read(path = file_in)
      if (!is.na(ratio_compression)) {
        image_resized <-
          magick::image_scale(
            image = image_raw,
            geometry = as.character(as.integer(round(magick::image_info(image_raw)["width"] / ratio_compression))))
      } else if (magick::image_info(image_raw)["width"] > xmax) {  # only resize if smaller
        image_resized <-
          magick::image_scale(
            image = image_raw,
            geometry = as.character(xmax))
      } else {
        image_resized      <- image_raw
      }
      magick::image_write(image = image_resized,
                          path = file_out,
                          format = "png")
    }
  }

#' Include a compressed image from filepath
#' @param x Filepath
#' @param compression Logical including whether we want to compress image
#'  (default) or not (in that case, standard
#'  \code{knitr::\link{include_graphics}()}
#'  is used)
#' @param ratio_compression Compression ratio that should be applied
#' @param ... Arguments to pass to \code{magick::\link{image_scale}()}
#' @export

include_image <- function(x, compression = TRUE, ratio_compression = 2, ...) {
  dossier_images <- './pics' # This folder must exist in the repo
  dossier_images_compressees <- './pics_resized'

  file.copy(from = x,
            to = sub(
              dossier_images,
              dossier_images_compressees, x),
            overwrite = TRUE)

  # Fonction qui 1/ compresse  l'image si nécessaire; 2/ l'inclut dans le Rmd
  if (compression) {
    compresser_image(file_in = x, ratio_compression = ratio_compression,
                     ...)
  }
  knitr::include_graphics(sub(dossier_images, dossier_images_compressees, x), ...)
}


