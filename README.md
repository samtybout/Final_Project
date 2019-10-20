# Final Project

## Proposal

### Objectives
I will create a script which analyzes how well-studied a group of fossil organisms is using data from the [Paleobiology Database](https://paleobiodb.org/). The goal is to quantify the research effort for a clade in the database to aid in detecting sampling bias. The idea here is to generate collector curves, as is done in ecological sampling, but with each sample being a paper describing taxa from the relevant group.

### Data Sources
All data are downloaded from the [Paleobiology Database](https://paleobiodb.org/), which is a free, public source. Each entry is a fossil occurence. The pertinent attributes for this project would be the reference, reference year, and taxonomy for each entry.

### Languages used
I will be putting this together in R. I intend to use the [PaleobioDB](https://github.com/ropensci/paleobioDB) package to download the data, run the analysis with my own code, and plot the results with [ggplot](https://ggplot2.tidyverse.org/).

### Expected Products
I will produce an R script that can download, analyze, and plot the results for any clade specified by the user.

This is a great product.  Would you consider making an R-Shiny application that allows others without R experience to plot the results?  Or if you plan to publish results, perhaps you would like to add a Latex manuscript? Based on what you showed me at the beginning of the semester, it looked like you had most of the skills to complete this prior to enrolling in my course(!) - consider what new tools you might want to learn and add them.
