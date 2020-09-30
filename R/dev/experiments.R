library(readr)
string_test_results <- read_delim("_data/string_test_results.csv",
                                  ";", escape_double = FALSE, trim_ws = TRUE)
ncbi = 318829 # ID of magnaporthe oryzae
D = data.table(read_delim("_data/string_test_results.csv",
                          ";", escape_double = FALSE, trim_ws = TRUE))
x = D$uniprot
method = "get_string_ids"
format = "tsv"
species=ncbi
echo_query=1

get_string_db_data_ = function(x, method, format='tsv', ...){
  http = file.path("https://string-db.org/api", format, method, fsep='/')
  body = list(identifiers=paste(x, collapse='\r'), ...)
  data = httr::POST(http, body=body)
  Sys.sleep(1)
  return(data)
}

readers = list(tsv=data.table::fread)

#' Get tabular data from the post.
get_tabular_data = function(x, method, format='tsv', ...){
  X = get_string_db_data_(x, method, format, ...)
  binary = readBin(X$content, "character")
  # X = readers[[format]](binary)
  # return(data.table::data.table(X))
  return(binary)
}

map_identifiers = function(identifiers,
                           species_ncbi_id,
                           format='tsv',
                           echo_query=1,
                           ...)
  get_tabular_data(identifiers,
                   "get_string_ids",
                   format,
                   species=species_ncbi_id,
                   echo_query=echo_query,
                   ...)
X = map_identifiers(x, ncbi)
data.table::fread(X)
read.table(X,sep = '\t', header = TRUE)

