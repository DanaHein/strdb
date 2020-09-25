library(readr)
library(data.table)
library(strdb)

# change the use of read.r to actually make this data.
# add R/data.R with description of the data.
# 
# data(test_magnaporthe_oryzae) # this must work.
# D = test_magnaporthe_oryzae

ncbi = 318829 # ID of magnaporthe oryzae
D = data.table(read_delim("_data/string_test_results.csv",
               ";", escape_double = FALSE, trim_ws = TRUE))
ID = map_identifiers(D$uniprot, ncbi, limit=1)
ENRICH = get_functional_enrichment(ID$stringId, ncbi)

saveNetworkPlot(ID$stringId, ncbi, '_tests/test.png')
# saveNetworkPlot(ID$stringId, ncbi, 'test.png', query_limit=20)
fwrite(ENRICH, file='_tests/test_enrich.csv')

