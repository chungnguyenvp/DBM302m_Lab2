# Import necessary libraries
import os
import pandas as pd

# Import necessary libraries
from prefixspan import PrefixSpan

# Resolve data files relative to this script so it runs from any working directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Load the sample dataset (replace with your dataset file)
df = pd.read_csv(os.path.join(BASE_DIR, "example_sequenceid_dataset.csv"))

# Data preprocessing (cleaning, missing value handling, feature selection)
# Example: Removing rows with missing values
df = df.dropna()

# Convert data to a list of sequences
# The "Actions" column holds a comma-separated sequence, e.g. "A, B, C, D"
sequences = [[a.strip() for a in row.split(",")] for row in df["Actions"]]

# Apply PrefixSpan algorithm to discover sequential patterns
ps = PrefixSpan(sequences)
patterns = ps.frequent(2)  # Discover sequences occurring at least twice; each item is (support, pattern)

# Print sequential patterns
for support, pattern in patterns:
    print("Pattern:", pattern, "Support:", support)

# Evaluate and filter patterns based on specific criteria
min_support = 2
max_length = 4

filtered_patterns = [(support, pattern) for support, pattern in patterns
                     if support >= min_support and len(pattern) <= max_length]

# Print the filtered patterns
print("Filtered Sequential Patterns:")
for support, pattern in filtered_patterns:
    print("Pattern:", pattern, "Support:", support)
