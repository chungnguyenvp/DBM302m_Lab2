# Load the text dataset from a CSV file
data <- read.csv("product_reviews.csv", stringsAsFactors = FALSE)

# Extract review text from the DataFrame
reviews <- data$ReviewText

# Tokenize the text into words (lowercase, punctuation stripped; keeps apostrophes and hyphens)
tokenize <- function(text) {
  text <- tolower(text)
  regmatches(text, gregexpr("[a-z0-9]+(?:['-][a-z0-9]+)*", text, perl = TRUE))[[1]]
}

# Calculate the PMI for all pairs of words that occur together in a review
# Counts are document frequencies, so p(x), p(y) and p(x, y) are on the same scale
calculate_pmi <- function(texts) {
  n <- length(texts)
  word_lists <- lapply(texts, tokenize)

  word_count <- table(unlist(lapply(word_lists, unique)))
  pair_count <- table(unlist(lapply(word_lists, function(words) {
    if (length(words) < 2) return(character(0))
    idx <- combn(length(words), 2)  # every ordered pair (i < j)
    unique(paste(words[idx[1, ]], words[idx[2, ]]))
  })))

  pair_names <- names(pair_count)
  w1 <- sub(" .*$", "", pair_names)
  w2 <- sub("^\\S+ ", "", pair_names)

  pmi <- log((as.numeric(pair_count) * n) / (as.numeric(word_count[w1]) * as.numeric(word_count[w2])))
  names(pmi) <- pair_names

  return(pmi)
}

# Extract meaningful quality phrases based on PMI
extract_quality_phrases <- function(pmi, threshold = 1.0) {
  quality_phrases <- names(pmi[pmi >= threshold])
  return(quality_phrases)
}

# Calculate PMI and extract quality phrases
pmi_scores <- calculate_pmi(reviews)
threshold <- 1.0  # Adjust the threshold as needed
quality_phrases <- extract_quality_phrases(pmi_scores, threshold)

# Print quality phrases
cat("Quality Phrases:\n")
cat(quality_phrases, sep = "\n")
