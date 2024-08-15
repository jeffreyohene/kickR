#' Retrieve football team statistics from FBREF
#'
#' This function retrieves football team statistics from FBREF for a specified
#' league, season, and type of statistics.
#'
#' @name find_similar_players
#'
#' @param df The data scraped using kickR's fbref_player_stats() or
#'  fbref_big_5_player_stats()
#' @param player The player(target) for whom you would like to find other
#'  similar players
#' @param metrics The metrics you would like to find similar players for. For
#'   example if you want to find similar players in possession, a metric that
#'   would interest you might be inplay touches/passes etc. The function would
#'   return players, whose output in said metric(s) are similar to the target
#'   player supplied.
#' @param formula The type of formula to calculate similarity. This function
#'   uses cosine or euclidean but defaults to cosine similarity. For a metric
#'   or smaller group of similar metrics, cosine performs better.
#' @param top_n The number of similar players you want to return.
#'   function defaults to top 15 most similar players.
#' @return A data frame containing similar players based on cosine similarity
#'   or euclidean distance.
#'
#'
#' @examples
#'\dontrun{
#'# Find similar players to Martin Ødegaard in terms of specified passing metrics
#' find_similar_players(df = df,
#'                      player ="Martin Ødegaard",
#'                      metrics = c("xAG","xA","key_passes",
#'                                  "passes_into_final_third",
#'                                  "passes_into_penalty_box",
#'                                  "progressive_passes"),
#'                      formula = "euclidean",
#'                      top_n = 15)
#'}
#' @export
find_similar_players <- function(df, player, metrics = NULL, formula = "cosine", top_n = 15) {

  # formula input handling
  formula <- tolower(formula)

  if (is.null(formula)) {
    formula <- "cosine"
  }

  # Column names to match since expected dataframe needs to be in kickR format
  standard <- c("player", "nation", "position","club",
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

  goalkeeping <- c("player", "nation", "position", "club",
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

  adv_goalkeeping <- c("player", "nation", "position",
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

  shooting <- c("player", "nation", "position", "club",
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

  passing <- c("player", "nation", "position", "club", "age",
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

  pass_types <- c("player", "nation", "position", "club",
                  "age","birth_year", "mins_per_90",
                  "total_passes_attempted", "live_ball_passes",
                  "dead_ball_passes", "passes_from_free_kicks",
                  "through_balls", "switches", "crosses",
                  "throw_ins", "corner_kicks",
                  "inswinging_corner_kicks",
                  "outswinging_corner_kicks",
                  "straight_corner_kicks", "passes_completed",
                  "passes_offside", "blocks")

  goal_creation <- c("player", "nation", "position", "club",
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

  defensive_actions <- c("player", "nation", "position", "club",
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

  possession <- c("player", "nation", "position", "club",
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

  playing_time <- c("player", "nation", "position", "club",
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

  miscellanous <- c("player", "nation", "position", "club",
                    "age","birth_year", "mins_per_90",
                    "yellow_cards", "red_cards",
                    "second_yellow_card", "fouls_committed",
                    "fouls_drawn", "offsides", "crosses",
                    "interceptions", "tackles_won",
                    "penalty_kicks_won", "penalty_kicks_conceded",
                    "own_goals", "recoveries", "aerial_duels_won",
                    "aerial_duels_lost",
                    "aerial_duels_win_percentage")

  column_names <- list(
    standard = standard,
    goalkeeping = goalkeeping,
    adv_goalkeeping = adv_goalkeeping,
    shooting = shooting,
    passing = passing,
    pass_types = pass_types,
    goal_creation = goal_creation,
    defensive_actions = defensive_actions,
    possession = possession,
    playing_time = playing_time,
    miscellanous = miscellanous
  )

  # Define the expected vectors for each data type
  b5_standard <- c("player", "nation", "position","club",
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

  b5_goalkeeping <- c("player", "nation", "position", "club",
                      "league","age","birth_year",
                      "total_matches_played","starts",
                      "total_minutes_played", "mins_per_90",
                      "goals_against", "goals_against_per90",
                      "shots_on_target_against", "saves",
                      "save_percentage", "wins", "draws","losses",
                      "clean_sheets", "clean_sheet_percentage",
                      "penalties_attempted", "penalty_kicks_allowed",
                      "penalty_kicks_saved", "penalty_kicks_missed",
                      "penalty_kicks_save_percentage")

  b5_adv_goalkeeping <- c("player", "nation", "position",
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
                          "crosses_stopped","percentage_crosses_stopped",
                          "defensive_actions_outside_penalty_box",
                          "defensive_actions_outside_penalty_box_per90",
                          "defensive_actions_outside_penalty_box_avg_dist")

  b5_shooting <- c("player", "nation", "position", "club","league",
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

  b5_passing <- c("player", "nation", "position", "club","league",
                  "age","birth_year", "mins_per_90",
                  "total_passes_completed", "total_passes_attempted",
                  "pass_completion_percentage", "total_passing_distance",
                  "total_progressive_distance", "short_passes_completed",
                  "short_passes_attempted", "short_pass_completion_percentage",
                  "medium_passes_completed", "medium_passes_attempted",
                  "medium_pass_completion_percentage", "long_passes_completed",
                  "long_passes_attempted", "long_pass_completion_percentage",
                  "assists", "xAG", "xA", "xag_performance", "key_passes",
                  "passes_into_final_third", "passes_into_penalty_box",
                  "crosses_into_penalty_box", "progressive_passes")

  b5_pass_types <- c("player", "nation", "position", "club","league",
                     "age","birth_year", "mins_per_90",
                     "total_passes_attempted", "live_ball_passes",
                     "dead_ball_passes", "passes_from_free_kicks",
                     "through_balls", "switches", "crosses",
                     "throw_ins", "corner_kicks", "inswinging_corner_kicks",
                     "outswinging_corner_kicks", "straight_corner_kicks",
                     "passes_completed", "passes_offside", "blocks")

  b5_goal_creation <- c("player", "nation", "position", "club", "league",
                        "age","birth_year", "mins_per_90",
                        "shot_creating_actions", "shot_creating_actions_per90",
                        "sca_live_passes", "sca_dead_passes",
                        "sca_take_ons", "sca_shots", "sca_fouls",
                        "sca_defensive_actions", "goal_creating_actions",
                        "goal_creating_actions_per90", "gca_live_passes",
                        "gca_dead_passes", "gca_take_ons", "gca_shots",
                        "gca_fouls", "gca_defensive_actions")

  b5_defensive_actions <- c("player", "nation", "position", "club",
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

  b5_possession <- c("player", "nation", "position", "club","league",
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

  b5_playing_time <- c("player", "nation", "position", "club",
                       "league","age","birth_year", "matches_played",
                       "minutes", "minutes_per_match",
                       "percentage_squad_minutes_played", "mins_per_90",
                       "starts", "minutes_per_matches_played",
                       "complete_matches_played", "substitutions",
                       "minutes_per_substitution", "unused_subs",
                       "points_per_match", "goals_scored_on_pitch",
                       "goals_conceded_on_pitch",
                       "goals_scored_minus_goals_conceded_on_pitch",
                       "goals_scored_minus_goals_conceded_on_pitch_per90",
                       "xg_onpitch", "xg_against_on_pitch",
                       "xg_performance_on_pitch",
                       "xg_performance_on_pitch_per90")

  b5_miscellanous <- c("player", "nation", "position", "club", "league","age",
                       "birth_year", "mins_per_90", "yellow_cards",
                       "red_cards", "second_yellow_card", "fouls_committed",
                       "fouls_drawn", "offsides", "crosses", "interceptions",
                       "tackles_won", "penalty_kicks_won",
                       "penalty_kicks_conceded", "own_goals", "recoveries",
                       "aerial_duels_won", "aerial_duels_lost",
                       "aerial_duels_win_percentage")


  col_names <- list(
    standard = b5_standard,
    goalkeeping = b5_goalkeeping,
    adv_goalkeeping = b5_adv_goalkeeping,
    shooting = b5_shooting,
    passing = b5_passing,
    pass_types = b5_pass_types,
    goal_creation = b5_goal_creation,
    defensive_actions = b5_defensive_actions,
    possession = b5_possession,
    playing_time = b5_playing_time,
    miscellanous = b5_miscellanous
  )

  # Checks to ensure dataframe is in expected format
  if (is.null(df)) {
    message("Error: No dataframe provided. Check kickR documentation")
    return(NULL)
  }

  if (nrow(df) == 0) {
    message("Error: dataset empty, supply a valid dataset")
    return(NULL)
  }

  # Function to check and assign type
  assign_type <- function(df, column_names, col_names) {
    df_colnames <- colnames(df)

    # First check against the original column names
    for (type in names(column_names)) {
      expected_cols <- column_names[[type]]
      if (all(expected_cols %in% df_colnames) && all(df_colnames %in% expected_cols)) {
        return(type)
      }
    }

    # If no match found, check against the B5 column names
    for (type in names(col_names)) {
      expected_cols <- col_names[[type]]
      if (all(expected_cols %in% df_colnames) && all(df_colnames %in% expected_cols)) {
        return(type)
      }
    }

    return("unknown")
  }

  # Check and assign the type of dataset
  data_type <- assign_type(df, column_names, col_names)
  if (data_type == "unknown") {
    message("Error: Data type could not be identified. Check column names.")
    return(NULL)
  }

  # Ensure metrics are provided
  if (is.null(metrics)) {
    message("Error: No metrics provided. Supply a a metric or a vector of metric names.")
    return(NULL)
  }

  # Ensure the metrics columns are numeric
  df[, metrics] <- lapply(df[, metrics], function(x) as.numeric(as.character(x)))

  # Extract the target player's data
  target_player <- df[df$player == player, metrics, drop = F]
  target_player <- as.numeric(target_player)

  # Function for cosine similarity
  cosine_similarity_with_target <- function(player) {
    dot_product <- sum(target_player * player)
    norm_target <- sqrt(sum(target_player^2))
    norm_player <- sqrt(sum(player^2))
    cosine_sim <- dot_product / (norm_target * norm_player)
    return(cosine_sim)
  }

  # Function for Euclidean distance
  euclidean_distance_with_target <- function(player) {
    euclidean_dist <- sqrt(sum((target_player - player)^2))
    return(euclidean_dist)
  }


  # Calculate similarity or distance based on chosen formula
  if (formula == "cosine") {
    # Calculate cosine similarity for all players
    similarities <- apply(df[, metrics],
                          1,
                          function(row) cosine_similarity_with_target(as.numeric(row)))

    similar_players_df <- data.frame(player = df$player,
                                     similarity = similarities)
    similar_players_df <- similar_players_df[order(similar_players_df$similarity,
                                                   decreasing = T), ]
  } else if (formula == "euclidean") {
    # Calculate euclidean distances for all players
    distances <- apply(df[, metrics],
                       1,
                       function(row) euclidean_distance_with_target(as.numeric(row)))

    similar_players_df <- data.frame(player = df$player, distance = distances)

    similar_players_df <- similar_players_df[order(similar_players_df$distance), ]
  } else if (!formula %in% c("cosine", "euclidean")) {
    message("Error: The 'formula' parameter must be either 'cosine' or 'euclidean'.")
    return(NULL)
  }

  # Return top 15 most similar players
  return(similar_players_df[1:min(top_n, nrow(similar_players_df)), ])
}
