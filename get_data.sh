# Downloads data from the Paleobiology Database for the requested taxonomic group.

# Usage: bash get_data Taxon_name
# Products: pbdb_data.csv, a csv file containing occurences in the Paleobiology Database of the requested group.
# For each variable, the file contains data on its taxonmic identification,
# its geologic age, and the publication in which the occurence is described.

wget -O "pbdb_data.csv" "http://www.paleobiodb.org/data1.2/occs/list.csv?datainfo&rowcount&base_name=$1&taxon_reso=species&idspcmod=!ng,af,cf,sl,if,eg,qm,qu&show=ident,class,refattr,acconly"