# Load required libraries
library(readr)
library(dplyr)
library(stats)
library(ggplot2)
library(cluster)  # provides silhouette()

# Load the sample dataset (replace with your dataset file)
df <- read.csv("example_features_dataset.csv", header = TRUE)

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

# Visualize the clusters
p <- ggplot(df, aes(x = Feature1, y = Feature2, color = factor(Cluster))) +
  geom_point() +
  labs(x = "Feature1", y = "Feature2") +
  scale_color_discrete(name = "Cluster") +
  theme_minimal()
print(p)

# Calculate the silhouette score
sil <- silhouette(df$Cluster, dist(data))
silhouette_avg <- mean(sil[, "sil_width"])
cat("Silhouette Score:", silhouette_avg, "\n")

# Calculate within-cluster sum of squares (WCSS)
# k cannot exceed the number of distinct points, so cap the range for small datasets
max_k <- min(10, nrow(unique(data)))
wcss <- numeric(max_k)
for (i in 1:max_k) {
  km_i <- kmeans(data, centers = i, nstart = 10)
  wcss[i] <- sum(km_i$withinss)
}

# Print the WCSS values
cat("WCSS:\n")
for (i in 1:max_k) {
  cat(paste("Cluster", i, ":", wcss[i], "\n"))
}
