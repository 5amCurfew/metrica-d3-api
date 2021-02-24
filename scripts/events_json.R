library(dplyr)
library(tidyr)
library(jsonlite)
setwd("YOUR_METRICA_DIR")

events <- as.tbl( read.csv('data_csv/Sample_Game_1/Sample_Game_1_RawEventsData.csv', 
                  header = T, skip = 0, stringsAsFactors = FALSE))
events %>% select(Type) %>% unique()

events_min <- events %>% filter(Type %in% c('PASS', 'SHOT', 'SET PIECE', 'CHALLENGE', 'RECOVERY'))
names(events_min) = c('team', 'type', 'sub_type', 'period', 
                      'start_frame', 'start_time', 'end_frame', 'end_time',
                      'from', 'to', 'x', 'y', 'xEnd', 'yEnd')
write_json(
  events_min, 
  'data_json/events/events.json'
)
