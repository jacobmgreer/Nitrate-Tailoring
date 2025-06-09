## TMDb Content
dir.create("updates/series", showWarnings = F, recursive = T)

download.file(
  url = paste0("https://api.themoviedb.org/3/tv/changes?api_key=", TMAPI, "&page=1&start_date=", since),
  destfile = paste0("updates/series/", str_pad(1, 4, pad = "0"), ".json"))

for (i in c(2:fromJSON("updates/content/0001.json")$total_pages)) {
  download.file(
    url = paste0("https://api.themoviedb.org/3/tv/changes?api_key=", TMAPI, "&page=", i, "&start_date=", since),
    destfile = paste0("updates/series/", str_pad(i, 4, pad = "0"), ".json"))
  Sys.sleep(0.1)
}

fix_NULL <- function(variables) {
  variables <- variables %>%
    map(~ ifelse(is.null(.x), NA, .x))
  tibble::as_tibble(variables)
}

tryCatch(
  expr = {
    tm_content <-
      list.files("updates/series", full.names = T) %>%
      map_dfr(~ fromJSON(.x) %>% compact()) %>%
      pull(results) %>%
      reframe(id)
      
    dir.create("nightlies/tm-series", showWarnings = F)
    write_parquet(tm_content, paste0("nightlies/tm-series/", since, ".parquet"))
  }
)