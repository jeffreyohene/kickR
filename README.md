---
title: kickR 1.0.0
---
## Docmentation for functions will be updated by 16th July

![](https://img.icons8.com/?size=128&id=wQQxHKGXFPhn&format=png)

## Overview

**kickR** is a comprehensive R package designed for football analytics and web scraping of football metrics from FBRef. Whether you're an analyst, data scientist, or a football enthusiast, kickR provides you with the tools to access player and team statistics from various football leagues. This package includes features to scrape data from websites like FBRef and other sources, making it easy to gather football metrics for your analysis and/or data vizzes.

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
  - Advanced Goalkeeping: Free kick and corner kick goals conceded, post shot expected goals(PSxG), PSxG         performance, average passing length, goal kicks breakdown, crosses faced and crosses stopped an sweeping metrics.
  - Shooting: Goals, shots and shots on target, average shot distance, xG and npxG performance.
  - Passing: Total passes, pass blength breakdown, total passing distance, total progressive passing distance, pass length breakdown(attempted, completed and completion rates of shor, medium and long passes), final third passes, expected assisted goals, expected assists, key passes, final third passes and crosses and passes into the penalty area.
  - Pass Types: Switches, throw ins, through balls, crosses, live in-play and dead passes, in and out-swinging corner kicks and passes offside.
  - Goal & Shot Creation: Goal & Shot creating actions from live and dead passes, take-ons, shots, fouls drawn and defensive actions.
  - Defensive Actions: tackles, challenges, blocks, interceptions, clearances and errors leading to an opponent shot.
  - Possession: Touches, take-ons, carries and passes received.
  - Playing Time: Matches played, minutes played, minutes per matches played, starts, points per match, goals scored and goals conceded when playing, xg performance when playing
  - Miscellaneous: disciplinary record, fouls made and drawn, ball recoveries and offsides
  
  
- **Data Export**: Export your data to common formats for further analysis or sharing.

- **Upcoming Features**: With our next version we will introduce features such as modelling metrics for enhanced scouting and performance analysis and player similarity identification using performance metrics.

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
## How to Scrape Top 5 League Stats

To scrape statistics for the top 5 football leagues (English Premier League, La Liga, Bundesliga, Serie A, and Ligue 1) using `kickR`, follow these steps:

1. Load the `kickR` package in your R environment.
```R
library(kickR)

# The fbref_team_stats() function supports all leagues except the MLS

# To scrape premier league goalkeeping data for 2020/2021
epl_2020_2021 <- fbref_team_stats(league = 'Premier League', season = '2020/2021', type = 'goalkeeping')

# Expected output as at 12/10/2023
# A tibble: 20 × 21
   club  league matches_played squad total_minutes_played mins_per_90 goals_against goals_against_per90
   <chr> <chr>  <chr>          <chr> <chr>                <chr>       <chr>         <chr>              
 1 Arse… 3      38             38    3,417                38.0        39            1.03               
 2 Asto… 1      38             38    3,420                38.0        46            1.21               
 3 Brig… 2      38             38    3,420                38.0        46            1.21               
 4 Burn… 3      38             38    3,420                38.0        55            1.45               
 5 Chel… 3      38             38    3,420                38.0        36            0.95               
 6 Crys… 2      38             38    3,420                38.0        66            1.74               
 7 Ever… 3      38             38    3,420                38.0        48            1.26               
 8 Fulh… 2      38             38    3,420                38.0        53            1.39               
 9 Leed… 2      38             38    3,420                38.0        54            1.42               
10 Leic… 1      38             38    3,420                38.0        50            1.32               
11 Live… 3      38             38    3,420                38.0        42            1.11               
12 Manc… 3      38             38    3,420                38.0        32            0.84               
13 Manc… 2      38             38    3,420                38.0        44            1.16               
14 Newc… 2      38             38    3,420                38.0        62            1.63               
15 Shef… 1      38             38    3,420                38.0        63            1.66               
16 Sout… 2      38             38    3,420                38.0        68            1.79               
17 Tott… 1      38             38    3,420                38.0        45            1.18               
18 West… 2      38             38    3,420                38.0        76            2.00               
19 West… 2      38             38    3,420                38.0        47            1.24               
20 Wolv… 2      38             38    3,420                38.0        52            1.37               
# ℹ 13 more variables: shots_on_target_against <chr>, saves <chr>, save_percentage <chr>, wins <chr>,
#   draws <chr>, losses <chr>, clean_sheets <chr>, clean_sheet_percentage <chr>,
#   penalties_attempted <chr>, penalty_kicks_allowed <chr>, penalty_kicks_saved <chr>,
#   penalty_kicks_missed <chr>, penalty_kicks_save_percentage <chr>

# Passing data for La Liga
# If you want latest statistics for a league you can always leave the season parameter out like this
la_liga_passing_latest <- fbref_team_stats(league = 'La Liga', type = 'passing')
# Expected Output as at 12/10/2023

la_liga_passing_latest
# A tibble: 20 × 26
   club            number_of_players_used mins_per_90 total_passes_completed total_passes_attempted
   <chr>           <chr>                  <chr>       <chr>                  <chr>                 
 1 Alavés          22                     9.0         2578                   3617                  
 2 Almería         26                     9.0         3405                   4238                  
 3 Athletic Club   22                     9.0         3416                   4434                  
 4 Atlético Madrid 22                     8.0         3231                   4016                  
 5 Barcelona       23                     9.0         5506                   6261                  
 6 Betis           27                     9.0         3786                   4586                  
 7 Cádiz           25                     9.0         2034                   2971                  
 8 Celta Vigo      22                     9.0         3064                   3996                  
 9 Getafe          23                     9.0         2146                   3152                  
10 Girona          22                     9.0         3945                   4680                  
11 Granada         26                     9.0         2588                   3477                  
12 Las Palmas      23                     9.0         4424                   5245                  
13 Mallorca        21                     9.0         2354                   3252                  
14 Osasuna         22                     9.0         2942                   4005                  
15 Rayo Vallecano  22                     9.0         2835                   3818                  
16 Real Madrid     21                     9.0         5118                   5836                  
17 Real Sociedad   24                     9.0         3748                   4673                  
18 Sevilla         27                     8.0         2783                   3743                  
19 Valencia        24                     9.0         3060                   3987                  
20 Villarreal      23                     9.0         3618                   4361                  
# ℹ 21 more variables: pass_completion_percentage <chr>, total_passing_distance <chr>,
#   total_progressive_distance <chr>, short_passes_completed <chr>, short_passes_attempted <chr>,
#   short_pass_completion_percentage <chr>, medium_passes_completed <chr>,
#   medium_passes_attempted <chr>, medium_pass_completion_percentage <chr>,
#   long_passes_completed <chr>, long_passes_attempted <chr>, long_pass_completion_percentage <chr>,
#   assists <chr>, xAG <chr>, xA <chr>, xag_performance <chr>, key_passes <chr>,
#   passes_into_final_third <chr>, passes_into_penalty_box <chr>, crosses_into_penalty_box <chr>, …

# kickR also supports these non european leagues: Liga MX and Campeonato Brasileiro Série A

# To get possession stats of the Campeonato Brasileiro Série A

br_serie_a_possession <- fbref_team_stats(league = 'Campeonato Brasileiro Serie A', season = '2022/2023', type = 'possession')

# Expected output
# A tibble: 20 × 26
   club             number_of_players_used possession mins_per_90 total_touches touches_defensive_pen…¹
   <chr>            <chr>                  <chr>      <chr>       <chr>         <chr>                  
 1 América (MG)     41                     41.5       26.0        13067         1475                   
 2 Ath Paranaense   36                     47.4       26.0        14197         1488                   
 3 Atlético Mineiro 31                     53.8       26.0        16389         1575                   
 4 Bahia            34                     50.7       26.0        15195         1547                   
 5 Botafogo (RJ)    34                     45.7       26.0        14527         1492                   
 6 Bragantino       34                     56.2       26.0        16180         1308                   
 7 Corinthians      35                     49.0       26.0        16003         1797                   
 8 Coritiba         42                     43.5       26.0        13593         1612                   
 9 Cruzeiro         35                     52.5       25.0        15199         1477                   
10 Cuiabá           29                     44.5       25.0        13314         1320                   
11 Flamengo         32                     58.5       26.0        17899         1507                   
12 Fluminense       34                     61.1       26.0        18010         1870                   
13 Fortaleza        31                     47.0       26.0        14391         1248                   
14 Goiás            37                     44.4       26.0        13865         1776                   
15 Grêmio           41                     45.8       26.0        14651         1514                   
16 Internacional    34                     52.4       26.0        16120         1469                   
17 Palmeiras        31                     53.8       26.0        15495         1415                   
18 Santos           45                     44.1       26.0        13489         1515                   
19 São Paulo        35                     60.5       26.0        17832         1626                   
20 Vasco da Gama    39                     47.5       26.0        14282         1550                   
# ℹ abbreviated name: ¹​touches_defensive_penalty_box
# ℹ 20 more variables: touches_defensive_third <chr>, touches_middle_third <chr>,
#   touches_final_third <chr>, touches_attacking_penalty_box <chr>, inplay_touches <chr>,
#   take_ons_attempted <chr>, successful_take_ons <chr>, successful_take_on_percentage <chr>,
#   tackles_during_take_on <chr>, tackles_during_take_on_percentage <chr>, carries <chr>,
#   total_carrying_distance <chr>, progressive_carrying_distance <chr>, progressive_carries <chr>,
#   carries_into_final_third <chr>, carries_into_penalty_box <chr>, miscontrols <chr>, …




# MLS is a year long league not split over seasons. We can get standardMLS team data by running this line of code

mls_2020 <- fbref_mls_team_stats(season = '2020', type = 'standard')

# Expected output
# A tibble: 26 × 32
   club   number_of_players_used average_age possession matches_played starts minutes mins_per_90 goals
   <chr>  <chr>                  <chr>       <chr>      <chr>          <chr>  <chr>   <chr>       <chr>
 1 Atlan… 27                     25.6        54.7       23             253    2,070   23.0        23   
 2 Chica… 25                     26.7        51.2       23             253    2,070   23.0        33   
 3 Color… 22                     25.8        52.0       18             198    1,620   18.0        30   
 4 Colum… 26                     27.4        52.0       23             253    2,070   23.0        34   
 5 D.C. … 26                     26.6        46.0       23             253    2,070   23.0        24   
 6 Dynamo 26                     27.7        48.7       23             253    2,070   23.0        30   
 7 FC Ci… 30                     27.5        49.3       23             253    2,070   23.0        11   
 8 FC Da… 27                     27.0        51.2       22             242    1,980   22.0        28   
 9 Inter… 28                     26.8        47.3       23             253    2,070   23.0        24   
10 LA Ga… 25                     27.2        45.3       22             242    1,980   22.0        26   
# ℹ 16 more rows
# ℹ 23 more variables: assists <chr>, goals_and_assists <chr>, non_penalty_goals <chr>,
#   penalties <chr>, penalty_kick_attempts <chr>, yellow_cards <chr>, red_cards <chr>, xG <chr>,
#   npxG <chr>, xAG <chr>, `npxG+xAG` <chr>, progressive_carries <chr>, progressive_passes <chr>,
#   goals_per90 <chr>, assists_per90 <chr>, goals_and_assists_per90 <chr>,
#   non_penalty_goals_per90 <chr>, non_penalty_goals_and_assists_per90 <chr>, xg_per90 <chr>,
#   xag_per90 <chr>, xg_and_xag_per90 <chr>, npxg_per90 <chr>, npxg_and_xag_per90 <chr>
# ℹ Use `print(n = ...)` to see more rows


# Also every league has a separate function for scraping team statistics but slightly differs from the MLS code

# To scrape advanced goalkeeping statistics for Belgium Pro League for example, this code should do the trick
belge_adv_goalkeeping <- fbref_belgian_pro_league_team_stats(type = 'advanced_goalkeeping')

# Expected output
# A tibble: 16 × 28
   club   number_of_players_used mins_per_90 goals_against penalty_kicks_allowed free_kick_goals_agai…¹
   <chr>  <chr>                  <chr>       <chr>         <chr>                 <chr>                 
 1 Ander… 2                      10.0        10            2                     0                     
 2 Antwe… 1                      10.0        5             3                     0                     
 3 Cercl… 1                      10.0        11            0                     0                     
 4 Charl… 1                      10.0        15            3                     0                     
 5 Club … 1                      10.0        11            0                     1                     
 6 Eupen  2                      10.0        22            3                     0                     
 7 Genk   1                      10.0        10            0                     0                     
 8 Gent   2                      10.0        10            1                     0                     
 9 Kortr… 1                      10.0        22            0                     0                     
10 Meche… 1                      10.0        12            1                     0                     
11 OH Le… 2                      10.0        19            5                     0                     
12 RWD M… 1                      10.0        20            1                     0                     
13 Sint-… 2                      10.0        14            1                     0                     
14 Stand… 1                      10.0        9             1                     0                     
15 Union… 2                      10.0        12            0                     0                     
16 Weste… 2                      10.0        19            1                     0                     
# ℹ abbreviated name: ¹​free_kick_goals_against
# ℹ 22 more variables: corner_kick_goals_against <chr>, own_goals_against <chr>, PSxG <chr>,
#   PSxG_per_shot_on_target <chr>, PSxG_minus_goals_allowed <chr>,
#   PSxG_minus_goals_allowed_per90 <chr>, launched_passes_completed <chr>,
#   launched_passes_attempted <chr>, launched_passes_completion_pct <chr>, passes_attempted <chr>,
#   throws_attempted <chr>, percentage_passes_launched <chr>, avg_pass_length <chr>, goal_kicks <chr>,
#   percentage_goal_kicks_launched <chr>, avg_goal_kick_length <chr>, crosses_faced <chr>, …


```
## Player Data

With this version you can access player data of every single player playing in Europe's top 5 leagues.

Due to standardization, this version gives you access to get player statistics data for only these 5 leagues for now. In the next release which will feature enhanced scouting programme and a player similarity model, we will extend the access to more players in other leagues


```R
# If you want to run an analysis on some of the most influential players/metronomes 
# in possession in Europe's top 5 leagues, you could scrape the data first with this
possession <- fbref_big5_player_stats(season = '2022/2023', type = 'possession')

# Expected output
# A tibble: 2,889 × 30
   player            nation  position club           league  age   birth_year mins_per_90 total_touches
   <chr>             <chr>   <chr>    <chr>          <chr>   <chr> <chr>      <chr>       <chr>        
 1 Brenden Aaronson  us USA  MF,FW    Leeds United   eng Pr… 21    2000       26.4        1143         
 2 Paxten Aaronson   us USA  MF,DF    Eint Frankfurt de Bun… 18    2003       1.9         99           
 3 James Abankwah    ie IRL  DF       Udinese        it Ser… 18    2004       0.7         39           
 4 George Abbott     eng ENG MF       Tottenham      eng Pr… 16    2005       0.0         2            
 5 Yunis Abdelhamid  ma MAR  DF       Reims          fr Lig… 34    1987       37.0        2459         
 6 Himad Abdelli     dz ALG  MF,FW    Angers         fr Lig… 22    1999       23.7        1516         
 7 Salis Abdul Samed gh GHA  MF       Lens           fr Lig… 22    2000       32.2        2224         
 8 Laurent Abergel   fr FRA  MF       Lorient        fr Lig… 29    1993       26.0        1779         
 9 Oliver Abildgaard dk DEN  MF       Hellas Verona  it Ser… 26    1996       6.6         257          
10 Matthis Abline    fr FRA  FW,MF    Auxerre        fr Lig… 19    2003       9.0         210          
# ℹ 2,879 more rows
# ℹ 21 more variables: touches_defensive_penalty_box <chr>, touches_defensive_third <chr>,
#   touches_middle_third <chr>, touches_final_third <chr>, touches_attacking_penalty_box <chr>,
#   inplay_touches <chr>, take_ons_attempted <chr>, successful_take_ons <chr>,
#   successful_take_on_percentage <chr>, tackles_during_take_on <chr>,
#   tackles_during_take_on_percentage <chr>, carries <chr>, total_carrying_distance <chr>,
#   progressive_carrying_distance <chr>, progressive_carries <chr>, carries_into_final_third <chr>, …
# ℹ Use `print(n = ...)` to see more rows

# Imagine you wanted to do the same analysis but only for Ligue 1 players
# You can run this
library(dplyr)

possession_fr <- possession |> filter(league == "fr Ligue 1")

# Expected Output
# A tibble: 606 × 30
   player            nation position club     league     age   birth_year mins_per_90 total_touches
   <chr>             <chr>  <chr>    <chr>    <chr>      <chr> <chr>      <chr>       <chr>        
 1 Yunis Abdelhamid  ma MAR DF       Reims    fr Ligue 1 34    1987       37.0        2459         
 2 Himad Abdelli     dz ALG MF,FW    Angers   fr Ligue 1 22    1999       23.7        1516         
 3 Salis Abdul Samed gh GHA MF       Lens     fr Ligue 1 22    2000       32.2        2224         
 4 Laurent Abergel   fr FRA MF       Lorient  fr Ligue 1 29    1993       26.0        1779         
 5 Matthis Abline    fr FRA FW,MF    Auxerre  fr Ligue 1 19    2003       9.0         210          
 6 Matthis Abline    fr FRA FW,MF    Rennes   fr Ligue 1 19    2003       1.2         37           
 7 Zakaria Aboukhlal ma MAR FW,MF    Toulouse fr Ligue 1 22    2000       27.5        1163         
 8 Mohamed Achi      fr FRA FW       Nantes   fr Ligue 1 20    2002       0.4         25           
 9 Martin Adeline    fr FRA MF,FW    Reims    fr Ligue 1 18    2003       1.2         59           
10 Emmanuel Agbadou  ci CIV DF       Reims    fr Ligue 1 25    1997       26.5        1798   

# If you work with a national team and want to see the performances of your country's players
# Provided they play in Europe's T5 leagues and they are for example Ghanaian, you can do this

gha_players_europe <- possession |> filter(nation == "gh GHA")

# Expected output
# A tibble: 26 × 30
   player                  nation position club       league age   birth_year mins_per_90 total_touches
   <chr>                   <chr>  <chr>    <chr>      <chr>  <chr> <chr>      <chr>       <chr>        
 1 Salis Abdul Samed       gh GHA MF       Lens       fr Li… 22    2000       32.2        2224         
 2 Felix Afena-Gyan        gh GHA FW,MF    Cremonese  it Se… 19    2003       9.1         318          
 3 Joseph Aidoo            gh GHA DF       Celta Vigo es La… 26    1995       34.7        2082         
 4 Daniel Amartey          gh GHA DF       Leicester… eng P… 27    1994       17.9        1279         
 5 Christopher Antwi-Adjei gh GHA FW,MF    Bochum     de Bu… 28    1994       22.0        996          
 6 André Ayew              gh GHA FW,MF    Nott'ham … eng P… 32    1989       3.5         106          
 7 Jordan Ayew             gh GHA FW,MF    Crystal P… eng P… 30    1991       30.2        1327         
 8 Iddrisu Baba            gh GHA MF,DF    Mallorca   es La… 26    1996       18.9        773          
 9 Kevin-Prince Boateng    gh GHA MF       Hertha BSC de Bu… 35    1987       5.2         320          
10 Alexander Djiku         gh GHA DF       Strasbourg fr Li… 27    1994       29.7        1873         
# ℹ 16 more rows
# ℹ 21 more variables: touches_defensive_penalty_box <chr>, touches_defensive_third <chr>,
#   touches_middle_third <chr>, touches_final_third <chr>, touches_attacking_penalty_box <chr>,
#   inplay_touches <chr>, take_ons_attempted <chr>, successful_take_ons <chr>,
#   successful_take_on_percentage <chr>, tackles_during_take_on <chr>,
#   tackles_during_take_on_percentage <chr>, carries <chr>, total_carrying_distance <chr>,
#   progressive_carrying_distance <chr>, progressive_carries <chr>, carries_into_final_third <chr>, …
# ℹ Use `print(n = ...)` to see more rows

```


### Data Cleaning
This package was built on `rvest`, `jsonlite` and `openxlsx`. Since the first release is a purely scraping package release, you would have to load dplyr into your R environment for helpful data manipulation functions like renaming columns and also changing column data types from character to numeric for example. 

It is also worth noting that the scraping package cleans the column names into more descriptive names for easier analysis.

```R
# We can change the column data type from character to double for example for a single column or multiple columns in our br_serie_a_possession dataframe.

# We want to convert every column apart from the only actual character column, club to do that we can run
br_serie_a_possession <- br_serie_a_possession |> mutate_at(-1, as.numeric)

# Expected output
# A tibble: 20 × 26
   club             number_of_players_used possession mins_per_90 total_touches touches_defensive_pen…¹
   <chr>                             <dbl>      <dbl>       <dbl>         <dbl>                   <dbl>
 1 América (MG)                         41       41.5          26         13067                    1475
 2 Ath Paranaense                       36       47.4          26         14197                    1488
 3 Atlético Mineiro                     31       53.8          26         16389                    1575
 4 Bahia                                34       50.7          26         15195                    1547
 5 Botafogo (RJ)                        34       45.7          26         14527                    1492
 6 Bragantino                           34       56.2          26         16180                    1308
 7 Corinthians                          35       49            26         16003                    1797
 8 Coritiba                             42       43.5          26         13593                    1612
 9 Cruzeiro                             35       52.5          25         15199                    1477
10 Cuiabá                               29       44.5          25         13314                    1320
11 Flamengo                             32       58.5          26         17899                    1507
12 Fluminense                           34       61.1          26         18010                    1870
13 Fortaleza                            31       47            26         14391                    1248
14 Goiás                                37       44.4          26         13865                    1776
15 Grêmio                               41       45.8          26         14651                    1514
16 Internacional                        34       52.4          26         16120                    1469
17 Palmeiras                            31       53.8          26         15495                    1415
18 Santos                               45       44.1          26         13489                    1515
19 São Paulo                            35       60.5          26         17832                    1626
20 Vasco da Gama                        39       47.5          26         14282                    1550
# ℹ abbreviated name: ¹​touches_defensive_penalty_box
# ℹ 20 more variables: touches_defensive_third <dbl>, touches_middle_third <dbl>,
#   touches_final_third <dbl>, touches_attacking_penalty_box <dbl>, inplay_touches <dbl>,
#   take_ons_attempted <dbl>, successful_take_ons <dbl>, successful_take_on_percentage <dbl>,
#   tackles_during_take_on <dbl>, tackles_during_take_on_percentage <dbl>, carries <dbl>,
#   total_carrying_distance <dbl>, progressive_carrying_distance <dbl>, progressive_carries <dbl>,
#   carries_into_final_third <dbl>, carries_into_penalty_box <dbl>, miscontrols <dbl>, …

# Renaming columns
# If we wanted to rename the possession column above, we could do this
br_serie_a_possession <- br_serie_a_possession |> rename(avg_possession = possession)

# Or if you want to use colnames() but you hate to manually find the index
# Find the index of the 'possession' column
possession_index <- which(colnames(df) == "possession")

# Rename the 'possession' column to 'avg_possession'
colnames(df)[possession_index] <- 'avg_possession'

# If you actually enjoy pain, you can do it manually like this
colnames(br_serie_a_possession)[3] <- 'avg_possession'

# Expected output of all the methods above
# A tibble: 20 × 26
   club          number_of_players_used avg_possession mins_per_90 total_touches touches_defensive_pe…¹
   <chr>                          <dbl>          <dbl>       <dbl>         <dbl>                  <dbl>
 1 América (MG)                      41           41.5          26         13067                   1475
 2 Ath Paranaen…                     36           47.4          26         14197                   1488
 3 Atlético Min…                     31           53.8          26         16389                   1575
 4 Bahia                             34           50.7          26         15195                   1547
 5 Botafogo (RJ)                     34           45.7          26         14527                   1492
 6 Bragantino                        34           56.2          26         16180                   1308
 7 Corinthians                       35           49            26         16003                   1797
 8 Coritiba                          42           43.5          26         13593                   1612
 9 Cruzeiro                          35           52.5          25         15199                   1477
10 Cuiabá                            29           44.5          25         13314                   1320
11 Flamengo                          32           58.5          26         17899                   1507
12 Fluminense                        34           61.1          26         18010                   1870
13 Fortaleza                         31           47            26         14391                   1248
14 Goiás                             37           44.4          26         13865                   1776
15 Grêmio                            41           45.8          26         14651                   1514
16 Internacional                     34           52.4          26         16120                   1469
17 Palmeiras                         31           53.8          26         15495                   1415
18 Santos                            45           44.1          26         13489                   1515
19 São Paulo                         35           60.5          26         17832                   1626
20 Vasco da Gama                     39           47.5          26         14282                   1550
# ℹ abbreviated name: ¹​touches_defensive_penalty_box
# ℹ 20 more variables: touches_defensive_third <dbl>, touches_middle_third <dbl>,
#   touches_final_third <dbl>, touches_attacking_penalty_box <dbl>, inplay_touches <dbl>,
#   take_ons_attempted <dbl>, successful_take_ons <dbl>, successful_take_on_percentage <dbl>,
#   tackles_during_take_on <dbl>, tackles_during_take_on_percentage <dbl>, carries <dbl>,
#   total_carrying_distance <dbl>, progressive_carrying_distance <dbl>, progressive_carries <dbl>,
#   carries_into_final_third <dbl>, carries_into_penalty_box <dbl>, miscontrols <dbl>, …

# Nation and league columns in dataframe
# If you want to see nation and league in the three letter code format
possession$nation <- gsub("^.+\\s", "", possession$nation)
possession$league <- gsub("^.+\\s", "", possession$league)
```

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
- **openxlsx**

Additionally, it's recommended to use **testthat** for testing.

## Author and Maintainer

- **Author**: Jeffrey Ohene
- **Maintainer**: Jeffrey Ohene (jeffrey.ohene@aol.com)

## License

This package is released under the MIT License. See the LICENSE file for 
details.


### Contributing
If you would like to contribute to this project, please check the contributions file for this package.

### Reporting Issues
We regularly monitor the packages' functions' performance and functionality and 
release updates as needed to ensure its reliability. If you encounter any 
issues or have suggestions for improvements, please don't hesitate to open an 
issue on our [GitHub repository](https://github.com/jeffreyohene/wikiscrapeR/issues) and provide as much detail as possible to help us understand and address the issue.

Explore football analytics and data scraping with **kickR**, your go-to R package for football enthusiasts, analysts, and data scientists.

Project icon from icon8.com
