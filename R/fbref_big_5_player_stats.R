#' Get football statistics for players from the top 5 European leagues (Big 5).
#'
#' This function retrieves football statistics for players from the top 5
#' European leagues, commonly referred to as the "Big 5" leagues.
#'
#' These leagues include:
#' - English Premier League (EPL)
#' - La Liga (Spain)
#' - Serie A (Italy)
#' - Bundesliga (Germany)
#' - Ligue 1 (France)
#'
#' @name fbref_big5_player_stats
#' @param season The season for which statistics are requested
#'              (e.g., "2022/2023"). If not provided, the most recent season will be used.
#' @param type The type of statistics to retrieve (e.g., "standard",
#'              "goalkeeping", "shooting"). If not provided, "standard" statistics
#'              will be used.
#'
#' @return A data frame containing football statistics for players in the
#' specified season and of the specified type.
#'
#' @examples
#'
#' # Get passing player statistics for the 2022/2023 season
#' fbref_big5_player_stats(season = "2022/2023", type = "passing")
#'
#' @seealso
#' \url{https://fbref.com/en/comps/Big5/Big-5-European-Leagues-Stats}
#'
#' @importFrom rvest read_html html_node html_table
#'
#' @export
# gebrauchte package
if (!requireNamespace("rvest", quietly = TRUE)) {
  install.packages("rvest")
}

fbref_big5_player_stats <- function(season = NULL, type = NULL) {
  base_url <- 'https://fbref.com/en/comps/'
  code <- 'Big5/'
  standard <- 'stats/'
  spieler <- 'players/'
  league_stats <- 'Big-5-European-Leagues-Stats'

  # Define valid seasons
  valid_seasons <- c('2018/2019','2019/2020','2020/2021',
                     '2021/2022','2022/2023','2023/2024')

  # Define a mapping of type values to CSS selectors
  type_to_selector <- list(
    standard = '#stats_standard',
    goalkeeping = '#stats_keeper',
    advanced_goalkeeping = '#stats_keeper_adv',
    shooting = '#stats_shooting',
    passing = '#stats_passing',
    pass_types = '#stats_passing_types',
    goal_creation = '#stats_gca',
    defensive_actions = '#stats_defense',
    possession = '#stats_possession',
    playing_time = '#stats_playing_time',
    miscellaneous = '#stats_misc'
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
                                 "league", "age", "birth_year","matches_played",
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
                                    "league","age","birth_year",
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
                                     "club","league","age","birth_year",
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

  cleaned_names_shooting <- c("player", "nation", "position", "club","league",
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

  cleaned_names_passing <- c("player", "nation", "position", "club","league",
                             "age","birth_year", "mins_per_90",
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

  cleaned_names_pass_types <- c("player", "nation", "position", "club","league",
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
                                   "league","age","birth_year", "mins_per_90",
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
                                       "league","age","birth_year",
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

  cleaned_names_possession <- c("player", "nation", "position", "club","league",
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
                                  "league","age","birth_year", "matches_played",
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
                                  "league","age","birth_year", "mins_per_90",
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

  # If type is not provided, set it to "standard"
  if (is.null(type)) {
    type <- 'standard'
  }

  # Check if the selected type is valid
  if (!(type %in% names(type_to_selector))) {
    message('Error: Unsuported type. Check available stats with stat_types()')
    return(NULL)
  }


  check_season <- function(season = NULL) {
    valid_seasons <- c('2018/2019', '2019/2020','2020/2021', '2021/2022',
                       '2022/2023', '2023/2024')

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

  if (is.null(normalized_season)) {
    message('Error: Invalid season input. Run available_seasons().')
    return(NULL)
  }

  if (identical(normalized_season, valid_seasons[length(valid_seasons)])) {
    # Use the type parameter to select the appropriate abbreviation
    abbreviation <- stats_abv[[type]]

    current_season_url <- paste0(base_url, code, abbreviation, spieler,
                                 league_stats)

    # Introduce a 5-second delay before making the request
    Sys.sleep(5)

    page <- read_html(current_season_url)

  } else if (!identical(normalized_season, valid_seasons)) {
    normalized_season <- gsub('/', '-', normalized_season)
    abbreviation <- stats_abv[[type]]

    season_url <- paste0(base_url, code, normalized_season, '/', abbreviation,
                         spieler, normalized_season, '-', league_stats)

    # Introduce a 5-second delay before making the request
    Sys.sleep(5)


    page <- rvest::read_html(season_url)
  } else {
    message('Error: Unexpected webpage format.')
    return(NULL)
  }

  selector <- type_to_selector[[type]]

  df <- page |>
    rvest::html_node(selector) |>
    rvest::html_table(fill = T)

  if (is.null(df)) {
    message('Error: Web scraping failed. Check the URL or try again later.')
    return(NULL)
  }

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
