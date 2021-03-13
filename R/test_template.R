test_template <- function(){
  unlink(c("index.Rmd","_output.yml",'_bookdown.yml','style.css'), recursive = TRUE)
  unlink(c('chapter1','images'), recursive = TRUE)
  unlink(c('_public'), recursive = TRUE)
  rmarkdown::draft('index.Rmd', template='utilitr', package='utilitr', edit = FALSE)
  bookdown::render_book('index.Rmd', output_dir = '_public', output_format = 'utilitr::html_document')
  # unlink(c("index.Rmd","_output.yml",'_bookdown.yml','style.css'), recursive = TRUE)
  # unlink(c('chapter1','images'), recursive = TRUE)
}
