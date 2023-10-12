#' Print available football team statistics types
#'
#' This function prints the available statistics types that are available for leagues.
#'
#' @return Prints the available statistics types to the console.
#'
#' @examples
#'
#' # Print available statistics types
#' stat_types()
#'
#'
#' @export

stat_types <- function() {
  cat("Available statistics types:\n")
  cat("  - standard\n")
  cat("  - goalkeeping\n")
  cat("  - advanced_goalkeeping\n")
  cat("  - shooting\n")
  cat("  - passing\n")
  cat("  - pass_types\n")
  cat("  - goal_creation\n")
  cat("  - defensive_actions\n")
  cat("  - possession\n")
  cat("  - playing_time\n")
  cat("  - miscellaneous\n")
}
