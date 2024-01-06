library(testthat)
library(kickR)

# Bundesliga
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_bundesliga_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_bundesliga_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_bundesliga_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# Premier League

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_epl_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_epl_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_epl_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# Eredivisie

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_eredivisie_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_eredivisie_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_eredivisie_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# La Liga
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_la_liga_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_la_liga_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_la_liga_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# Ligue 1
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_ligue1_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_ligue1_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_ligue1_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# Primeira Liga

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_primeira_liga_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_primeira_liga_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_primeira_liga_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# Serie A
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_serie_a_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_serie_a_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_serie_a_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})


# Team stats
# Test for the Premier League
test_that("Fetching data for the Premier League (2022/2023 season, goal_creation)", {
  result <- fbref_team_stats(league = "Premier League", season = "year", type = "goal_creation")
  expect_is(result, "NULL")
})

# Test for La Liga
test_that("Fetching data for La Liga (2022/2023 season, standard type)", {
  result <- fbref_team_stats(league = "La Liga", season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for Serie A
test_that("Fetching data for Serie A (2022/2023 season, advanced_goalkeeping type)", {
  result <- fbref_team_stats(league = "Serie A", season = "2022/2023", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 20)
})


# T5 leagues players
# Test to check if the number of rows returned is more than 1500
test_that("Fetching data with more than 1500 rows", {
  result <- fbref_big5_player_stats(season = "2022/2023", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 30)
  expect_true(nrow(result) > 1500)
})
