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

  expect_true(all(c(TRUE, FALSE) %in% unique(a$is_animal)))
  expect_true(unique(b$is_animal) == c(TRUE))
  expect_true(unique(c$is_animal) == c(FALSE))

})

test_that("get_taxa() works", {
  a <- get_taxa()
  b <- get_taxa(is_animal = TRUE)
  c <- get_taxa(is_animal = FALSE)
  d <- get_taxa(name_regexp_ci = '^Udea.*$')
  e <- get_taxa(taxagroup = 'Flechten')


  expect_is(a, 'data.frame')
  expect_is(b, 'data.frame')
  expect_is(c, 'data.frame')
  expect_is(d, 'data.frame')
  expect_is(e, 'data.frame')

  rn <- c("id", "eu_guid", "name_wissenschaftlich", "name_deutsch", "artengruppe",
          "gid", "is_animal")
  expect_equal(names(a), rn)
  expect_equal(names(b), rn)
  expect_equal(names(c), rn)
  expect_equal(names(d), rn)
  expect_equal(names(e), rn)

  expect_true(all(c(TRUE, FALSE) %in% unique(a$is_animal)))
  expect_true(unique(b$is_animal) == c(TRUE))
  expect_true(unique(c$is_animal) == c(FALSE))
  expect_true(all(grepl('^Udea.*', d$name_wissenschaftlich)))
  expect_true(all(e$artengruppe == 'Flechten'))
})
