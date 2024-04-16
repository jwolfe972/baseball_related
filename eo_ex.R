library(tidyverse)

eo_data <- read_csv('analyzing_baseball_data_w_r/datasets/eovaldi_all_pitches.csv')
eo_data %>%
  filter(pitch_name != "Intentional Ball" &
          pitch_name != "Pitch Out" & pitch_name != "Changeup" & pitch_name != "Sinker") -> eo_data




ggplot(data=training_eovaldi_data, aes(x=release_spin_rate, y=release_speed,color=pitch_name))+
geom_point() +
  labs(title = "Nathan Eovaldi Release Speed and Spin Rate on Pitches w/ the Pitch Type", y="Release Speed (mph)", x="Spin Rate")


eo_data %>%
  select(release_spin_rate, release_speed, pitch_name) -> training_eovaldi_data


eo_data %>%
  select(pitch_name) -> training_eovaldi_data_labels

View(training_eovaldi_data_labels)


training_eovaldi_data <- training_eovaldi_data[complete.cases(training_eovaldi_data), ]


training_eovaldi_data %>%
  select(release_spin_rate, release_speed) -> training_eovaldi_data_unlabeled

training_eovaldi_data %>%
  select(pitch_name) -> training_eovaldi_data_labels


write_csv(training_eovaldi_data_unlabeled,'analyzing_baseball_data_w_r/datasets/training_data_eo.csv')
write_csv(training_eovaldi_data_labels,'analyzing_baseball_data_w_r/datasets/training_data_labels_eo.csv')



test_eo_data <- read_csv('analyzing_baseball_data_w_r/datasets/eo_test.csv')


test_eo_data %>%
  filter(game_date == "2024-04-14") -> test_eo_data

test_eo_data %>%
  select(release_spin_rate, release_speed, pitch_name) -> test_data


test_data <- test_data[complete.cases(test_data), ]


test_data %>%
  select(release_spin_rate, release_speed) -> test_data_unlabled

test_data %>%
  select(pitch_name) -> test_data_labels

write_csv(test_data_unlabled,'analyzing_baseball_data_w_r/datasets/test_data_eo.csv')
write_csv(test_data_labels,'analyzing_baseball_data_w_r/datasets/test_data_eo_labels.csv')

