## WD Albums
dir.create("updates/albums", showWarnings = F)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/wd-albums.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/albums/query.json")
    query_results <- 
      jsonlite::fromJSON("updates/albums/query.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    
    dir.create("nightlies/qid-album", showWarnings = F)
    write_parquet(query_results, "nightlies/qid-album/nightly.parquet")
  }, error = function(cond)"skip"
)