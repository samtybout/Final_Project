library(readr)
data = read_csv("pbdb_data_full.csv", 
                           col_types = cols(accepted_no = col_integer(), 
                                            collection_no = col_integer(), flags = col_character(), 
                                            late_interval = col_character(), 
                                            occurrence_no = col_integer(), ref_pubyr = col_integer(), 
                                            reference_no = col_integer(), reid_no = col_integer(), 
                                            subgenus_name = col_character(), 
                                            subgenus_reso = col_character()), 
                           skip = 21)

# Remove all entries where publication year is missing
data = data[!is.na(data$ref_pubyr),]
# Sort data by publication year
data = data[order(data$ref_pubyr),]
# Mark which entries are new species descriptions
data$is_new_taxon = !duplicated(data$accepted_no)
# Reduce the dataset to entries that are either the first instance of a species or the first instance of a publication
data = data[!duplicated(data$reference_no) | data$is_new_taxon,]



publist = split(data, data$reference_no)
countnew = function(publication_data){
  return(sum(publication_data$is_new_taxon))
}
new_count = lapply(publist, countnew)
