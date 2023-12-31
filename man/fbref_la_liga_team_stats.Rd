% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fbref_la_liga_team_stats.R
\name{fbref_la_liga_team_stats}
\alias{fbref_la_liga_team_stats}
\title{Get Spanish La Liga team statistics from FBref}
\arguments{
\item{season}{The season for which you want to retrieve statistics
(e.g., "2022/2023"). Defaults to the current season.}

\item{type}{The type of statistics to retrieve. Options include "standard,"
"goalkeeping," "advanced_goalkeeping," "shooting," "passing," "pass_types,"
"goal_creation," "defensive_actions," "possession," "playing_time," and
"miscellaneous." Defaults to "standard."}
}
\value{
A data frame containing the requested team statistics.
}
\description{
This function retrieves team statistics for La Liga from FBref for a
specified season and type.
}
\examples{
# Get standard statistics for the 2022/2023 season
fbref_la_liga_team_stats(season = "2022/2023", type = "standard")

# Get goalkeeping statistics for the 2022/2023 season
fbref_la_liga_team_stats(season = "2022/2023", type = "goalkeeping")

}
\seealso{
\url{https://fbref.com/en/comps/12/La-Liga-Stats}
}
