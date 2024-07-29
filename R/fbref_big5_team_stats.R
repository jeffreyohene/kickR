#' Scrape and retrieve team statistics from FBref for the Big 5 European leagues.
#'
#' This function scrapes team statistics data from FBref for the Big 5 European leagues,
#' which include the English Premier League, French Ligue 1, Spanish La Liga,
#' German Bundesliga, and Italian Serie A. The data includes information such as
#' matches played, wins, draws, losses, goals scored, goals against, points, and more.
#'
#' @name fbref_big5_team_stats
#'
#' @param season The season for which you want to retrieve team statistics
#'               (e.g., '2021/2022'). If not provided, the function defaults to the
#'               most recent season.
#'
#' @return A data frame containing team statistics for the specified season and leagues.
#'
#' @import rvest
#'
#' @examples
#' \dontrun{
#' fbref_big5_team_stats("2021/2022")
#' }
#'
#' @seealso fbref_big5_player_stats, available_seasons
#'
#' @importFrom rvest read_html html_node html_table
#'
#' @export
# gebrauchte package
if (!requireNamespace("rvest", quietly = TRUE)) {
  install.packages("rvest")
}


fbref_big5_team_stats <- function(season = NULL) {
  code <- 'Big5/'
  league_stats <- 'Big-5-European-Leagues-Stats'
  base_url <- 'https://fbref.com/en/comps/'
  selector <- '//*[@id="big5_table"]'

  valid_seasons <- c('2018/2019', '2019/2020','2020/2021',
                     '2021/2022', '2022/2023', '2023/2024')



  # Define the expected vectors for table
  column_names <- c(
    "Rk", "Squad", "Country", "LgRk", "MP", "W", "D", "L",
    "GF", "GA", "GD", "Pts", "Pts/MP", "xG", "xGA", "xGD",
    "xGD/90", "Last 5", "Attendance", "Top Team Scorer", "Goalkeeper"
  )

  cleaned_column_names <- c('club', 'country','league_rank','matches_played',
                            'wins','draws','losses','goals_for',
                            'goals_against','goal_difference','points',
                            'points_per_match','xG','xGA','xGD','xgd/90',
                            'form_last5_matches','attendance_per_game',
                            'top_team_scorer','goalkeeper')

  # If season is not provided, set it to the current season
  if (is.null(season)) {
    season <- valid_seasons[length(valid_seasons)]
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
    message('Error: Invalid season or season not provided.')
    return(NULL)
  }

  if (identical(normalized_season, valid_seasons[length(valid_seasons)])) {
    current_season_url <- paste0(base_url, code, '/', league_stats)

    # Introduce a 5-second delay before making the request
    Sys.sleep(5)

    page <- rvest::read_html(current_season_url)
  } else {
    normalized_season <- gsub('/','-', normalized_season)
    season_url <- paste0(base_url, code, normalized_season, '/',
                         normalized_season, '-', league_stats)

    # Introduce a 5-second delay before making the request
    Sys.sleep(5)

    page <- rvest::read_html(season_url)
  }


  df <- page |>
    rvest::html_node(xpath = selector) |>
    rvest::html_table(fill = TRUE)

  if (is.null(df)) {
    message('Error: Web scraping failed. Check the URL or try again later.')
    return(NULL)
  }


  colnames(df) <- cleaned_column_names

  return(df)
}
