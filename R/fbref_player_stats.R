#' Scrape and Clean Player Statistics from FBREF.com
#'
#' Scrapes player statistics from FBREF.com
#' for a specified league, season, and type of statistics. The function returns
#' a cleaned data frame with relevant player stats.
#'
#' @param season A character string specifying the season in the format "YYYY/YYYY"
#'   (e.g., "2023/2024"). Default is the current season if not provided.
#' @param league A character string specifying the league for which to retrieve
#'   statistics. Available options include "premier_league", "championship",
#'   "serie_a", "la_liga", "ligue_1", "segunda_division", "serie_b", "bundesliga",
#'   "mls", "eredivisie", "br_serie_a", "liga_mx", "primera_liga", "bundesliga_2",
#'   "belgian_pro_league", and "ligue_2". Default is "premier_league".
#' @param type A character string specifying the type of statistics to scrape.
#'   Options include "standard", "goalkeeping", "advanced_goalkeeping", "shooting",
#'   "passing", "pass_types", "goal_creation", "defensive_actions", "possession",
#'   "playing_time", and "miscellaneous". Default is "standard".
#'
#' @return A data frame containing the requested player statistics, with columns
#'   named according to the type of statistics requested.
#'
#' @examples
#' \dontrun{
#'   # Retrieve standard stats for Premier League in the 2023/2024 season
#'   df <- fbref_player_stats(season = "2023/2024", league = "premier_league", type = "standard")
#'   head(df)
#' }
#'
#' @details
#' The function checks the validity of the season and league inputs and constructs
#' the appropriate URL to scrape the data. If the scraping process fails, the function
#' returns an error message and `NULL`. The data is cleaned by removing duplicate headers
#' and unnecessary columns, and column names are adjusted based on the specified type.
#'
#' The function requires the `RSelenium` and `rvest` packages. Ensure these packages are
#' installed before running the function.
#'
#' @importFrom rvest html_table read_html
#' @importFrom RSelenium rsDriver
#'
#' @export

# gebrauchte package
#if (!requireNamespace("rvest","RSelenium", quietly = TRUE)) {
#  install.packages("rvest")
#}

