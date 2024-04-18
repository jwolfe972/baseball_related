import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# Read CSV
eo_data = pd.read_csv('analyzing_baseball_data_w_r/datasets/eovaldi_all_pitches.csv')

# Filter out unwanted pitch types
eo_data = eo_data[~eo_data['pitch_name'].isin(["Intentional Ball", "Pitch Out", "Changeup", "Sinker"])]

# Plot release speed vs. release spin rate with color representing pitch type
sns.scatterplot(data=eo_data, x="release_spin_rate", y="release_speed", hue="pitch_name")
# plt.scatter(eo_data['release_spin_rate'], eo_data['release_speed'], color=eo_data['pitch_name'])
plt.title("Nathan Eovaldi Release Speed and Spin Rate on Pitches w/ the Pitch Type")
plt.xlabel("Spin Rate")
plt.ylabel("Release Speed (mph)")
plt.show()

# Select relevant columns for training data
training_eovaldi_data = eo_data[['release_spin_rate', 'release_speed', 'pitch_name']]

# Save training data and labels to CSV files
training_eovaldi_data[['release_spin_rate', 'release_speed']].to_csv('analyzing_baseball_data_w_r/datasets'
                                                                   '/training_data_eo.csv', index=False)
training_eovaldi_data['pitch_name'].to_csv('analyzing_baseball_data_w_r/datasets/training_data_labels_eo.csv', index=False)

# Read test data
test_eo_data = pd.read_csv('analyzing_baseball_data_w_r/datasets/eo_test.csv')

# Filter test data for a specific game date
test_eo_data = test_eo_data[test_eo_data['game_date'] == "2024-04-14"]

# Remove rows with missing values
test_data = test_eo_data.dropna(subset=['release_spin_rate', 'release_speed', 'pitch_name'])

# Select relevant columns for test data
test_data_unlabeled = test_data[['release_spin_rate', 'release_speed']]
test_data_labels = test_data['pitch_name']

# Save test data and labels to CSV files
test_data_unlabeled.to_csv('analyzing_baseball_data_w_r/datasets/test_data_eo.csv', index=False)
test_data_labels.to_csv('analyzing_baseball_data_w_r/datasets/test_data_eo_labels.csv', index=False)
