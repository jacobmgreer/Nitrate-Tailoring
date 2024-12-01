lapply(c("tidyverse", "jsonlite", "arrow"), require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 10*60)

dir.create("nightlies", showWarnings = F)
dir.create("updates", showWarnings = F)

since = Sys.Date() - 2 ## always 48 hours behind

TMAPI <- Sys.getenv("TMAPI") ## API key defined in Repo

source("R/steps/tm-content.R")
source("R/steps/tm-people.R")
# source("R/steps/wd-albums.R")
# source("R/steps/wd-films.R")
# source("R/steps/wd-people.R")

unlink("updates", recursive = T, force = T)
