% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fbref_team_stats.R
\name{fbref_team_stats}
\alias{fbref_team_stats}
\title{Retrieve football team statistics from FBref}
\arguments{
\item{league}{The league from which you want to retrieve data from}

\item{season}{The season for which you want to retrieve statistics
(e.g., '2021/2022'). If not provided, the current season is used.}

\item{type}{The type of metric you want to retrieve (e.g., 'standard',
'goalkeeping'). If not provided, 'standard' statistics are used.}
}
\value{
A data frame containing the requested team statistics.
}
\description{
This function retrieves football team statistics from FBref for a specified
league, season, and type of statistics.
}
\examples{
\dontrun{
# Retrieve Premier League standard statistics for the current season
fbref_team_stats(league = 'Premier League', type = 'standard')

# Retrieve Bundesliga 2 shooting statistics for the 2022/2023 season
fbref_team_stats(league = 'Bundesliga 2', season = '2022/2023', type = 'shooting')
}

}
\seealso{
stat_types

available_leagues

available_seasons
}
