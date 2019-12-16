plot_years = function(pub_data){
  # Plot setup and formatting
  plt = ggplot(data = pub_data)
  plt = plt + theme_minimal()
  # Plot line
  plt = plt + geom_line(aes(x = ref_pubyr, y = spp_cumulative))
  # Axes and title
  plt = plt + xlab("Year") + ylab("Species described")
  plt = plt + ggtitle("Cumulative number of species described per year")
  return(plt)
}
