# Analyzing Publication History of Taxonomic Groups in the Paleobiology Database

This project analyzes how well-studied a group of fossil organisms is using data from the [Paleobiology Database](https://paleobiodb.org/). The goal is to quantify the research effort for a clade in the database to aid in detecting sampling bias. The idea here is to generate collector curves, as is done in ecological sampling, but with each sample being a paper describing taxa from the relevant group.


## Getting Started

To load everything up, run `All_Functions.R`.

```r
source("All_Functions.R")
```

## Quick Version

If you want to run a quick analysis of one taxonomic group, you can do that with the `quickie` function. This will output a plot of the cumulative number of species described across the publications in the Paleobiology Database.

The arguments to `quickie` should be the name of a taxonomic group, and the rank of that group (e.g. `"Homo", "genus"` or `"sapiens", "species"`):

```r
quickie("Veneridae", "family")
```

## Downloading Data

Data can be downloaded using the `load_data` function. Give the function a vector containing the list of taxa
that you want data for.

```r
data = load_data(c('Lucinidae','Veneridae','Pholadomyidae','Mytilidae','Pectinidae'))
```

This function may take a while to run if you request a lot of data.

The data returned are a data frame of fossil occurences recorded in the Paleobiology Database. For each occurence, 
the frame contains information on:

* its taxonmic identification (principally `accepted_name, species_name, phylum, class, order, family, genus`)
* its geologic age (`early_interval, late_interval, max_ma, min_ma`)
* the publication in which it is described (principally `ref_author, ref_pubyr`)


## Analyzing references

### Counting species described per reference

The next step is to generate a count of new species described per reference. This is done with `count_new`.
`count_new` takes up to four arguments:

* `data`: a set of occurences from the Paleobiology Database, as produced by `load_data`
* `taxon`: The name of the taxon you want to analyze. If no name is given, `count_new` will count every species in the dataset, ignoring the other arguments.
* `resolution`: The taxonomic level of the name given in `taxon`. For example, if `taxon = "Mollusca"`, then `resolution` should be `"phylum"`. The possible levels are:
  * `"phylum"`
  * `"class"`
  * `"family"`
  * `"genus"`
  * `"species_name"`
  * `"primary_name"` (Typically synonymous with genus)
  * `"accepted_name"` (Genus and species, e.g. `"Homo sapiens"`)
  
  `resolution` is set to `"family"` by default.
* `include_non_member`: This is a `TRUE` or `FALSE` value which determines whether or not to include publications in the analysis which do not describe any members of `taxon`. Set to `TRUE` by default.

Here are some examples:

Count everything in the family Mytilidae:
```r
mytilidae = count_new(data = data, taxon = "Mytilidae", resolution = "family")
```

Count everything in the genus _Mytilus_, excluding publications where it doesn't appear:
```r
mytilus = count_new(data = data, taxon = "Mytilus", resolution = "genus", include_non_member = FALSE)
```

### Counting species described per year

You can also group publications by year and count species described over time.

First, organize the data by publication using `count_new`, as above:

```r
mytilidae = count_new(data = data, taxon = "Mytilidae", resolution = "family")
```

Then, run `year_count` on the result:

```r
mytilidae_yearly = year_count(mytilidae)
```

## Plotting 
Insert images for each plot for a more awesome readme.md

After you've generated these counts, you can visualize them with the plotting functions.

`plot_pubs` works on data generated by `count_new`:

```r
plot_pubs(count_new(data = data, taxon = "Mytilidae", resolution = "family"))
```

You can also label important publications on the plot by `labels = TRUE`. This will pick out the publications from your data that described the most new species.

```r
plot_pubs(count_new(data = data, taxon = "Mytilidae", resolution = "family"), labels = TRUE)
```

The function chooses which publications are important by looking at their quantile of species described. By default, it labels publications that described more species than 99% of the publications in the data. The quantile can be changed with the `q` parameter.

Only the top 99.5%:
```r
plot_pubs(count_new(data = data, taxon = "Mytilidae", resolution = "family"), labels = TRUE, q = 0.995)
```

All publications (this is a mess):
```r
plot_pubs(count_new(data = data, taxon = "Mytilidae", resolution = "family"), labels = TRUE, q = 0)
```

You can also plot species described per year by passing the output of `year_count` to `plot_years`:

```r
plot_years(year_count(count_new(data = data, taxon = "Mytilidae", resolution = "family")))
```

## Additional tips

If you want to know more about a publication in your dataset, you can find its Reference Number under the variable `reference_no` and look it up in the Paleobiology Database [here](https://paleobiodb.org/classic/displaySearchRefs?type=view).

If you're having trouble downloading an especially large dataset, or if you want to store a local copy of the occurecne data, I've included a bash script (`get_data.sh`) that does that. You can call it from bash, supplying the taxonomic groups you want as a comma-separated list (no spaces), like so:

```bash
bash get_data.sh Mytilidae,Veneridae
```

The script will save the data to a file called `pbdb_data.csv`. Then you can load the data into R with the `read.csv` function:

```r
library(readr)
data = read.csv("pbdb_data.csv", header = TRUE)
```
