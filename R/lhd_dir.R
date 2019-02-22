#' Build project folder objects.
#'
#' Creates and setwd() to project directory top-level folder. Creates subfolders
#' as objects. Manage folders using file.path().
#'
#' @param project contains the top-level folder.
#' @param subproject contains the project-specific subfolder.
#'
#' @return Folders as variables.
#' @export
#'
#' @examples
#' library(devtools)
#' install_github("JECheadle/RLifeHD",
#'     auth_token = "b1ab72ab80f8caf23999bd91cf4042018efaea18")
#'
#' library(RLifeHD)
#' lhd_dir("StudentHD1", "sHD1_Race")
#'

library(tidyverse)
lhd_dir <- function(project, subproject) {
    ## Determine which machine, prepare hosts projects
    sysinfo <- Sys.info()
    host <- sysinfo[["nodename"]]
    user <- sysinfo[["user"]]
    ## data("lhd_dir")
    hosts <- filter(hosts, hostname == host, username == user)
    projects <- filter(projects, project == subproject)
    ## hosts checks
    if (dim(hosts)[1] == 0) {
        stop("Host file problem:  missing user or computer?")
    }
    else if (dim(hosts)[1] > 1) {
        stop("Host file problem: more than one user/computer combo identified.")
    }
    ## projects checks
    if (dim(projects)[1] == 0) {
        stop("Project list problem: subproject folder not found.")
    }
    ## Constructing the paths
    assign("Working",
           file.path(hosts[1,3], project, projects$project[[1]]),
           envir=globalenv())
    setwd(file.path(Working))
    cat(crayon::bold(crayon::green(sprintf("Working directory set to:\n"))))
    cat(crayon::magenta(sprintf("   Working: %s\n", file.path(Working))))
    cat(crayon::bold(crayon::green(sprintf("Subfolders set to: \n"))))
    for (ii in 1:dim(projects)[1]) {
        assign(projects$gmac[[ii]],
               file.path(projects$spath[[ii]]),
               envir=globalenv())
        cat(crayon::magenta(sprintf("   %s: %s\n", projects$gmac[[ii]], projects$spath[[ii]])))
    }
    cat(crayon::bold(crayon::cyan("Note: manage paths using 'file.path()'.")))
}

#lhd_dir(StudentHD1, sHD1_Psych)
#lhd_dir("StudentHD1", "sHD1_Race")


