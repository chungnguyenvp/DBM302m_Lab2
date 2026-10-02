# Import necessary libraries
import os
import pandas as pd

# Import necessary libraries
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

# Resolve data files relative to this script so it runs from any working directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Load the sample dataset (replace with your dataset file)
df = pd.read_csv(os.path.join(BASE_DIR, "example_features_dataset.csv"))

# Data preprocessing (cleaning, missing value handling, feature selection)
# Example: Removing rows with missing values
df = df.dropna()

# Assuming your dataset is already preprocessed and features are selected
# Assuming you have selected two features "Feature1" and "Feature2"
data = df[["Feature1", "Feature2"]]

# Apply K-Means clustering to the data
kmeans = KMeans(n_clusters=3, n_init=10, random_state=0)  # Specify the number of clusters
kmeans.fit(data)
df["Cluster"] = kmeans.labels_  # Assign clusters to data points

print(df)

# Visualize the clusters (optional)
plt.scatter(data["Feature1"], data["Feature2"], c=df["Cluster"], cmap='viridis')
plt.xlabel("Feature1")
plt.ylabel("Feature2")
plt.show()
