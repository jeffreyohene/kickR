% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fbref_belgian_pro_league_team_stats.R
\name{fbref_belgian_pro_league_team_stats}
\alias{fbref_belgian_pro_league_team_stats}
\title{Fetch Belgian Pro League team statistics data from FBRef}
\arguments{
\item{season}{A character string representing the season in the format
"YYYY/YYYY" or "YY/YY" (e.g., "2022/2023" or "22/23").}

\item{type}{A character string specifying the type of statistics to retrieve.
Possible values include "standard," "goalkeeping," "advanced_goalkeeping," "shooting," "passing," "pass_types," "goal_creation," "defensive_actions," "possession," "playing_time," and "miscellaneous."}
}
\value{
A data frame containing the requested team statistics.
}
\description{
This function fetches Belgian Pro League team statistics data from FBRef for
a specified season and data type.
}
\examples{
# Fetch standard team statistics for the 2022/2023 season
fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "standard")

# Fetch goalkeeping team statistics for the 2022/2023 season
fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "goalkeeping")

# Fetch advanced goalkeeping team statistics for the 2022/2023 season
fbref_belgian_pro_league_team_stats(season = "2022/2023", type = "advanced_goalkeeping")

}
\seealso{
\url{https://fbref.com/en/comps/37/Belgian-Pro-League-Stats}
}
