# Load required libraries
library(readr)
library(dplyr)
library(stats)
library(ggplot2)

# Load the sample dataset (replace with your dataset file)
df <- read_csv("example_features_dataset.csv")

# Data preprocessing (cleaning, missing value handling, feature selection)
# Example: Removing rows with missing values
df <- na.omit(df)

# Assuming your dataset is already preprocessed and features are selected
# Assuming you have selected two features "Feature1" and "Feature2"
data <- df %>% select(Feature1, Feature2)

# Apply K-Means clustering to the data
set.seed(0)
km <- kmeans(data, centers = 3, nstart = 10)  # Specify the number of clusters
df$Cluster <- km$cluster  # Assign clusters to data points

print(as.data.frame(df))

# Visualize the clusters
p <- ggplot(df, aes(x = Feature1, y = Feature2, color = factor(Cluster))) +
  geom_point() +
  labs(x = "Feature1", y = "Feature2") +
  scale_color_discrete(name = "Cluster") +
  theme_minimal()
print(p)
