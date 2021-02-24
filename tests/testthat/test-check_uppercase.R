dir <- tempdir()

setwd(dir)

dir.create(sprintf("/upper",dir))

file.create("f1.png")

testthat::expect_message(
  upper_extension("PNG"),
  "Pas de probleme d'extension"
)

file.create("f2.PNG")

testthat::expect_error(
  upper_extension("PNG"),
  "Les fichiers suivants ont une majuscule:\n f2.PNG"
)
