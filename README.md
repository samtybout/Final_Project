# Analyzing Publication History of Taxonomic Groups in the Paleobiology Database

## Downloading Data

Data can be downloaded using the `load_data` function. Give the function a vector containing the list of taxa
that you want data for. The functions in this script run analyses at the Family level, so all provided taxonomic
names should be at or above the Family level.

```r
data = load_data(c('Lucinidae','Veneridae','Pholadomyidae','Mytilidae','Pectinidae'))
```

This function may take a few seconds to run if you request a lot of data.

The data returned are a data frame of fossil occurences recorded in the Paleobiology Database. For each occurence, 
the frame contains information on:

* its taxonmic identification (principally `accepted_name, species_name, phylum, class, order, family, genus`)
* its geologic age (`early_interval, late_interval, max_ma, min_ma`)
* the publication in which it is described (principally `ref_author, ref_pubyr`)


## Analyzing References

