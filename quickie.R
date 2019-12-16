quickie = function(taxon, resolution){
  # Download data
  data = load_data(taxon)
  # Count new species
  refs = count_new(data, taxon, resolution = resolution)
  # Plot new species
  plot_pubs(refs)
}
