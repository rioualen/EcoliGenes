test_that("Number of columns is ok", {
  expect_equal(ncol(read_master_gene_file()), 13)
})
test_that("Number of lines is ok", {
	expect_equal(nrow(read_master_gene_file()), 4739)
})
