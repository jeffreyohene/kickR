% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fbref_serie_a_team_stats.R
\name{fbref_serie_a_team_stats}
\alias{fbref_serie_a_team_stats}
\title{Retrieve Italian Serie A team stats from FBref for a given season and type.}
\arguments{
\item{season}{A character string representing the season in the format 'YYYY/YYYY'.
Default is the current season.}

\item{type}{A character string specifying the type of statistics to retrieve.
Default is 'standard'. Valid types include 'standard', 'goalkeeping',
'advanced_goalkeeping', 'shooting', 'passing', 'pass_types',
'goal_creation', 'defensive_actions', 'possession', 'playing_time',
'miscellaneous'.}
}
\value{
A data frame containing the requested team statistics for the
         specified season and type.
}
\description{
This function retrieves Serie A team statistics from the FBref website for a
specified season and type.
}
\examples{
fbref_serie_a_team_stats(season = '2018/2019', type = 'pass_types')

}
\seealso{
\url{https://fbref.com/en/comps/11/Serie-A-Stats}
}
