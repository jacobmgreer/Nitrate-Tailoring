lapply(c("tidyverse", "jsonlite", "arrow"), require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 10*60)

since = Sys.Date() - 2 ## always 48 hours behind

TMAPI <- Sys.getenv("TMAPI") ## API key defined in Repo

source("R/steps/tm-content.R")
source("R/steps/tm-people.R")
source("R/steps/tm-series.R")

unlink("updates", recursive = T, force = T)

source("R/steps/wd-1.R")
source("R/steps/wd-2.R")

unlink("json", recursive = T, force = T)
