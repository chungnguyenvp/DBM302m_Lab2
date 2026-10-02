# Load the sample dataset (replace with your dataset file)
df <- read.csv("example_sequenceid_dataset.csv", header = TRUE, stringsAsFactors = FALSE)

# Data preprocessing (cleaning, missing value handling, feature selection)
# Example: Removing rows with missing values
df <- na.omit(df)

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

# Convert data to a list of sequences
# The "Actions" column holds a comma-separated sequence, e.g. "A, B, C, D"
sequences <- lapply(strsplit(df$Actions, ","), trimws)

# Apply PrefixSpan algorithm to discover sequential patterns
patterns <- prefixspan_mine(sequences, minsup = 2)  # Discover sequences occurring at least twice

# Print sequential patterns
for (i in seq_len(nrow(patterns))) {
  cat("Pattern:", paste(patterns$pattern[[i]], collapse = " -> "), "Support:", patterns$support[i], "\n")
}
