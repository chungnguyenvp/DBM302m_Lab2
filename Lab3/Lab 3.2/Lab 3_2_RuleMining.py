# Import necessary libraries
import os
import pandas as pd

# Import necessary libraries
from mlxtend.frequent_patterns import apriori
from mlxtend.frequent_patterns import association_rules

# Resolve data files relative to this script so it runs from any working directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Load the sample dataset (replace with your dataset file)
df = pd.read_csv(os.path.join(BASE_DIR, "example_grocery_transaction_dataset.csv"))

# Data preprocessing (cleaning, missing value handling, feature selection)
# Example: Removing rows with missing values
df = df.dropna()

# Convert data to a one-hot encoded format
# The "Items" column holds a comma-separated basket, e.g. "Apple, Banana, Cereal"
onehot_df = df["Items"].str.replace(" ", "", regex=False).str.get_dummies(sep=",").astype(bool)

# Apply Apriori algorithm to find frequent itemsets
frequent_itemsets = apriori(onehot_df, min_support=0.2, use_colnames=True)

# Generate association rules from frequent itemsets
rules = association_rules(frequent_itemsets, metric="lift", min_threshold=1.0)

# Print frequent itemsets and association rules
pd.set_option("display.width", 200)
pd.set_option("display.max_columns", None)

print("Frequent Itemsets:")
print(frequent_itemsets)

print("\nAssociation Rules:")
print(rules)

# Evaluate and filter rules based on specific metrics
min_support = 0.1
min_confidence = 0.5
min_lift = 1.0

filtered_rules = rules[(rules['support'] >= min_support) & (rules['confidence'] >= min_confidence) & (rules['lift'] >= min_lift)]

# Print the filtered rules
print("Filtered Association Rules:")
print(filtered_rules)
