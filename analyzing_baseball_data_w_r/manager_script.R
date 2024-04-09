library(Lahman)
library(tidyverse)

Managers %>%
  filter(yearID >= 1980) %>%
  group_by(playerID) %>%
  summarize(Total_Wins = sum(W),
            Total_Loses = sum(L)) %>%
  mutate(Win_Pct = Total_Wins / (Total_Loses+Total_Wins)) %>%
  filter(Total_Wins+Total_Loses > 162*4) %>%
  arrange(desc(Win_Pct)) -> Ranked_Managers_Win_Pct_Since_1980


mangers_ranked_and_info <- inner_join(Ranked_Managers_Win_Pct_Since_1980, People, by="playerID")

mangers_ranked_and_info %>%
  select(playerID, nameFirst, nameLast, Total_Wins, Total_Loses, Win_Pct ) %>%
  arrange(desc(Win_Pct)) -> mangers_ranked_and_info


View(Ranked_Managers_Win_Pct_Since_1980)


View(mangers_ranked_and_info)
View(People)