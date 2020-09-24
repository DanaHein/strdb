
library(STRINGdb)
library(tidyverse)
library(readxl)

df_tib = read_csv("data/global_result_table.csv")

df_tib_2 = read_excel("data/2020-045_TM_RapidAdaptationI_TeslaM_quantification_report.xlsx",
                      sheet = "TOP3 quantification",
                      skip = 1)

##### matteos solution #####

library(httr)

# human
accessions = c("P02769","Q9WVQ0","A2ARV4","P32848","P07309","Q9CQ75","P37040","Q0KL02","Q8BL66","Q9D2P8","Q8BWT1","Q8BX70","Q9CR61","Q9CQH3","Q8BK30","P62075","E9Q8T7","Q9D6U8","O70228","P24270","P56375","P49443","Q64105","E9PVA8","Q9ESW4","P97479","O09111","Q9CZT8","P16460","Q02566","Q9D7S9","Q62209","P85094","Q61016","P24549","Q9CQR4","P62835","Q8R164","Q2TV84","P41216","Q8C854","P61164","P56379","Q99J99","P23927","Q64442","Q9R0Q3","P97393","Q59J78","Q9D1G1","Q8CC35","P48193","P62192","P60904","Q8R0F8","Q64520","Q8K4Z3","P50247","O55126","Q8C163","B2RY04","O88448","Q7TPR4","Q14BI2","P62821","Q5U458","P09671","O35215","Q8BLR2","Q9JLZ3","Q8VC30","O35874","Q810T2","Q8BMJ2","E9Q6P5","P60521","P10518","Q5F226","Q62059","Q9R1T4","Q8BWR2","P51830","Q9Z1P6","Q9Z1Q5","Q8BW96","Q9CRB9","O35643","P62889","Q8BG39","P04370","Q9QUR7","Q8BVI4","Q7M6Y3","Q8BQZ4","O70310","Q9JIF0","A2AQP0","P62073","Q923T9","P08032","Q9DBF1","O35526","O54865","Q91VN4","D3YVF0","O55125","Q9JLV5","Q8CGK3","Q5SRX1","Q8K221","P35505","P45952","P51863","Q91XL9","Q8BP47","Q9CYH2","Q6P069","Q60931","P56380","Q61043","Q3TC72","Q04690","Q9JJN2","Q3UTJ2","Q61425","Q8CHG7","P17710","P16858","P35486","Q3ULJ0","Q9D6F9","P16054","P28660")
ncbi_id = 10090

# magnaporthe
ncbi_id = 318829
accessions = df_tib_2$accession

# function
saveNetwork = function(accessions,
                       ncbi_id,
                       path='network.png',
                       ids_per_protein=1L,
                       echo_query=1L){
    params = list(
    identifiers=paste(accessions, collapse='\r'), # your protein list
    species=ncbi_id, # species NCBI identifier
    limit=ids_per_protein, # only one (best) identifier per input protein
    echo_query=echo_query # see your input identifiers in the output
  )
  SDB = POST("https://string-db.org/api/image/network", body = params)
  writeBin(SDB$content, path)
  Sys.sleep(1)
}

# save network.png to current working directory
saveNetwork(accessions, ncbi_id)


library(igraph)

###### STRINGdb #####

df_df = df_tib[1:200,] %>% as.data.frame()
df_df_2 = df_tib %>% as.data.frame()

df_map = string_db$map(df_df, "entry", removeUnmappedRows = TRUE )
df_map_2 = string_db$map(df_df, "entry", removeUnmappedRows = TRUE )

string_db = STRINGdb$new( version="11", species=318829, score_threshold=0, input_directory="" )

string_db$plot_network( df_map$STRING_id )

# enrichment plot geht nicht :-(
# string_db$plot_ppi_enrichment(df_map$STRING_id)
# string_db$plot_ppi_enrichment_graph(df_map$STRING_id, string_igraph, "test_enrichment_plot.png")
# string_igraph = string_db$get_graph()
# plot_ppi_enrichment_graph(df_map$STRING_id, string_igraph, "test_enrichment_plot.png")

enrichmentGO = string_db$get_enrichment(df_map_2$STRING_id, category = "Process")
enrichmentFUNC = string_db$get_enrichment(df_map_2$STRING_id, category = "Function")
enrichmentKEGG = string_db$get_enrichment(df_map_2$STRING_id, category = "KEGG")

