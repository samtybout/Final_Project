load_data = function(taxon_names){
  taxon_names = paste(taxon_names, collapse = ',')
  # Generate database query URL
  url = paste0("http://www.paleobiodb.org/data1.2/occs/list.csv?&base_name=",taxon_names,"&taxon_reso=species&idspcmod=!ng,af,cf,sl,if,eg,qm,qu&show=ident,class,refattr,acconly")
  # Download data
  data = read.csv(url, header = TRUE)
  # Remove all entries where publication year is missing
  data = data[!is.na(data$ref_pubyr),]
  # Sort data by publication year
  data = data[order(data$ref_pubyr),]
  return(data)
}