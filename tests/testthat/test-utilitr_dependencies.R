test_that("utilitr_dependencies() returns a list of HTML dependencies", {
  supported_outputs <- eval(formals(utilitr_dependencies)$output)

  for(output in supported_outputs) {
    result <- utilitr_dependencies(output)
    expect_type(result, "list")

    for(dep in result) {
      expect_s3_class(dep, "html_dependency")
    }
  }
})
