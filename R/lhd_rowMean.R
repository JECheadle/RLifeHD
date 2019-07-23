#' Calculates row missing with means coded to NA based on number of missing variables.
#'
#'
#' @param data the tibble or data.frame.
#' @param newvar is the name of the new variable.
#' @param vars is the vector of variable names that will be used to calculate the row mean.
#' @param num_miss is the number of missing that will be used to determine if the row mean should be missing. It is expressed as \code{>=}. Therefore, if \code{num_miss == 2}, the variable would be coded to \code{NA} if 2 or more variables in the list are missing.
#'
#' @return The tibble or data.frame with the row mean and the number of missing across the variable list.
#' @export lhd_dir
#'
#' @examples
#' library(RLifeHD)
#' library(tidyverse)
#' master <- tibble(x = c(1:5, NA,NA), y = c(1,2,3,4,NA, NA,7))
#' master
#' vars <- c("x", "y")
#' master <- lhd_rowMean(master, my_row_mean, vars, 1)
#' master

lhd_rowMean <- function(data, newvar, vars, num_miss) {
    newvar <- enquo(newvar)
    na_var <- paste(quo_name(newvar), "na", sep="_")
    data <- data %>%
        mutate(
            means= rowMeans(.[, vars], na.rm=TRUE),
            na = rowSums(is.na(.[, vars])),
            means =
                if_else(na >= num_miss, as.numeric(NA),
                        as.numeric(means))
        ) %>%
        rename(!!newvar := means, !!na_var := na)
    return(data)
}

