
#'Check project, user, and directory data files, resave from master if needed.
#'
#'\code{lhd_dir_builder} will check the master excel file against the *.RData
#'version. If they differ will save new versions of RData and *.csv versions
#'for the the stata version.
#'@param Takes no parameters.
#'@return
#'@export
#'
#' @examples
#' ## Run the command
#' lhd_dir_builder()
lhd_dir_builder <- function() {
    ## Not sure what best solution is here
    setwd("/Users/jcheadle2/Box/GitHub/Software/R/LifeHD")
    ## Load Data
    packageStartupMessage("LifeHD: Checking project dir files...")
    xhosts <- as_tibble(read_excel("Data/lhd_dir.xlsx", sheet = "Hosts"))
    xprojects <- as_tibble(read_excel("Data/lhd_dir.xlsx", sheet = "Projects"))
    data(lhd_dir, envir = parent.env(environment()))
    ## Check data, resave as needed
    if (dim(xhosts)[1] != dim(hosts)[1] | dim(xprojects)[1] != dim(projects)[1]) {
        cat(crayon::bold(crayon::green("LifeHD: Updating project dir files...")))
        hosts <- xhosts
        projects <- xprojects
        write.csv(hosts, file = "../../Stata-ado/lhd_dir_hosts.csv", row.names = FALSE)
        write.csv(projects, file = "../../Stata-ado/lhd_dir_projects.csv", row.names = FALSE)
        save(hosts, projects, file = "Data/lhd_dir.RData")
    }
}
