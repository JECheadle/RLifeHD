#' Build project folder objects.
#'
#' Creates and setwd() to project directory top-level folder. Manage folders using file.path().
#'
#' @param project contains the top-level folder.
#' @param subproject contains the project-specific subfolder.
#'
#' @return The working directory as \code{working}.
#' @export lhd_dir
#'
#' @examples
#' library(devtools)
#' install_github("JECheadle/RLifeHD",
#'     auth_token = "b1ab72ab80f8caf23999bd91cf4042018efaea18")
#'
#' library(RLifeHD)
#' Wdir <- lhd_dir("StudentHD1", "sHD1_Race")
#' Wdir <- lhd_dir(StudentHD1, sHD1_Race)

library(tidyverse)
library(crayon)
lhd_dir <- function(project, subproject) {
    # project <- quote(project)
    # subproject <- quote(subproject)
    ## Determine which machine, prepare hosts projects
    sysinfo <- Sys.info()
    host <- sysinfo[["nodename"]]
    user <- sysinfo[["user"]]
    sysname <- sysinfo[["sysname"]]
    ## data("lhd_dir")
    hosts <- filter(hosts, (hostname == host | hostname == sysname), username == user)
    ## hosts checks
    if (dim(hosts)[1] == 0) {
        stop("Host file problem:  missing user or computer?")
    }
    else if (dim(hosts)[1] > 1) {
        warning("Host file problem: more than one user/computer combo identified.")
    }
    ## Constructing the paths
    Working <- file.path(hosts[1,3], enexpr(project), enexpr(subproject))
    setwd(Working)
    cat(crayon::bold(crayon::green(sprintf("Working directory set to:\n"))))
    cat(crayon::magenta(sprintf("   %s\n", file.path(Working))))
    return(Working)
}

#lhd_dir(StudentHD1, sHD1_Psych)
#lhd_dir("StudentHD1", "sHD1_Race")



