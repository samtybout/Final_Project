plot_pubs = function(pub_data, labels = FALSE, q = 0.99){
  # Plot setup and formatting
  n = 1:nrow(pub_data)
  plt = ggplot(data = pub_data)
  plt = plt + theme_minimal()
  # Plot line
  plt = plt + geom_line(aes(x = n, y = spp_cumulative))
  # Axes and title
  plt = plt + xlab("Number of publications") + ylab("Species described")
  plt = plt + ggtitle("Cumulative number of species described per publication")
  # Add labels for publications that describe many new species
  if(labels){
    is.outlier = pub_data$new_spp > quantile(pub_data$new_spp, q)
    pub_data$name = paste(pub_data$ref_author, pub_data$ref_pubyr)
    pub_data$name[!is.outlier] = ""
    plt = plt + geom_text(aes(x = n, y = pub_data$spp_cumulative-pub_data$new_spp/2, label = pub_data$name),
                          color = "blue")
  }
  return(plt)
}