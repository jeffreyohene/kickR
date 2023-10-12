library(testthat)
library(kickR)

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_2bundesliga_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_2bundesliga_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_2bundesliga_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_2bundesliga_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})


# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_2bundesliga_team_stats(season = "18/19", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_2bundesliga_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_2bundesliga_team_stats(season = "21-22", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_2bundesliga_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})


# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_2bundesliga_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goakeeping", {
  result <- fbref_2bundesliga_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_2bundesliga_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_2bundesliga_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_2bundesliga_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Belgian Pro League
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_belgian_pro_league_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_belgian_pro_league_team_stats(season = "18/19", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 16)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_belgian_pro_league_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 16)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_belgian_pro_league_team_stats(season = "21-22", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_belgian_pro_league_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_belgian_pro_league_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 16)
})

# Test for a different valid season and type "advanced_goakeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_belgian_pro_league_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 16)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_belgian_pro_league_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_belgian_pro_league_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Campeonato Brasileiro Serie A

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_br_serie_a_team_stats(season = "2022", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_br_serie_a_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_br_serie_a_team_stats(season = "21-22", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_br_serie_a_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_br_serie_a_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_br_serie_a_team_stats(season = "2019-2020", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2021") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_br_serie_a_team_stats(season = "2021-2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_br_serie_a_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_br_serie_a_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_br_serie_a_team_stats(season = "2017-2018", type = "advanced_goalkeeping")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_br_serie_a_team_stats(season = "2022-2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_br_serie_a_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_br_serie_a_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_bundesliga_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_bundesliga_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_bundesliga_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_bundesliga_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_bundesliga_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_bundesliga_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_bundesliga_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_bundesliga_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_bundesliga_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_bundesliga_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})



# Championship
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_efl_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 24)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_efl_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_efl_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_efl_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 24)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_efl_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 24)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_efl_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 24)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_efl_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 24)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_efl_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_efl_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 24)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_efl_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 24)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_efl_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 24)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_efl_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_efl_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 24)
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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_epl_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_epl_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_epl_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_epl_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_epl_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_epl_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_epl_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_epl_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_epl_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_epl_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_eredivisie_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_eredivisie_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_eredivisie_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_eredivisie_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_eredivisie_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_eredivisie_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_eredivisie_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_eredivisie_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_eredivisie_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_eredivisie_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_la_liga_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_la_liga_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_la_liga_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_la_liga_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_la_liga_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_la_liga_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_la_liga_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_la_liga_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_la_liga_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_la_liga_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})


# Liga MX
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_liga_mx_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_liga_mx_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_liga_mx_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_liga_mx_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_liga_mx_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_liga_mx_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_liga_mx_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_liga_mx_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_liga_mx_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_liga_mx_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_liga_mx_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_liga_mx_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_liga_mx_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_ligue1_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_ligue1_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_ligue1_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_ligue1_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_ligue1_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "defensive_actions"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_ligue1_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_ligue1_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_ligue1_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_ligue1_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_ligue1_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})



# Ligue 2

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_ligue2_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_ligue2_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_ligue2_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_ligue2_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_ligue2_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_ligue2_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_ligue2_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_ligue2_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_ligue2_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_ligue2_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_ligue2_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_ligue2_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_ligue2_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})


# MLS

# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_mls_team_stats(season = "2022", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 28)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_mls_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_mls_team_stats(season = "2022", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_mls_team_stats(season = "2022", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 28)
})

# Test for a different valid season (e.g., "2018") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_mls_team_stats(season = "2018", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 23)
})

# Test for a different valid season (e.g., "2018") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_mls_team_stats(season = "2018", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 23)
})

# Test for a different valid season (e.g., "2021") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_mls_team_stats(season = "2021", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 27)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_mls_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_mls_team_stats(season = "2018", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 23)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_mls_team_stats(season = "2018", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 23)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_mls_team_stats(season = "2022", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 28)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_mls_team_stats(season = "2016", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_mls_team_stats(season = "2020")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 26)
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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_primeira_liga_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_primeira_liga_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_primeira_liga_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_primeira_liga_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_primeira_liga_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_primeira_liga_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_primeira_liga_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 18)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_primeira_liga_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 18)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_primeira_liga_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_primeira_liga_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 18)
})



