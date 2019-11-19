library(readr)

load_data = function(){
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
}


count_new_sub = function(publication_data){
  metadata = publication_data[1,]
  year = metadata$ref_pubyr[1]
  output = data.frame(year = year)
  output$reference_no = metadata$reference_no
  output$ref_author = metadata$ref_author
  output$ref_pubyr = metadata$ref_pubyr
  output$n_entries = nrow(publication_data)
  output$new_spp = sum(publication_data$is_new_taxon)
  return(output)
}

count_new = function(data, family = NULL){
  data = data[order(data$ref_pubyr),]
  # Mark which entries are new species
  data$is_new_taxon = !duplicated(data$accepted_no)

  # Mark which entriew are new species of the desired family
  if(!is.null(family)){
    data$is_new_taxon = data$is_new_taxon & (data$family == family)
  }
  # Reduce the dataset to entries that are either the first instance of a species or the first instance of a publication
  data = data[!duplicated(data$reference_no) | data$is_new_taxon,]
  # Split the data by publication
  publist = split(data, data$reference_no)
  new_count = lapply(publist, count_new_sub)
  new_count = do.call(rbind.data.frame, new_count)
  new_count = new_count[order(new_count$ref_pubyr),]
  new_count$new_cumulative = cumsum(new_count$new_spp)
  return(new_count)
}

data = load_data()

