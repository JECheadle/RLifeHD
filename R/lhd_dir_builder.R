
#'Check project, user, and directory data files, resave from master if needed.
#'
#'\code{lhd_dir_builder} will check the master excel file against the *.RData
#'version. If they differ will save new versions of RData and *.csv versions
#'for the the stata version.
#'@param Takes no parameters.
#'@return NA
#'
#' @examples
#' ## Run the command
#' lhd_dir_builder()
#'
lhd_dir_builder <- function() {
    ## Need to hardcode initial path.
    sysinfo <- Sys.info()
    ## added if so only runs on my laptop [can fix this for  more machines later]
    if (sysinfo[["sysname"]] == "Darwin" & sysinfo[["user"]] == "jcheadle2") {
        setwd("/Users/jcheadle2/Box/GitHub/Software/R/RLifeHD")
        ## Load Data
        packageStartupMessage("LifeHD: Checking project dir files...")
        xhosts <- as_tibble(read_excel("Data/lhd_dir.xlsx", sheet = "Hosts"))
        data(lhd_dir, envir = parent.env(environment()))
        ## Check data, resave as needed
        if (dim(xhosts)[1] != dim(hosts)[1]) {
            packageStartupMessage("LifeHD: Updating project dir files...")
            hosts <- xhosts
            write.csv(hosts, file = "../../Stata-ado/lhd_dir_hosts.csv", row.names = FALSE)
            save(hosts, file = "Data/lhd_dir.RData")
        }
    }
}
