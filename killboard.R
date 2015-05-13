corporation_file_name <- function(corporation_id) {
  paste("csv/corporation_", corporation_id, ".csv", sep="")
}

averages <- function(corporation_id) {
  kill_data <- read.csv(corporation_file_name(corporation_id))
  summary(kill_data)
}

fleets <- function(corporation_id, corp_name = "") {
  kill_data <- read.csv(corporation_file_name(corporation_id))
  only_kills <- subset(kill_data, kill_data$kill == 1)
  bins = c(0, 1, 2, 3, 4, 5, 10, 20, 40, 1000)
  graph_name <- paste("Fleet Size for ", corporation_id, ":", corp_name, sep="")
  histinfo <- hist(only_kills$attackers, col="lightblue", labels=TRUE, breaks=bins, freq=TRUE, xaxt="n", xlim=c(0,40), main=graph_name)
  axis(1, at=bins[-1], labels=c("1", "2", "3", "4", "5", "10", "20", "40", "500+"))
  histinfo
}

activity <- function(corporation_id, corp_name = "") {
  kill_data <- read.csv(corporation_file_name(corporation_id))
  active_hours <- as.integer(format(as.POSIXct(kill_data$time, format = "%Y-%m-%d %H:%M:%S"), "%H"))
  graph_name <- paste("Activity Hours for ", corporation_id, ":", corp_name, sep="")
  histinfo <- hist(active_hours, col="lightblue", labels=TRUE, plot=TRUE, breaks=24, main=graph_name)
  histinfo
}

report <- function(corporation_id, name) {
  pdf(paste("reports/", name, "-", corporation_id, ".pdf", sep=""))
  activity(corporation_id, name)
  fleets(corporation_id, name)
  dev.off()
}
