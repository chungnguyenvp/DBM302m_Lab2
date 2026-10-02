# Import necessary libraries
import os
from prefixspan import PrefixSpan
import pandas as pd

# Resolve data files relative to this script so it runs from any working directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Read the dataset from a CSV file
data = pd.read_csv(os.path.join(BASE_DIR, "customer_transactions_dataset.csv"))

# Extract the sequence data and item labeling from the DataFrame
sequences = [[item.strip() for item in row["Sequence"].split(",")] for _, row in data.iterrows()]
item_labels = sorted(set(item for seq in sequences for item in seq))

# Create a mapping of item labels to integers for efficient pattern representation
item_to_int = {item: i for i, item in enumerate(item_labels)}

# Convert the sequences to a list of integer sequences
sequences_int = [[item_to_int[item] for item in seq] for seq in sequences]

# Apply PrefixSpan algorithm to discover frequent sequential patterns
ps = PrefixSpan(sequences_int)

# Discover frequent sequential patterns (e.g., with a minimum support of 2)
min_support = 2
patterns = ps.frequent(min_support)  # each item is (support, pattern)

# Create a DataFrame to store the patterns and their support
pattern_data = {
    "Pattern": [" -> ".join(item_labels[i] for i in pattern) for support, pattern in patterns],
    "Support": [support for support, pattern in patterns],
    "Pattern Length": [len(pattern) for support, pattern in patterns],
}

result_df = pd.DataFrame(pattern_data)
result_df = result_df.sort_values(["Support", "Pattern Length"], ascending=[False, False]).reset_index(drop=True)

# Print the frequent sequential patterns and save them to a CSV file
pd.set_option("display.width", 200)
print("Frequent Sequential Patterns:")
print(result_df)

# Save the results to a CSV file
result_df.to_csv(os.path.join(BASE_DIR, "frequent_patterns.csv"), index=False)
