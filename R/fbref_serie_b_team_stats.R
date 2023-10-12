#' Retrieve Serie B team stats from FBref for a given season and type.
#'
#' This function retrieves Serie B team statistics from the FBref website for a
#' specified season and type.
#' @name fbref_serie_b_team_stats
#'
#' @param season A character string representing the season in the format
#'              'YYYY/YYYY'. Default is the current season.
#' @param type A character string specifying the type of statistics to retrieve.
#'             Default is 'standard'. Valid types include 'standard', 'goalkeeping',
#'             'advanced_goalkeeping', 'shooting', 'passing', 'pass_types',
#'             'goal_creation', 'defensive_actions', 'possession', 'playing_time',
#'             'miscellaneous'.
#'
#' @return A data frame containing the requested team statistics for the
#'          specified season and type.
#'
#' @examples
#' fbref_serie_b_team_stats(season = '2021/2022', type = 'shooting')
#'
#' @importFrom rvest read_html html_node html_table
#'
#' @seealso
#' \url{https://fbref.com/en/comps/18/Serie-B-Stats}
#' @export
if (!requireNamespace("rvest", quietly = TRUE)) {
  install.packages("rvest")
}

fbref_serie_b_team_stats <- function(season = NULL, type = NULL) {

  code <- 18
  league_stats <- 'Serie-B-Stats'
  base_url <- 'https://fbref.com/en/comps/'

  valid_seasons <- c('2018/2019', '2019/2020','2020/2021',
                     '2021/2022', '2022/2023', '2023/2024')

  # Define a mapping of type values to CSS selectors
  type_to_selector <- list(
    standard = '#stats_squads_standard_for',
    goalkeeping = '#stats_squads_keeper_for',
    advanced_goalkeeping = '#stats_squads_keeper_adv_for',
    shooting = '#stats_squads_shooting_for',
    passing = '#stats_squads_passing_for',
    pass_types = '#stats_squads_passing_types_for',
    goal_creation = '#stats_squads_gca_for',
    defensive_actions = '#stats_squads_defense_for',
    possession = '#stats_squads_possession_for',
    playing_time = '#stats_squads_playing_time_for',
    miscellaneous = '#stats_squads_misc_for'
  )

  # Define the expected vectors for each data type
  standard <- c(
    'Squad', '# Pl', 'Age', 'Poss', 'MP', 'Starts', 'Min', '90s', 'Gls', 'Ast',
    'G+A', 'G-PK', 'PK', 'PKatt', 'CrdY', 'CrdR', 'xG', 'npxG', 'xAG',
    'npxG+xAG', 'PrgC', 'PrgP', 'Gls', 'Ast', 'G+A', 'G-PK', 'G+A-PK', 'xG',
    'xAG', 'xG+xAG', 'npxG', 'npxG+xAG'
  )

  goalkeeping <- c(
    'Squad', '# Pl', 'MP', 'Starts', 'Min', '90s', 'GA', 'GA90', 'SoTA',
    'Saves', 'Save%', 'W', 'D', 'L', 'CS', 'CS%', 'PKatt', 'PKA', 'PKsv',
    'PKm', 'Save%'
  )

  advanced_goalkeeping <- c(
    'Squad', '# Pl', '90s', 'GA', 'PKA', 'FK', 'CK', 'OG', 'PSxG', 'PSxG/SoT',
    'PSxG+/-', '/90', 'Cmp', 'Att', 'Cmp%', 'Att', 'Thr', 'Launch%', 'AvgLen',
    'Att', 'Launch%', 'AvgLen', 'Opp', 'Stp', 'Stp%', '#OPA', '#OPA/90',
    'AvgDist'
  )

  shooting <- c(
    'Squad', '# Pl', '90s', 'Gls', 'Sh', 'SoT', 'SoT%', 'Sh/90', 'SoT/90',
    'G/Sh', 'G/SoT', 'Dist', 'FK', 'PK', 'PKatt', 'xG', 'npxG', 'npxG/Sh',
    'G-xG', 'np:G-xG'
  )

  passing <- c(
    'Squad', '# Pl', '90s', 'Cmp', 'Att', 'Cmp%', 'TotDist', 'PrgDist', 'Cmp',
    'Att', 'Cmp%', 'Cmp', 'Att', 'Cmp%', 'Cmp', 'Att', 'Cmp%', 'Ast', 'xAG',
    'xA', 'A-xAG', 'KP', '1/3', 'PPA', 'CrsPA', 'PrgP'
  )

  pass_types <- c(
    'Squad', '# Pl', '90s', 'Att', 'Live', 'Dead', 'FK', 'TB', 'Sw', 'Crs',
    'TI', 'CK', 'In', 'Out', 'Str', 'Cmp', 'Off', 'Blocks'
  )

  goal_creation <- c(
    'Squad', '# Pl', '90s', 'SCA', 'SCA90', 'PassLive', 'PassDead', 'TO', 'Sh',
    'Fld', 'Def', 'GCA', 'GCA90', 'PassLive', 'PassDead', 'TO', 'Sh', 'Fld',
    'Def'
  )

  defensive_actions <- c(
    'Squad', '# Pl', '90s', 'Tkl', 'TklW', 'Def 3rd', 'Mid 3rd', 'Att 3rd',
    'Tkl', 'Att', 'Tkl%', 'Lost', 'Blocks', 'Sh', 'Pass', 'Int', 'Tkl+Int',
    'Clr', 'Err'
  )

  possession <- c(
    'Squad', '# Pl', 'Poss', '90s', 'Touches', 'Def Pen', 'Def 3rd', 'Mid 3rd',
    'Att 3rd', 'Att Pen', 'Live', 'Att', 'Succ', 'Succ%', 'Tkld', 'Tkld%',
    'Carries', 'TotDist', 'PrgDist', 'PrgC', '1/3', 'CPA', 'Mis', 'Dis', 'Rec',
    'PrgR'
  )

  playing_time <- c(
    'Squad', '# Pl', 'Age', 'MP', 'Min', 'Mn/MP', 'Min%', '90s', 'Starts',
    'Mn/Start', 'Compl', 'Subs', 'Mn/Sub', 'unSub', 'PPM', 'onG', 'onGA',
    '+/-', '+/-90', 'onxG', 'onxGA', 'xG+/-', 'xG+/-90'
  )

  miscellaneous <- c(
    'Squad', '# Pl', '90s', 'CrdY', 'CrdR', '2CrdY', 'Fls', 'Fld', 'Off', 'Crs',
    'Int', 'TklW', 'PKwon', 'PKcon', 'OG', 'Recov', 'Won', 'Lost', 'Won%'
  )



  # Cleaned names
  cleaned_names_standard <- c(
    'club', 'number_of_players_used', 'average_age', 'possession',
    'matches_played', 'starts', 'minutes', 'mins_per_90', 'goals', 'assists',
    'goals_and_assists', 'non_penalty_goals', 'penalties',
    'penalty_kick_attempts', 'yellow_cards', 'red_cards', 'xG', 'npxG', 'xAG',
    'npxG+xAG', 'progressive_carries', 'progressive_passes', 'goals_per90',
    'assists_per90', 'goals_and_assists_per90', 'non_penalty_goals_per90',
    'non_penalty_goals_and_assists_per90', 'xg_per90', 'xag_per90',
    'xg_and_xag_per90', 'npxg_per90', 'npxg_and_xag_per90'
  )

  cleaned_names_goalkeeping <- c(
    'club', 'league', 'matches_played', 'squad', 'total_minutes_played',
    'mins_per_90', 'goals_against', 'goals_against_per90',
    'shots_on_target_against', 'saves', 'save_percentage', 'wins', 'draws',
    'losses', 'clean_sheets', 'clean_sheet_percentage', 'penalties_attempted',
    'penalty_kicks_allowed', 'penalty_kicks_saved', 'penalty_kicks_missed',
    'penalty_kicks_save_percentage'
  )

  cleaned_names_adv_goalkeeping <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'goals_against',
    'penalty_kicks_allowed', 'free_kick_goals_against',
    'corner_kick_goals_against', 'own_goals_against', 'PSxG',
    'PSxG_per_shot_on_target', 'PSxG_minus_goals_allowed',
    'PSxG_minus_goals_allowed_per90', 'launched_passes_completed',
    'launched_passes_attempted', 'launched_passes_completion_pct',
    'passes_attempted', 'throws_attempted', 'percentage_passes_launched',
    'avg_pass_length', 'goal_kicks', 'percentage_goal_kicks_launched',
    'avg_goal_kick_length', 'crosses_faced', 'crosses_stopped',
    'percentage_crosses_stopped', 'defensive_actions_outside_penalty_box',
    'defensive_actions_outside_penalty_box_per90',
    'defensive_actions_outside_penalty_box_avg_dist'
  )

  cleaned_names_shooting <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'goals_against',
    'shots', 'shots_on_target', 'shots_on_target_percentage',
    'shots_per90', 'shots_on_target_per90', 'goals_per_shot',
    'goals_per_shot_on_target', 'average_shot_distance', 'free_kick_shots',
    'penalty_kicks_converted', 'penalty_kicks_attempted', 'xG',
    'npxG', 'npxG_per_shot', 'xg_performance', 'npxg_performance'
  )

  cleaned_names_passing <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'total_passes_completed',
    'total_passes_attempted', 'pass_completion_percentage',
    'total_passing_distance', 'total_progressive_distance',
    'short_passes_completed', 'short_passes_attempted',
    'short_pass_completion_percentage', 'medium_passes_completed',
    'medium_passes_attempted', 'medium_pass_completion_percentage',
    'long_passes_completed', 'long_passes_attempted',
    'long_pass_completion_percentage', 'assists', 'xAG', 'xA',
    'xag_performance', 'key_passes', 'passes_into_final_third',
    'passes_into_penalty_box', 'crosses_into_penalty_box',
    'progressive_passes'
  )

  cleaned_names_pass_types <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'total_passes_attempted',
    'live_ball_passes', 'dead_ball_passes', 'passes_from_free_kicks',
    'through_balls', 'switches', 'crosses', 'throw_ins', 'corner_kicks',
    'inswinging_corner_kicks', 'outswinging_corner_kicks',
    'straight_corner_kicks', 'passes_completed', 'passes_offside', 'blocks'
  )

  cleaned_names_goal_creation <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'shot_creating_actions',
    'shot_creating_actions_per90', 'sca_live_passes', 'sca_dead_passes',
    'sca_take_ons', 'sca_shots', 'sca_fouls', 'sca_defensive_actions',
    'goal_creating_actions', 'goal_creating_actions_per90', 'gca_live_passes',
    'gca_dead_passes', 'gca_take_ons', 'gca_shots', 'gca_fouls',
    'gca_defensive_actions'
  )

  cleaned_names_defensive_actions <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'players_tackled',
    'tackles_won', 'defensive_third_tackles', 'middle_third_tackles',
    'final_third_tackles', 'dribblers_tackled', 'dribbles_challenged',
    'percentage_of dribblers_tackled', 'challenges_lost',
    'total_blocks', 'shots_blocked', 'passes_blocked', 'interceptions',
    'tackles_and_interceptions', 'clearances', 'errors_leading_to_shots'
  )

  cleaned_names_possession <- c(
    'club', 'number_of_players_used', 'possession', 'mins_per_90',
    'total_touches', 'touches_defensive_penalty_box', 'touches_defensive_third',
    'touches_middle_third', 'touches_final_third',
    'touches_attacking_penalty_box', 'inplay_touches', 'take_ons_attempted',
    'successful_take_ons', 'successful_take_on_percentage',
    'tackles_during_take_on', 'tackles_during_take_on_percentage', 'carries',
    'total_carrying_distance', 'progressive_carrying_distance',
    'progressive_carries', 'carries_into_final_third',
    'carries_into_penalty_box', 'miscontrols', 'dispossessions',
    'passes_received', 'progressive_passes_received'
  )

  cleaned_names_playing_time <- c(
    'club', 'number_of_players_used', 'average_age', 'matches_played',
    'minutes', 'minutes_per_match', 'percentage_squad_minutes_played',
    'mins_per_90', 'starts', 'minutes_per_matches_played',
    'complete_matches_played', 'substitutions', 'minutes_per_substitution',
    'unused_subs', 'points_per_match', 'goals_scored_on_pitch',
    'goals_conceded_on_pitch', 'goals_scored_minus_goals_conceded'
  )

  cleaned_names_miscellanous <- c(
    'club', 'number_of_players_used', 'mins_per_90', 'yellow_cards',
    'red_cards', 'second_yellow_card', 'fouls_committed', 'fouls_drawn',
    'offsides', 'crosses', 'interceptions', 'tackles_won',
    'penalty_kicks_won', 'penalty_kicks_conceded', 'own_goals',
    'recoveries', 'aerial_duels_won', 'aerial_duels_lost',
    'aerial_duels_win_percentage'
  )


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

  # Check if type is valid
  if (!(type %in% names(type_to_selector))) {
    message('Invalid type. Please provide a valid type.')
    return(NULL)
  }

  check_season <- function(season = NULL) {
    valid_seasons <- c('2018/2019', '2019/2020','2020/2021',
                       '2021/2022', '2022/2023', '2023/2024')

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
    message('Invalid season or season not provided.')
    return(NULL)
  }

  if (identical(normalized_season, valid_seasons[length(valid_seasons)])) {
    current_season_url <- paste0(base_url, code, '/', league_stats)

    # Introduce a 5-second delay before making the request
    Sys.sleep(5)

    page <- rvest::read_html(current_season_url)
  } else {
    normalized_season <- gsub('/','-', normalized_season)
    season_url <- paste0(base_url, code, '/', normalized_season, '/',
                         normalized_season, '-', league_stats)

    # Introduce a 5-second delay before making the request
    Sys.sleep(5)

    page <- rvest::read_html(season_url)
  }

  selector <- type_to_selector[[type]]

  df <- page |>
    rvest::html_node(selector) |>
    rvest::html_table(fill = TRUE)

  if (is.null(df)) {
    message('Error: Web scraping failed. Check the URL or try again later.')
    return(NULL)
  }

  header <- df[1, ]  # Get the header row
  colnames(df) <- header
  df <- df[-1, ]

  # Select the appropriate column names based on the type
  if (type == 'standard') {
    column <- cleaned_names_standard
  } else if (type == 'goalkeeping') {
    column <- cleaned_names_goalkeeping
  } else if (type == 'advanced_goalkeeping') {
    column <- cleaned_names_adv_goalkeeping
  } else if (type == 'shooting') {
    column <- cleaned_names_shooting
  } else if (type == 'passing') {
    column <- cleaned_names_passing
  } else if (type == 'pass_types') {
    column <- cleaned_names_pass_types
  } else if (type == 'goal_creation') {
    column <- cleaned_names_goal_creation
  } else if (type == 'defensive_actions') {
    column <- cleaned_names_defensive_actions
  } else if (type == 'possession') {
    column <- cleaned_names_possession
  } else if (type == 'playing_time') {
    column <- cleaned_names_playing_time
  } else if (type == 'miscellaneous') {
    column <- cleaned_names_miscellanous
  } else {
    return(NULL)
    message('Could not assign column names.')
  }


  colnames(df) <- column

  return(df)
}
