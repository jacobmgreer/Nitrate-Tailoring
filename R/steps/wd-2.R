files <-
  list.files(
    path = "json",
    pattern = ".json",
    recursive = T,
    full.names = T
  )

for (i in files) {
  filepath = str_replace(str_replace(i, "json/", "nightlies/"), ".json", ".parquet")
  tryCatch({
    write_parquet(
      x = 
        jsonlite::fromJSON(i)$results$bindings %>%
        reframe(
          QID = basename(item$value),
          updated = date$value
        ), 
      sink = filepath
    )
  }, error = function(err){})
}