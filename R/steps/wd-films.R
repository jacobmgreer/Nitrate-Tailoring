## WD Films
dir.create("updates/films", showWarnings = F)


tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/wd-films.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/films/query.json")
    query_results <- 
      jsonlite::fromJSON("updates/films/query.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".parquet"))
    
    dir.create("nightlies/qid-film", showWarnings = F)
    write_parquet(query_results, "nightlies/qid-film/nightly.parquet")
  }, error = function(cond)"skip"
)