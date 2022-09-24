test_that("Testing getContrasts function", {
  expected <- getContrasts(data = getPlot(data = getData(input_file = "/Users/jahanshah/Desktop/RShiny/cdrvis/data/TCGA-CDR-SupplementalTableS1.xlsx"), cancer_type = 'SKCM|SARC|READ|COAD')$data, test.method = "t.test")
  expect_s3_class(expected, "data.frame")
})
