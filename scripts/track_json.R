library(dplyr)
library(tidyr)
library(jsonlite)
setwd("YOUR_METRICA_DIR")

tidy_metrica <- function(file, team){
  sample <- as.tbl(read.csv(file, header = F, skip = 3))
  print(sample)
  
  tidy_sample <- sample %>% select(1:5)
  names(tidy_sample)[4:5] <- c('x', 'y')
  tidy_sample$player <- 1
  P <- 2
  
  for( i in seq(6, dim(sample)[2]-1, by = 2) ){
    
    player_cols <- sample %>% select(1:3, i, i+1)
    names(player_cols)[4:5] <- c('x', 'y')
    player_cols$player <- P
    tidy_sample <- rbind(tidy_sample, player_cols)
    P <- P+1
    print(tail(tidy_sample))
    
  }
  
  tidy_sample$player <- ifelse(tidy_sample$player == max(tidy_sample$player), 'ball', tidy_sample$player)
  if(team == 'A'){ tidy_sample <- tidy_sample %>% filter(player != 'ball') }
  tidy_sample$team <- team
  tidy_sample$marker <- ifelse(tidy_sample$player == 'ball', 'ball', tidy_sample$team)
  
  return(tidy_sample)
}

track <- rbind(tidy_metrica('data_csv/Sample_Game_1/Sample_Game_1_RawTrackingData_Home_Team.csv', 'H'),
               tidy_metrica('data_csv/Sample_Game_1/Sample_Game_1_RawTrackingData_Away_Team.csv', 'A'))
names(track) <- c('period', 'frame', 'time', 'x', 'y', 'player_id', 'team', 'marker')


frames <- events_min %>% pull(start_frame)
k <- 0
for(i in frames){
  k <- k + 1
  write_json(
    track %>% filter(frame == i, x >= 0, y >= 0), 
    paste0('data_json/tracks/track_frame', i, '.json')
  )
  print(paste(i, k))
}

