# Load required libraries
library(arules)

# Load the sample dataset (replace with your dataset file)
df <- read.csv("example_grocery_transaction_dataset.csv", header = TRUE, stringsAsFactors = FALSE)

# Data preprocessing (cleaning, missing value handling, feature selection)
# Example: Removing rows with missing values
df <- na.omit(df)

# Convert data to a transaction format
# The "Items" column holds a comma-separated basket, e.g. "Apple, Banana, Cereal"
basket_list <- lapply(strsplit(as.character(df$Items), ","), trimws)
transactions <- as(basket_list, "transactions")

# Apply Apriori algorithm to find frequent itemsets
frequent_itemsets <- apriori(transactions, parameter = list(support = 0.2, target = "frequent itemsets"))

# Generate association rules from frequent itemsets
rules <- apriori(transactions, parameter = list(support = 0.2, confidence = 0.7, target = "rules"))

# Print frequent itemsets and association rules
cat("Frequent Itemsets:\n")
inspect(frequent_itemsets)

cat("\nAssociation Rules:\n")
inspect(rules)