# Segunda Division
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_segunda_division_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 22)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_segunda_division_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_segunda_division_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_segunda_division_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 22)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_segunda_division_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 22)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_segunda_division_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 22)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_segunda_division_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 22)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_segunda_division_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_segunda_division_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 22)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_segunda_division_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 22)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_segunda_division_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 22)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_segunda_division_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_segunda_division_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 22)
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

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_serie_a_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_serie_a_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_serie_a_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_serie_a_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_serie_a_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "possession"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_serie_a_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_serie_a_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_serie_a_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_serie_a_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_serie_a_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})


#Serie B
# Test for a valid season and type
test_that("Fetching data for a valid season and type", {
  result <- fbref_serie_b_team_stats(season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})

# Test for an invalid season
test_that("Fetching data for an invalid season", {
  result <- fbref_serie_b_team_stats(season = "InvalidSeason", type = "standard")
  expect_is(result, "NULL")
})

# Test for an invalid type
test_that("Fetching data for an invalid type", {
  result <- fbref_serie_b_team_stats(season = "2022/2023", type = "invalid_type")
  expect_is(result, "NULL")
})

# Test for type 'miscellaneous' (a case where it should return NULL)
test_that("Fetching data for 'miscellaneous' type", {
  result <- fbref_serie_b_team_stats(season = "2022/2023", type = "miscellaneous")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for a different valid season (e.g., "2018/2019") and type "goalkeeping"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_serie_b_team_stats(season = "2018/2019", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 19)
})

# Test for a different valid season (e.g., "2018/2019") and type "shooting"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_serie_b_team_stats(season = "2018/2019", type = "shooting")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 20)
  expect_equal(nrow(result), 19)
})

# Test for a different valid season (e.g., "2021/2022") and type "possession"
test_that("Fetching data for a different valid season and type", {
  result <- fbref_serie_b_team_stats(season = "2021/2022", type = "possession")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 26)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with empty season and type", {
  result <- fbref_serie_b_team_stats(season = "", type = "")
  expect_is(result, "NULL")
})

# Test for a different valid season and type "defensive_actions"
test_that("Fetching data for a different valid season and type defensive_actions", {
  result <- fbref_serie_b_team_stats(season = "2018/2019", type = "defensive_actions")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 19)
})

# Test for a different valid season and type "advanced_goalkeeping"
test_that("Fetching data for a different valid season and type advanced_goalkeeping", {
  result <- fbref_serie_b_team_stats(season = "2018/2019", type = "advanced_goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 28)
  expect_equal(nrow(result), 19)
})

# Test for a different valid season and type "goal_creation"
test_that("Fetching data for a different valid season and type goal_creation", {
  result <- fbref_serie_b_team_stats(season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

# Test for empty input season and type (should return NULL)
test_that("Fetching data with invalid season and type pass_types", {
  result <- fbref_serie_b_team_stats(season = "2016/2017", type = "pass_types")
  expect_is(result, "NULL")
})

# Test for a valid season but empty type (should return NULL)
test_that("Fetching data with no specified type", {
  result <- fbref_serie_b_team_stats(season = "2020/2021")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
  expect_equal(nrow(result), 20)
})


# Team stats
# Test for the Premier League
test_that("Fetching data for the Premier League (2022/2023 season, goal_creation)", {
  result <- fbref_team_stats(league = "Premier League", season = "2022/2023", type = "goal_creation")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 19)
  expect_equal(nrow(result), 20)
})

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

# Test for Bundesliga
test_that("Fetching data for Bundesliga (2022/2023 season, standard type)", {
  result <- fbref_team_stats(league = "Bundesliga", season = "2022/2023", type = "goalkeeping")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 21)
  expect_equal(nrow(result), 18)
})

# Test for Ligue 1
test_that("Fetching data for Ligue 1 (2022/2023 season, standard type)", {
  result <- fbref_team_stats(league = "Ligue 1", season = "2022/2023", type = "standard")
  expect_is(result, "data.frame")
  expect_equal(ncol(result), 32)
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
