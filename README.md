---
title: kickR 1.0.0
---
## Docmentation for functions will be updated by 16th July

![](https://img.icons8.com/?size=128&id=wQQxHKGXFPhn&format=png)

## Overview

**kickR** is a comprehensive R package designed for web scraping of football metrics from [FBRef](fbref.com). Whether you're an analyst, data scientist, or a football enthusiast, kickR provides you with the tools to access player and team statistics from various football leagues around the world. This package makes it easy to gather football metrics for your analysis and/or data vizzes.

kickR is written in the R programming language and to get started, if you have never used R before, you will have to download and install R and RStudio here for your computer by selecting the OS you use:
- [R](https://cran.r-project.org/bin/)
- [RStudio](https://posit.co/download/rstudio-desktop/)

If you are more comfortable in other programming languages like Python, you can scrape the data you need here in R and there are functions kickR provides that help you save the scraped data and export it to continue your analysis or use the data for the visualizations you want to work with.

For some examples as to what you can do with kickR data, kindly check this [repo](https://github.com/jeffreyohene/Football-Analytics) out.

## Features

- **Scraping Data**: Easily retrieve football statistics, player data, and team metrics from websites like FBref.
- **League Coverage**:
  - Premier League
  - Championship
  - Serie A
  - Ligue 1
  - La Liga
  - Segunda División
  - Serie B
  - Bundesliga
  - Eredivisie
  - Campeonato Brasileiro Série A
  - Liga MX
  - Major League Soccer
  - Primeira Liga
  - Bundesliga 2
  - Belgian Pro League
  - Ligue 2
- **Data Analysis**: 
  FBRef has metrics grouped under 9 categories which are listed with the top metrics for each category below:
  - Standard: General team metrics, xG, npxG, xG performance
  - Goalkeeping: Clean sheets, save percentage, goals conceded
  - Advanced Goalkeeping: Free kick and corner kick goals conceded, post shot expected goals(PSxG), PSxG performance, average passing length, goal kicks breakdown, crosses faced and crosses stopped an sweeping metrics.
  - Shooting: Goals, shots and shots on target, average shot distance, xG and npxG performance.
  - Passing: Total passes, pass blength breakdown, total passing distance, total progressive passing distance, pass length breakdown(attempted, completed and completion rates of shor, medium and long passes), final third passes, expected assisted goals, expected assists, key passes, final third passes and crosses and passes into the penalty area.
  - Pass Types: Switches, throw ins, through balls, crosses, live in-play and dead passes, in and out-swinging corner kicks and passes offside.
  - Goal & Shot Creation: Goal & Shot creating actions from live and dead passes, take-ons, shots, fouls drawn and defensive actions.
  - Defensive Actions: tackles, challenges, blocks, interceptions, clearances and errors leading to an opponent shot.
  - Possession: Touches, take-ons, carries and passes received.
  - Playing Time: Matches played, minutes played, minutes per matches played, starts, points per match, goals scored and goals conceded when playing, xg performance when playing
  - Miscellaneous: disciplinary record, fouls made and drawn, ball recoveries and offsides
  
  
- **Data Export**: After scraping data, you can export it as a .rds file if you use R or as a .csv, .xlsx or .json file.

- **Additional Feature**: kickR also has a function for calculating player/team similarity using the find_similar_players and find_similar_teams functions. This can help you scout players and teams who play in a certain way. Note that, similarity does not directly equate to style. Two players when compared for their touches in possession, touches in the middle third and carries made can be considered similar but their playing style may differ.

- **Open Source**: kickR is open-source software distributed under the MIT License.

## Installation
To install, run the code below:

```R
# Install latest development version of kickR.
if (!requireNamespace('devtools', quietly = T)) {
  install.packages('devtools')
}

devtools::install_github('jeffreyohene/kickR')

```

## How to Scrape League Stats

Here is the function syntax for scraping team data from a league:

```R
fbref_team_stats <- function(league = NULL, season = NULL, type = NULL)
```

### Function parameters

#### Leagues
Below are the leagues that kickR support and these values are to be passed to the leaue argument in the function. Do note that when a league os not supplied, the English Premier League will be automatically selected.

- premier_league
- championship
- serie_a
- la_liga
- ligue_1
- segunda_division
- serie_b
- bundesliga
- mls
- eredivisie
- br_serie_a
- liga_mx
- primera_liga
- bundesliga_2
- belgian_pro_league
- ligue_2


#### Metrics
Below are the metrics available to be scraped and are to be passed to the type parameter. When the type argument is null, it will be defaulted to the standard metric.

- standard
- goalkeeping
- advanced_goalkeeping
- shooting
- passing
- pass_types
- goal_creation
- defensive_actions
- possession
- playing_time
- miscellaneous

#### Season
The season parameter is the last argument to pass to the function. When left blank, it defaults to the current season. It should be supplied in the format `YYYY/YYYY` so if you want data for the 2022 to 2023 season, you can supply `2022/2023` to the year argument. FBREF started collecting metrics for most leagues in 2017, 2018 so should your function return nothing for the league you selected, visit the website to check if data is actually available for that season.

To scrape team statistics from the available football leagues using `kickR`, follow these steps:

1. Load the `kickR` package in your R environment.
```R
library(kickR)
```

```R
# To scrape bundesliga league goalkeeping data for 2020/2021
bundesliga_goalkeeping <- fbref_team_stats(league = "bundesliga",
                                           season = "2023/2024",
                                           type = "goalkeeping")

# Expected output as at 12/10/2023
# A tibble: 18 × 21
   club           league matches_played squad total_minutes_played mins_per_90 goals_against goals_against_per90
   <chr>          <chr>  <chr>          <chr> <chr>                <chr>       <chr>         <chr>              
 1 Augsburg       2      34             34    3,060                34.0        60            1.76               
 2 Bayern Munich  3      34             34    3,060                34.0        45            1.32               
 3 Bochum         2      34             34    3,060                34.0        74            2.18               
 4 Darmstadt 98   2      34             34    3,060                34.0        86            2.53               
 5 Dortmund       2      34             34    3,060                34.0        43            1.26               
 6 Eint Frankfurt 2      34             34    3,060                34.0        50            1.47               
 7 Freiburg       1      34             34    3,060                34.0        58            1.71               
 8 Gladbach       2      34             34    3,060                34.0        67            1.97               
 9 Heidenheim     1      34             34    3,060                34.0        55            1.62               
10 Hoffenheim     1      34             34    3,060                34.0        66            1.94               
11 Köln           1      34             34    3,060                34.0        60            1.76               
12 Leverkusen     2      34             34    3,060                34.0        24            0.71               
13 Mainz 05       2      34             34    3,060                34.0        51            1.50               
14 RB Leipzig     2      34             34    3,060                34.0        39            1.15               
15 Stuttgart      2      34             34    3,060                34.0        39            1.15               
16 Union Berlin   2      34             34    3,060                34.0        58            1.71               
17 Werder Bremen  2      34             34    3,060                34.0        54            1.59               
18 Wolfsburg      2      34             34    3,060                34.0        56            1.65               
# ℹ 13 more variables: shots_on_target_against <chr>, saves <chr>, save_percentage <chr>, wins <chr>, draws <chr>,
#   losses <chr>, clean_sheets <chr>, clean_sheet_percentage <chr>, penalties_attempted <chr>,
#   penalty_kicks_allowed <chr>, penalty_kicks_saved <chr>, penalty_kicks_missed <chr>,
#   penalty_kicks_save_percentage <chr>
```

```R
# Passing data for La Liga
# If you want latest statistics for a league you can always leave the season parameter out like this
la_liga_passing <- fbref_team_stats(league = "la_liga",
                                    season = "2023/2024",
                                    type = "goalkeeping")

la_liga_passing
# A tibble: 20 × 26
   club            number_of_players_used mins_per_90 total_passes_completed total_passes_attempted pass_completion_perc…¹
   <chr>           <chr>                  <chr>       <chr>                  <chr>                  <chr>                 
 1 Alavés          30                     38.0        10091                  14116                  71.5                  
 2 Almería         35                     38.0        12774                  16540                  77.2                  
 3 Athletic Club   27                     38.0        14509                  18724                  77.5                  
 4 Atlético Madrid 27                     38.0        17064                  20709                  82.4                  
 5 Barcelona       29                     38.0        21506                  24761                  86.9                  
 6 Betis           35                     38.0        15310                  18979                  80.7                  
 7 Cádiz           34                     38.0        10763                  14990                  71.8                  
 8 Celta Vigo      31                     38.0        13890                  17776                  78.1                  
 9 Getafe          33                     38.0        10713                  15193                  70.5                  
10 Girona          25                     38.0        18793                  21914                  85.8                  
11 Granada         40                     38.0        12127                  15976                  75.9                  
12 Las Palmas      29                     38.0        19105                  22882                  83.5                  
13 Mallorca        25                     38.0        11476                  15645                  73.4                  
14 Osasuna         29                     38.0        12874                  17335                  74.3                  
15 Rayo Vallecano  26                     38.0        13282                  17459                  76.1                  
16 Real Madrid     27                     38.0        21794                  24691                  88.3                  
17 Real Sociedad   31                     38.0        15263                  19249                  79.3                  
18 Sevilla         35                     38.0        14628                  18599                  78.6                  
19 Valencia        29                     38.0        12233                  16255                  75.3                  
20 Villarreal      32                     38.0        15349                  18637                  82.4                  
# ℹ abbreviated name: ¹​pass_completion_percentage
# ℹ 20 more variables: total_passing_distance <chr>, total_progressive_distance <chr>, short_passes_completed <chr>,
#   short_passes_attempted <chr>, short_pass_completion_percentage <chr>, medium_passes_completed <chr>,
#   medium_passes_attempted <chr>, medium_pass_completion_percentage <chr>, long_passes_completed <chr>,
#   long_passes_attempted <chr>, long_pass_completion_percentage <chr>, assists <chr>, xAG <chr>, xA <chr>,
#   xag_performance <chr>, key_passes <chr>, passes_into_final_third <chr>, passes_into_penalty_box <chr>,
#   crosses_into_penalty_box <chr>, progressive_passes <chr>

kickR also supports league outside of Europe like the Mexican Liga Mx. It follows the same pattern like scraping for other leagues. If you leave the season argument blank, kickR scrapes data for the current season, so if we wanted to see the latest shot and goal creation stats across clubs in the Mexican leagues, we can do it like this

```R
# Scrape latest liga mx shot and goal creation stats
liga_mx_sca_gca <- fbref_team_stats(league = "liga_mx",
                                    type = "goal_creation")

liga_mx_sca_gca
# A tibble: 18 × 19
   club    number_of_players_used mins_per_90 shot_creating_actions shot_creating_action…¹ sca_live_passes sca_dead_passes
   <chr>   <chr>                  <chr>       <chr>                 <chr>                  <chr>           <chr>          
 1 América 24                     4.0         93                    23.25                  68              8              
 2 Atlas   21                     4.0         79                    19.75                  50              13             
 3 Atléti… 20                     4.0         80                    20.00                  58              6              
 4 Cruz A… 20                     4.0         120                   30.00                  89              16             
 5 FC Juá… 20                     4.0         68                    17.00                  51              4              
 6 Guadal… 19                     4.0         95                    23.75                  73              5              
 7 León    20                     4.0         87                    21.75                  60              8              
 8 Mazatl… 20                     4.0         73                    18.25                  53              9              
 9 Monter… 20                     4.0         84                    21.00                  74              2              
10 Necaxa  21                     4.0         85                    21.25                  64              10             
11 Pachuca 21                     4.0         85                    21.25                  54              12             
12 Puebla  19                     4.0         114                   28.50                  81              14             
13 Querét… 22                     4.0         61                    15.25                  43              8              
14 Santos  22                     4.0         46                    11.50                  26              7              
15 Tijuana 21                     4.0         87                    21.75                  68              6              
16 Toluca  19                     4.0         77                    19.25                  63              7              
17 UANL    18                     4.0         109                   27.25                  80              10             
18 UNAM    22                     4.0         112                   28.00                  71              16             
# ℹ abbreviated name: ¹​shot_creating_actions_per90
# ℹ 12 more variables: sca_take_ons <chr>, sca_shots <chr>, sca_fouls <chr>, sca_defensive_actions <chr>,
#   goal_creating_actions <chr>, goal_creating_actions_per90 <chr>, gca_live_passes <chr>, gca_dead_passes <chr>,
#   gca_take_ons <chr>, gca_shots <chr>, gca_fouls <chr>, gca_defensive_actions <chr>

```
## How to Scrape Player Data

With this version you can access player data of every available league on FBREF. Do note that the player data scraping is a little different from the team data scraping and since the player data tables on the site are dynamically rendered, we will use Javascript to scrape the data. To use this function, you will need to have [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) installed on your computer. Note that if you encounter any problems during scraping, use Ctrl + Shift + F10 to restart your R session then use the function again

To scrape the EFL championship passing data for players for the 2022/2023 season for example, you can use this


```R
> # Scrape passing stats for all EFL players in the 2022/2023 season
> efl_passing_players <- fbref_player_stats(season = "2022/2023",
+                                           league = "championship",
+                                           type = "passing")
> 
> # Expected output
> efl_passing_players
# A tibble: 750 × 30
   player           nation  position club       age   birth_year mins_per_90 total_passes_completed total_passes_attempted
   <chr>            <chr>   <chr>    <chr>      <chr> <chr>      <chr>       <chr>                  <chr>                 
 1 Max Aarons       eng ENG DF       Norwich C… 22    2000       42.8        2008                   2536                  
 2 Thelo Aasgaard   no NOR  FW,MF    Wigan Ath… 20    2002       17.6        399                    507                   
 3 Nelson Abbey     eng ENG DF       Reading    18    2003       0.2         6                      9                     
 4 Kelvin Abrefa    eng ENG MF,DF    Reading    18    2003       1.4         20                     36                    
 5 Finlay Adair     eng ENG FW,MF    Preston    17    2005       0.7         3                      8                     
 6 Elijah Adebayo   eng ENG FW       Luton Town 24    1998       35.7        388                    625                   
 7 Toby Adeyemo     eng ENG MF,FW    Watford    17    2005       1.1         9                      15                    
 8 Albert Adomah    gh GHA  FW,MF    QPR        34    1987       14.1        250                    423                   
 9 Michael Adu-Poku eng ENG FW       Watford    16    2005       0.1         0                      1                     
10 Benik Afobe      cd COD  FW       Millwall   29    1993       10.3        127                    192                   
# ℹ 740 more rows
# ℹ 21 more variables: pass_completion_percentage <chr>, total_passing_distance <chr>, total_progressive_distance <chr>,
#   short_passes_completed <chr>, short_passes_attempted <chr>, short_pass_completion_percentage <chr>,
#   medium_passes_completed <chr>, medium_passes_attempted <chr>, medium_pass_completion_percentage <chr>,
#   long_passes_completed <chr>, long_passes_attempted <chr>, long_pass_completion_percentage <chr>, assists <chr>,
#   xAG <chr>, xA <chr>, xag_performance <chr>, key_passes <chr>, passes_into_final_third <chr>,
#   passes_into_penalty_box <chr>, crosses_into_penalty_box <chr>, progressive_passes <chr>
# ℹ Use `print(n = ...)` to see more rows
```

## How to Find Similar Players

To use this function, you will need to have Firefox installed on your computer.

```R
# extract player passing data 
df <- fbref_player_stats(season = "2023/2024",
                         league = "premier_league",
                         type = "passing")

# find players similar to Martin Ødegaard in tge English Premier League
m_odegaard_sim_pl <- find_similar_players(df = df,
                                       player ="Martin Ødegaard",
                                       metrics = c("key_passes",
                                                   "passes_into_final_third"),
                                       formula = "euclidean",
                                       top_n = 15)

m_odegaard_sim_pl
                    player distance
580        Martin Ødegaard  0.00000
184        Bruno Fernandes 29.54657
415            Cole Palmer 38.41875
552      James Ward-Prowse 44.41846
317         James Maddison 46.09772
220        Bruno Guimarães 46.64762
201     Morgan Gibbs-White 53.85165
313           Douglas Luiz 54.12947
316    Alexis Mac Allister 55.03635
196        Conor Gallagher 55.90170
18  Trent Alexander-Arnold 56.63921
434            Pedro Porro 56.79789
457       Andrew Robertson 58.00000
114             Lewis Cook 60.16644
418          Lucas Paquetá 61.40033                                       
```

It is usually better to have a larger dataframe. You can use the fbref_player_stats() function to scrape player stats from as many leagues as you can and use the `rbind()` function to combine them into a larger dataframe to have a very deep pool of players so you can really unearth hidden players who are really good but play in a less known league. For an example, we luckily have FBREF having all players in the top 5 league in a single table which you can scrape with kickR using the fbref_big5_player_stats() function. If we wanted to really see which players perform similarly to Martin Ødegaard in terms of key passes and passes  into the final third, we can go about it like this:

```R
# Scrape passing data for all players in top 5 leagues: Premier League, La Liga, Serie A, Bundesliga, Ligue 1
df <- fbref_big5_player_stats(season = "2023/2024", type = "passing")

# find players similar to Martin Ødegaard in Europe's Top 5 Leagues using cosine similarity
m_odegaard_sim_big5_cos <- find_similar_players(df = df,
                                            player ="Martin Ødegaard",
                                            metrics = c("key_passes",
                                                        "passes_into_final_third"),
                                            formula = "cosine",
                                            top_n = 15)

m_odegaard_sim_big5_cos
              player similarity
2849 Martin Ødegaard  1.0000000
108  Felipe Anderson  0.9999997
2429  Bernardo Silva  0.9999984
2583   Jan Thielmann  0.9999984
2660 Kacper Urbanski  0.9999984
1762 Takumi Minamino  0.9999960
735       Ritsu Doan  0.9999940
2068   Adrià Pedrosa  0.9999928
2336  Alexis Sánchez  0.9999928
81    Miguel Almirón  0.9999911
547     Jordan Clark  0.9999911
1409    Grejohn Kyei  0.9999911
1036  Vincenzo Grifo  0.9999904
191       Ridle Baku  0.9999873
2093     Ayoze Pérez  0.9999873                                          

# find players similar to Martin Ødegaard in Europe's Top 5 Leagues uing euclidean distance
m_odegaard_sim_big5_eucl <- find_similar_players(df = df,
                                            player ="Martin Ødegaard",
                                            metrics = c("key_passes",
                                                        "passes_into_final_third"),
                                            formula = "euclidean",
                                            top_n = 15)

m_odegaard_sim_big5_eucl
                  player distance
2849     Martin Ødegaard  0.00000
2366       Téji Savanier 28.23119
1071      İlkay Gündoğan 28.44293
862      Bruno Fernandes 29.54657
1195                Isco 36.61967
2027         Cole Palmer 38.41875
63          Luis Alberto 39.84972
361  Benjamin Bourigeaud 40.80441
1339      Joshua Kimmich 41.03657
2512        Kevin Stöger 43.01163
2743   James Ward-Prowse 44.41846
1553      James Maddison 46.09772
1063     Bruno Guimarães 46.64762
1784         Luka Modrić 47.04253
2211   Tijjani Reijnders 52.61179
```


As you can see, cosine and euclidean distance measure similarity in two different approaches. An article will be added to this repo's description to talk more about it and if you have any suggestions on how to adjust it, do reach out to me. 

A tip I would like to include is this. In our example, Martin Ødegaard is a midfielder. It would make sense to filter the scraped data to include only midfielders or defenders/midfielders or forwards/midfielders. This will improve the formula's ability to find similar players as the context is clearer. If you wanted to filter your dataframe for only midfielders before calling the find_similar_players() function, you could use this in base R:

```R
# filter dataframe for only midfielders
df <- df[df$position == "MF", ]

# call similarity function again
m_odegaard_sim_big5_eucl <- find_similar_players(df = df,
                                            player ="Martin Ødegaard",
                                            metrics = c("key_passes",
                                                        "passes_into_final_third"),
                                            formula = "euclidean",
                                            top_n = 15)

m_odegaard_sim_big5_eucl
               player distance
568   Martin Ødegaard  0.00000
480     Téji Savanier 28.23119
207    İlkay Gündoğan 28.44293
231              Isco 36.61967
13       Luis Alberto 39.84972
515      Kevin Stöger 43.01163
553 James Ward-Prowse 44.41846
311    James Maddison 46.09772
205   Bruno Guimarães 46.64762
362       Luka Modrić 47.04253
437 Tijjani Reijnders 52.61179
265  Teun Koopmeiners 54.03702
304      Douglas Luiz 54.12947
184       Angel Gomes 54.14795
32  Maximilian Arnold 54.74486                                            
```

These are the available positions for players on FBREF:

```R
unique(df$position)
 [1] "DF"    "MF,FW" "MF"    "FW"    "FW,MF" "DF,FW" "GK"    "DF,MF" "MF,DF" "FW,DF"
```
So if you want to extend your midfielder search, you would have to filter for players who are primarily registered as midfielders so MF, MF/FW, MF/DF. To filter for multiple values in base R, you can use this snippet:

```R 
df <- df[df$position %in% c("MF", "MF,FW", "MF,DF"), ]
```
### Data Cleaning
This package was built on `rvest`, `jsonlite` and `openxlsx`. Since the first release is a purely scraping package release, you would have to load dplyr into your R environment for helpful data manipulation functions like renaming columns and also changing column data types from character to numeric for example. 

It is also worth noting that the scraping package cleans the column names into more descriptive names for easier analysis. You can always rename the columns in your analysis workflow to what suits you best.


# How to Use the `save_table` Function

The `save_table` function is designed to save a given data frame in various formats such as JSON, CSV, XLSX, or RDS. It offers flexibility for choosing the desired format.

## Prerequisites
The `save_table` function saves a specified dataframe to your working directory provided you want to store it locally or work with it later. If we want to save our La Liga passing table from early on to make a viz that proves why Real Madrid is the most potent passing team in La Liga for example we can do that below with the following code.

```R
# Initialize variables

df <- la_liga_passing_latest
filename <- 'la_liga_passing_latest'
format <- 'csv'

save_table(df, filename, format)

# Expected output:
Table saved as ' la_liga_passing_latest.csv '

```

## Dependencies

kickR relies on the following R packages:

- **jsonlite**
- **rvest**
- **RSelenium**
- **openxlsx**


## Author and Maintainer

- **Author**: Jeffrey Ohene
- **Maintainer**: [jeffreyohene](https://github.com/jeffreyohene))

## License

This package is released under the MIT License. See the LICENSE file for 
details.


### Contributing
If you would like to contribute to this project, please check the contributions file for this package.

### Reporting Issues
I regularly monitor the packages' functions' performance and functionality and 
release updates as needed to ensure its reliability and from time to time, small updates will be released to fix bugs or comply with FBREF's scraping policy. If you encounter any 
issues or have suggestions for improvements, please don't hesitate to open an 
issue on the [repo](https://github.com/jeffreyohene/wikiscrapeR/issues) and provide as much detail as possible to help me understand and address the issue.

Project icon from icon8.com
