## WD People
dir.create("updates/people", showWarnings = F)
dir.create("nightlies/qid-person", showWarnings = F)

### COUNT RECORDS

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/film/count-performing-artists.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-performing-artists.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-performing-artists.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-performing-artists.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/film/count-filmmakers.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-filmmakers.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-filmmakers.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-filmmakers.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/film/count-creative-directors.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-creative-directors.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-creative-directors.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-creative-directors.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/count-bands.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-bands.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-bands.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-bands.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/count-discogsArtistID.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-discogsArtistID.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-discogsArtistID.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-discogsArtistID.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/count-musical-profession.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-musical-profession.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-musical-profession.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-musical-profession.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/count-musicians.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/count-musicians.json")
    counts <- 
      jsonlite::fromJSON("updates/people/count-musicians.json")$results$bindings %>%
      reframe(
        QID = basename(item$value))
    write_parquet(counts, "nightlies/qid-person/count-musicians.parquet")
  }, error = function(cond)"skip"
)


#### RECENT UPDATES

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/film/wd-creative-directors.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-creative-directors.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-creative-directors.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-creative-directors.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/film/wd-filmmakers.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-filmmakers.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-filmmakers.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-filmmakers.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/film/wd-performing-artists.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-performing-artists.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-performing-artists.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-performing-artists.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/wd-bands.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-bands.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-bands.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-bands.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/wd-discogsArtistID.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-discogsArtistID.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-discogsArtistID.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-discogsArtistID.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/wd-musical-profession.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-musical-profession.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-musical-profession.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-musical-profession.parquet")
  }, error = function(cond)"skip"
)

tryCatch(
  expr = {
    query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/music/wd-musicians.sparql"), "[\r\n]" , " ")))
    download.file(
      url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
      destfile = "updates/people/wd-musicians.json")
    counts <- 
      jsonlite::fromJSON("updates/people/wd-musicians.json")$results$bindings %>%
      reframe(
        QID = basename(item$value),
        updated = substr(date$value, 1, 10),
        file = paste0(updated, "-", QID, ".rds"))
    write_parquet(counts, "nightlies/qid-person/recent-musicians.parquet")
  }, error = function(cond)"skip"
)