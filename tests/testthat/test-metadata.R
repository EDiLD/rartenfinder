context("metadata")

test_that("get_taxagroups() works", {
  a <- get_taxagroups()
  b <- get_taxagroups(is_animal = TRUE)
  c <- get_taxagroups(is_animal = FALSE)

  expect_is(a, 'data.frame')
  expect_is(b, 'data.frame')
  expect_is(c, 'data.frame')

  rn <- c("id", "name_deutsch", "is_animal")
  expect_equal(names(a), rn)
  expect_equal(names(b), rn)
  expect_equal(names(c), rn)
})
