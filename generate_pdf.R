args <- commandArgs(trailingOnly = TRUE)
source("killboard.R")

if (length(args) != 2) {
  stop("Error: <corporation id> <filename>")
}

report(args[1], args[2])
