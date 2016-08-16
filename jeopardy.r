library(rvest)
library(magrittr)
library(stringr)
source("jfunctions.r")
# 5385
max_game <- 5385
game_ids <- 1:max_game
base_url <- "http://www.j-archive.com/showgame.php?game_id="

urls <- vapply(game_ids, 
               function(x) paste0(base_url, as.character(x)),
               character(1))
               
pages <- lapply(urls, function(x) read_html(x))

dates <- do.call(c, lapply(pages, get_dates))
categories <- lapply(pages, get_categories)
clues <- lapply(pages, get_clues)
responses <- lapply(clues, get_responses)

df <- data.frame(unlist(clues), unlist(responses))