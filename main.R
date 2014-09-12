require(dplyr)

master <- list()
ReadData <- function(master) {
    player_files <- list.files("data/players", full.names = TRUE)
    player_data <- lapply(player_files, function(x) read.csv(x, stringsAsFactors = FALSE))
    names(player_data) <- gsub("/|\\_|data|players|totals|\\.|csv", "", player_files)
    player_data <- lapply(names(player_data), function (x) {
        player_data[[x]][["Name"]] <- rep(x, nrow(player_data[[x]]))
        player_data[[x]][["Season"]] <- substr(player_data[[x]][["Season"]], 1, 4) %.% as.integer() + 1
        return(player_data[[x]][!is.na(player_data[[x]]$Season),])
    })
    agg_player_data <- do.call(rbind, player_data)
    master$player_data <- agg_player_data
    return(master)
}
    
master <- ReadData(master)

