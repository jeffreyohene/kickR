% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fbref_segunda_division_team_stats.R
\name{fbref_segunda_division_team_stats}
\alias{fbref_segunda_division_team_stats}
\title{Get team statistics for the Spanish Segunda División.}
\arguments{
\item{season}{A character string representing the season in the format
'YYYY/YYYY' or 'YY/YY'.
 If not provided, the function will use the current season.}

\item{type}{A character string representing the type of statistics to retrieve.
Options include 'standard', 'goalkeeping', 'advanced_goalkeeping',
'shooting','passing', 'pass_types', 'goal_creation',
'defensive_actions', 'possession','playing_time', and
'miscellaneous'. If not provided, 'standard' will be used.}
}
\value{
A data frame containing team statistics for the specified season and
         type.
}
\description{
This function retrieves team statistics for the Segunda División. football league
from FBref.com for a specified season and type.
}
\examples{
# Retrieve standard team statistics for the 2022/2023 season
data <- fbref_segunda_division_team_stats(season = '2022/2023', type = 'standard')

# Retrieve goalkeeping statistics for the current season
data <- fbref_segunda_division_team_stats(type = 'goalkeeping')
}
\seealso{
\url{https://fbref.com/en/comps/17/Segunda-Division-Stats}
}
