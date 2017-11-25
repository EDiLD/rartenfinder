context("observations")

test_that("get_observations() works", {
  a <- get_observations(scientific_name = 'milvus milvus', year = 2017)
  b <- get_observations(scientific_name = 'milvus milvus', year = 2017, bbox = c(405188,5474383,415905,5480017))

  expect_is(a, 'data.frame')
  expect_is(b, 'data.frame')

  rn <- c("id", "bereich", "status", "anzahl", "lat", "lon", "datum",
          "titel_deutsch", "titel_wissenschaftlich", "bemerkung", "phaenogramm",
          "lanis_rlp_osiris_art_id", "is_rasterized")
  expect_equal(names(a), rn)
  expect_equal(names(b), rn)

  expect_true(all(b$lon > 405188))

})