fbref_player_stats <- function(season = NULL, league = NULL, type = NULL) {
  base_url <- 'https://fbref.com/en/comps/'


  # Define valid seasons
  valid_seasons <- c('2018/2019','2019/2020','2020/2021',
                     '2021/2022','2022/2023', "2023/2024",
                     '2024/2025')

  # league codes
  codes <- list(
    premier_league = '9',
    championship = '10',
    serie_a = '11',
    la_liga = '12',
    ligue_1 = '13',
    segunda_division = '17',
    serie_b = '18',
    bundesliga = '20',
    mls = '22',
    eredivisie = '23',
    br_serie_a = '24',
    liga_mx = '31',
    primera_liga = '32',
    bundesliga_2 = '33',
    belgian_pro_league = '37',
    ligue_2 = '60'
  )

  # league suffixes
  leagues <- list(
    premier_league = 'Premier-League-Stats',
    championship = 'Championship-Stats',
    serie_a = 'Serie-A-Stats',
    la_liga = 'La-Liga-Stats',
    ligue_1 = 'Ligue-1-Stats',
    segunda_division = 'Segunda-Division-Stats',
    serie_b = 'Serie-B-Stats',
    bundesliga = 'Bundesliga-Stats',
    mls = 'Major-League-Soccer-Stats',
    eredivisie = 'Eredivisie-Stats',
    br_serie_a = 'Serie-A-Stats',
    liga_mx = 'Liga-MX-Stats',
    primera_liga = 'Primeira-Liga-Stats',
    bundesliga_2 = '2-Bundesliga-Stats',
    belgian_pro_league = 'Belgian-Pro-League-Stats',
    ligue_2 = 'Ligue-2-Stats'
  )

  # Mapping stats
  stats_abv <- list(
    standard = 'stats/',
    goalkeeping = 'keepers/',
    advanced_goalkeeping = 'keepersadv/',
    shooting = 'shooting/',
    passing = 'passing/',
    pass_types = 'passing_types/',
    goal_creation = 'gca/',
    defensive_actions = 'defense/',
    possession = 'possession/',
    playing_time = 'playing_time/',
    miscellaneous = 'misc/'
  )


  # Define the expected vectors for each data type
  cleaned_names_standard <- c("player", "nation", "position","club",
                              "age", "birth_year","matches_played",
                              "starts","minutes","mins_per_90", "goals",
                              "assists", "goals_and_assists",
                              "non_penalty_goals", "penalties",
                              "penalty_kick_attempts","yellow_cards",
                              "red_cards", "xG", "npxG", "xAG", "npxG+xAG",
                              "progressive_carries", "progressive_passes",
                              "goals_per90", "assists_per90",
                              "goals_and_assists_per90",
                              "non_penalty_goals_per90",
                              "non_penalty_goals_and_assists_per90",
                              "xg_per90","xag_per90", "xg_and_xag_per90",
                              "npxg_per90","npxg_and_xag_per90")

  cleaned_names_goalkeeping <- c("player", "nation", "position", "club",
                                 "age","birth_year",
                                 "total_matches_played","starts",
                                 "total_minutes_played", "mins_per_90",
                                 "goals_against", "goals_against_per90",
                                 "shots_on_target_against", "saves",
                                 "save_percentage", "wins", "draws","losses",
                                 "clean_sheets", "clean_sheet_percentage",
                                 "penalties_attempted",
                                 "penalty_kicks_allowed",
                                 "penalty_kicks_saved",
                                 "penalty_kicks_missed",
                                 "penalty_kicks_save_percentage")

  cleaned_names_adv_goalkeeping <- c("player", "nation", "position",
                                     "club","age","birth_year",
                                     "mins_per_90", "goals_against",
                                     "penalty_kicks_allowed",
                                     "free_kick_goals_against",
                                     "corner_kick_goals_against",
                                     "own_goals_against", "PSxG",
                                     "PSxG_per_shot_on_target",
                                     "PSxG_minus_goals_allowed",
                                     "PSxG_minus_goals_allowed_per90",
                                     "launched_passes_completed",
                                     "launched_passes_attempted",
                                     "launched_passes_completion_pct",
                                     "passes_attempted", "throws_attempted",
                                     "percentage_passes_launched",
                                     "avg_pass_length", "goal_kicks",
                                     "percentage_goal_kicks_launched",
                                     "avg_goal_kick_length", "crosses_faced",
                                     "crosses_stopped",
                                     "percentage_crosses_stopped",
                                     "defensive_actions_outside_penalty_box",
                                     "defensive_actions_outside_penalty_box_per90",
                                     "defensive_actions_outside_penalty_box_avg_dist")

  cleaned_names_shooting <- c("player", "nation", "position", "club",
                              "age","birth_year", "mins_per_90","goals",
                              "shots", "shots_on_target",
                              "shots_on_target_percentage", "shots_per90",
                              "shots_on_target_per90", "goals_per_shot",
                              "goals_per_shot_on_target",
                              "average_shot_distance", "free_kick_shots",
                              "penalty_kicks_converted",
                              "penalty_kicks_attempted", "xG", "npxG",
                              "npxG_per_shot", "xg_performance",
                              "npxg_performance")

  cleaned_names_passing <- c("player", "nation", "position", "club", "age",
                             "birth_year", "mins_per_90",
                             "total_passes_completed", "total_passes_attempted",
                             "pass_completion_percentage",
                             "total_passing_distance",
                             "total_progressive_distance",
                             "short_passes_completed", "short_passes_attempted",
                             "short_pass_completion_percentage",
                             "medium_passes_completed",
                             "medium_passes_attempted",
                             "medium_pass_completion_percentage",
                             "long_passes_completed", "long_passes_attempted",
                             "long_pass_completion_percentage", "assists",
                             "xAG", "xA", "xag_performance", "key_passes",
                             "passes_into_final_third",
                             "passes_into_penalty_box",
                             "crosses_into_penalty_box", "progressive_passes")

  cleaned_names_pass_types <- c("player", "nation", "position", "club",
                                "age","birth_year", "mins_per_90",
                                "total_passes_attempted", "live_ball_passes",
                                "dead_ball_passes", "passes_from_free_kicks",
                                "through_balls", "switches", "crosses",
                                "throw_ins", "corner_kicks",
                                "inswinging_corner_kicks",
                                "outswinging_corner_kicks",
                                "straight_corner_kicks", "passes_completed",
                                "passes_offside", "blocks")

  cleaned_names_goal_creation <- c("player", "nation", "position", "club",
                                   "age","birth_year", "mins_per_90",
                                   "shot_creating_actions",
                                   "shot_creating_actions_per90",
                                   "sca_live_passes", "sca_dead_passes",
                                   "sca_take_ons", "sca_shots", "sca_fouls",
                                   "sca_defensive_actions",
                                   "goal_creating_actions",
                                   "goal_creating_actions_per90",
                                   "gca_live_passes", "gca_dead_passes",
                                   "gca_take_ons", "gca_shots", "gca_fouls",
                                   "gca_defensive_actions")

  cleaned_names_defensive_actions <- c("player", "nation", "position", "club",
                                       "age","birth_year",
                                       "mins_per_90", "players_tackled",
                                       "tackles_won", "defensive_third_tackles",
                                       "middle_third_tackles",
                                       "final_third_tackles",
                                       "dribblers_tackled",
                                       "dribbles_challenged",
                                       "percentage_of_dribblers_tackled",
                                       "challenges_lost", "total_blocks",
                                       "shots_blocked", "passes_blocked",
                                       "interceptions",
                                       "tackles_and_interceptions",
                                       "clearances", "errors_leading_to_shots")

  cleaned_names_possession <- c("player", "nation", "position", "club",
                                "age","birth_year", "mins_per_90",
                                "total_touches",
                                "touches_defensive_penalty_box",
                                "touches_defensive_third",
                                "touches_middle_third", "touches_final_third",
                                "touches_attacking_penalty_box",
                                "inplay_touches", "take_ons_attempted",
                                "successful_take_ons",
                                "successful_take_on_percentage",
                                "tackles_during_take_on",
                                "tackles_during_take_on_percentage", "carries",
                                "total_carrying_distance",
                                "progressive_carrying_distance",
                                "progressive_carries",
                                "carries_into_final_third",
                                "carries_into_penalty_box", "miscontrols",
                                "dispossessions", "passes_received",
                                "progressive_passes_received")

  cleaned_names_playing_time <- c("player", "nation", "position", "club",
                                  "age","birth_year", "matches_played",
                                  "minutes", "minutes_per_match",
                                  "percentage_squad_minutes_played",
                                  "mins_per_90", "starts",
                                  "minutes_per_matches_played",
                                  "complete_matches_played", "substitutions",
                                  "minutes_per_substitution", "unused_subs",
                                  "points_per_match", "goals_scored_on_pitch",
                                  "goals_conceded_on_pitch",
                                  "goals_scored_minus_goals_conceded_on_pitch",
                                  "goals_scored_minus_goals_conceded_on_pitch_per90",
                                  "xg_onpitch", "xg_against_on_pitch",
                                  "xg_performance_on_pitch",
                                  "xg_performance_on_pitch_per90")

  cleaned_names_miscellanous <- c("player", "nation", "position", "club",
                                  "age","birth_year", "mins_per_90",
                                  "yellow_cards", "red_cards",
                                  "second_yellow_card", "fouls_committed",
                                  "fouls_drawn", "offsides", "crosses",
                                  "interceptions", "tackles_won",
                                  "penalty_kicks_won", "penalty_kicks_conceded",
                                  "own_goals", "recoveries", "aerial_duels_won",
                                  "aerial_duels_lost",
                                  "aerial_duels_win_percentage")

  # Create a list of column names
  colnames_list <- list(
    cleaned_names_standard,
    cleaned_names_goalkeeping,
    cleaned_names_adv_goalkeeping,
    cleaned_names_shooting,
    cleaned_names_passing,
    cleaned_names_pass_types,
    cleaned_names_goal_creation,
    cleaned_names_defensive_actions,
    cleaned_names_possession,
    cleaned_names_playing_time,
    cleaned_names_miscellanous
  )


  # If season is not provided, set it to the current season
  if (is.null(season)) {
    season <- valid_seasons[length(valid_seasons)]
  }

  # If league not provided, default to english premier league
  if (is.null(league)) {
    league <- "premier_league"
    code <- "9"
    league_stats <- leagues[[league]]
  }

  # Check if league name is valid
  if (!(league %in% names(leagues))) {
    message('Invalid league name. Check the supported leagues with available_leagues()')
    return(NULL)
  }

  # Reference league code from codes list
  if (!is.null(league)) {
    code <- codes[[league]]
  } else {
    message('Invalid league name. Check the supported leagues with available_leagues()')
    return(NULL)
  }

  # If type is not provided, set it to "standard"
  if (is.null(type)) {
    type <- 'standard'
  }

  # Check if the selected type is valid
  if (!(type %in% names(stats_abv))) {
    message('Error: Unsupported type. Check available stats with stat_types()')
    return(NULL)
  }


  check_season <- function(season = NULL) {
    valid_seasons <- c('2018/2019', '2019/2020', '2020/2021',
                       '2021/2022', '2022/2023', '2023/2024',
                       '2024/2025')

    # Normalize the season input
    normalized_season <- season

    # Define patterns for valid season formats
    pattern1 <- "^\\d{4}/\\d{4}$"
    pattern2 <- "^\\d{4}-\\d{4}$"
    pattern3 <- "^\\d{2}/\\d{2}$"
    pattern4 <- "^\\d{2}-\\d{2}$"

    # Attempt to match and convert
    if (grepl(pattern1, normalized_season)) {
      formatted_season <- normalized_season
    } else if (grepl(pattern2, normalized_season)) {
      formatted_season <- paste0(gsub('-', '/', season))
    } else if (grepl(pattern3, normalized_season)) {
      season_range <- unlist(strsplit(season, '/'))
      first_year <- paste0('20', season_range[1])
      second_year <- paste0('20', season_range[2])
      formatted_season <- paste0(first_year, '/', second_year)
    } else if (grepl(pattern4, normalized_season)) {
      season_range <- unlist(strsplit(season, '-'))
      first_year <- paste0('20', season_range[1])
      second_year <- paste0('20', season_range[2])
      formatted_season <- paste0(first_year, '/', second_year)
    } else {
      message('Error: Invalid season format. The season must be in a valid format.')
      return(NULL)
    }

    # Check if the formatted season is in valid_seasons
    if (formatted_season %in% valid_seasons) {
      return(formatted_season)
    } else {
      return(NULL)
    }
  }

  normalized_season <- check_season(season)

  if (is.null(normalized_season)) {
    message('Invalid season. Run available_seasons().')
    return(NULL)
  }


  if (identical(normalized_season, valid_seasons[length(valid_seasons)])) {
    # Use the type parameter to select the appropriate abbreviation
    abbreviation <- stats_abv[[type]]
    #code <- codes[[code]]
    league_stats <- leagues[[league]]

    current_season_url <- paste0(base_url, code, '/', abbreviation, league_stats)

    rD <- RSelenium::rsDriver(browser="firefox", port=4555L, verbose=F, chromever = NULL)
    remDr <- rD$client

    # Navigate to the URL
    remDr$navigate(current_season_url)

    # delay intrtoduced for page to be fully loaded
    Sys.sleep(5)

    # Extract the page source
    page <- remDr$getPageSource()[[1]]

    # Stop the RSelenium server
    remDr$close()
    rD$server$stop()

    tryCatch({
      page <- rvest::read_html(page)

      df <- page |> rvest::html_table(fill = TRUE)
      df <- df[[12]]

      if (is.null(df)) {
        stop('Error: Table could not be scraped. Kindly check input.')
      }
    })

  } else if (!identical(normalized_season, valid_seasons)) {
    normalized_season <- gsub('/', '-', normalized_season)
    abbreviation <- stats_abv[[type]]
    #code <- codes[[code]]
    league_stats <- leagues[[league]]

    season_url <- paste0(base_url, code, '/', normalized_season, '/', abbreviation,
                         normalized_season, '-', league_stats)


    rD <- RSelenium::rsDriver(browser="firefox", port=4555L, verbose=F, chromever = NULL)
    remDr <- rD$client

    # Navigate to the URL
    remDr$navigate(season_url)

    # delay intrtoduced for page to be fully loaded
    Sys.sleep(5)

    # Extract the page source
    page <- remDr$getPageSource()[[1]]

    # Stop the RSelenium server
    remDr$close()
    rD$server$stop()

  } else {
    message('Error: Unexpected webpage format.')
    return(NULL)
  }

  tryCatch({
    page <- rvest::read_html(page)

    df <- page |> rvest::html_table(fill = TRUE)
    df <- df[[12]]

    if (is.null(df)) {
      stop('Error: Web scraping failed. Check function input or try again later')
    }
  })

  header <- df[1, ]  # Get the header row
  colnames(df) <- header
  df <- df[-1, ]
  df <- df[, -c(1, ncol(df))]  # Remove Rk & Matches


  df <- subset(df, df$Player != 'Player') # this removes duplicate header rows.


  # Select the appropriate column names based on the type
  if (type == "standard") {
    column <- cleaned_names_standard
  } else if (type == "goalkeeping") {
    column <- cleaned_names_goalkeeping
  } else if (type == "advanced_goalkeeping") {
    column <- cleaned_names_adv_goalkeeping
  } else if (type == "shooting") {
    column <- cleaned_names_shooting
  } else if (type == "passing") {
    column <- cleaned_names_passing
  } else if (type == "pass_types") {
    column <- cleaned_names_pass_types
  } else if (type == "goal_creation") {
    column <- cleaned_names_goal_creation
  } else if (type == "defensive_actions") {
    column <- cleaned_names_defensive_actions
  } else if (type == "possession") {
    column <- cleaned_names_possession
  } else if (type == "playing_time") {
    column <- cleaned_names_playing_time
  } else if (type == "miscellaneous") {
    column <- cleaned_names_miscellanous
  } else {
    return(NULL)
    message('Could not assign column names.')
  }

  colnames(df) <- column

  return(df)
}

