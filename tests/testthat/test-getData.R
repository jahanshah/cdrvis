test_that("Testing getData function", {
  expected <- getData(input_file = "/Users/jahanshah/Desktop/RShiny/cdrvis/data/TCGA-CDR-SupplementalTableS1.xlsx")
  expect_s3_class(expected, "data.frame")
})
