library('tidyverse')
library(Lahman)
library(broom)
install.packages("ggrepel")
library(ggrepel)

View(tail(Teams,3))


Teams %>%
  filter(yearID >= 2018) -> Teams_2018_beyond


View(Teams_2018_beyond)
Teams_2018_beyond %>%
  reframe(Year = yearID,
            Team = teamID,
            Wins = W,
            Losses = L,
            Runs_Scored = R,
            Runs_Allowed = RA,
            Run_Differential = R-RA,
            Win_Pct = W/ (W+L)) -> Teams_2018_beyond_summary


View(Teams_2018_beyond_summary)
rundiff_plot <- ggplot(Teams_2018_beyond_summary, aes(x=Run_Differential, y=Win_Pct)) +
  geom_point() +
  labs(x='Run Differntial', y = 'Win Pct %', title='Win Percentage based on Run Differential')


linfit <- lm(Win_Pct ~ Run_Differential, data=Teams_2018_beyond_summary)


rundiff_plot +
  geom_smooth(method = "lm", se = FALSE, color= 'blue')



my_teams_aug <- augment(linfit, data=Teams_2018_beyond_summary)


View(my_teams_aug)


base_plot <- ggplot(data=my_teams_aug, aes(x=Run_Differential, y=.resid)) +
  geom_point(alpha = .3) +
  geom_hline(yintercept = 0, linetype=3) +
  xlab("Run differential" ) + ylab("Residual")

highlight_teams <- my_teams_aug %>%
  arrange(desc(abs(.resid))) %>%
  head(4)


text_plot <- base_plot +
  geom_point(data=highlight_teams, color='blue') +
  geom_text_repel(data=highlight_teams, color='blue', aes(label=paste(Team, Year)))

View(text_plot)