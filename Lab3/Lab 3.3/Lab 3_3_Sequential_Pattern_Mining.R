# Read the dataset from a CSV file
data <- read.csv("customer_transactions_dataset.csv", stringsAsFactors = FALSE)

# Simple PrefixSpan for sequences of single items (base R, no extra package needed).
# Returns a data.frame with the pattern (character vector in a list column),
# its length, and its support (number of sequences containing it in order).
prefixspan_mine <- function(sequences, minsup) {
  out <- list()
  mine <- function(prefix, projected) {
    items <- sort(unique(unlist(projected)))
    for (it in items) {
      has_it <- vapply(projected, function(s) it %in% s, logical(1))
      sup <- sum(has_it)
      if (sup >= minsup) {
        new_prefix <- c(prefix, it)
        out[[length(out) + 1]] <<- list(sequence = new_prefix, support = sup)
        new_proj <- lapply(projected[has_it], function(s) tail(s, length(s) - match(it, s)))
        mine(new_prefix, new_proj)
      }
    }
  }
  mine(character(0), sequences)
  data.frame(
    pattern = I(lapply(out, `[[`, "sequence")),
    length  = vapply(out, function(o) length(o$sequence), integer(1)),
    support = vapply(out, function(o) as.integer(o$support), integer(1))
  )
}

# Extract the sequence data from the DataFrame
sequences <- lapply(strsplit(data$Sequence, ","), trimws)

# Apply PrefixSpan algorithm to discover frequent sequential patterns
min_support <- 2
patterns <- prefixspan_mine(sequences, minsup = min_support)

# Create a DataFrame to store the patterns and their support
pattern_data <- data.frame(
  Pattern = vapply(patterns$pattern, function(p) paste(p, collapse = " -> "), character(1)),
  Support = patterns$support,
  Pattern_Length = patterns$length,
  stringsAsFactors = FALSE
)
pattern_data <- pattern_data[order(-pattern_data$Support, -pattern_data$Pattern_Length), ]

# Print the frequent sequential patterns
cat("Frequent Sequential Patterns:\n")
print(pattern_data, row.names = FALSE)

# Save the results to a CSV file
write.csv(pattern_data, file = "frequent_patterns.csv", row.names = FALSE)
