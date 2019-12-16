year_sub = function(yeardata){
  # This is a helper function for year_sub which analyzes all the publications from a specific year
  output = data.frame(new_spp = sum(yeardata$new_spp))
  output$n_pubs = nrow(yeardata)
  output$ref_pubyr = yeardata[1,]$ref_pubyr
  return(output)
}

year_count = function(pubs){
  # Split the references by year of publication
  year_list = split(pubs, pubs$ref_pubyr)
  # Count the number of references and observed species in each year
  spp_count = lapply(year_list, year_sub)
  output = do.call(rbind, spp_count)
  
  # This part adds the empty rows for years where no relevant papers were published
  year_range = min(pubs$ref_pubyr):max(pubs$ref_pubyr)
  pub_years = pubs$ref_pubyr
  missing_years = year_range[!(year_range %in% pub_years)]
  gapfill = data.frame(ref_pubyr = missing_years, new_spp = 0, n_pubs = 0)
  output = rbind(output, gapfill)
  output = output[order(output$ref_pubyr),]
  
  # Count the cumulative number of species described after each year
  output$spp_cumulative = cumsum(output$new_spp)
  rownames(output) = NULL
  return(output)
}