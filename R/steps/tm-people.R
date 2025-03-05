## TMDb People
dir.create("updates/people", showWarnings = F, recursive = T)

download.file(
  url = paste0("https://api.themoviedb.org/3/person/changes?api_key=", TMAPI, "&page=1&start_date=", since, "&end_date=", since),
  destfile = paste0("updates/people/", str_pad(1, 4, pad = "0"), ".json"))

for (i in c(2:fromJSON("updates/people/0001.json")$total_pages)) {
  download.file(
    url = paste0("https://api.themoviedb.org/3/person/changes?api_key=", TMAPI, "&page=", i, "&start_date=", since, "&end_date=", since),
    destfile = paste0("updates/people/", str_pad(i, 4, pad = "0"), ".json"))
  Sys.sleep(0.1)
}

tryCatch(
  expr = {
    tm_people <-
      list.files("updates/people", full.names = T) %>%
      map_dfr(~ fromJSON(.x) %>% compact()) %>%
      pull(results) %>%
      reframe(id)
    
    dir.create("nightlies/tm-people", showWarnings = F)
    write_parquet(tm_people, paste0("nightlies/tm-people/", since, ".parquet"))
  }
)