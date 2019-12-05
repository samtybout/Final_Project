# Analyzing Publication History of Taxonomic Groups in the Paleobiology Database

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


## Analyzing References

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
count_new(data = data, taxon = "Mytilidae", resolution = "family")
```

Count everything in the genus _Mytilus_, excluding publications where it doesn't appear:
```r
count_new(data = data, taxon = "Mytilus", resolution = "genus", include_non_member = FALSE)
```