# MigrationJapanMunicipalities
Obtain Migration flow between Japanse  municipalities

# How to use
1. Register the portal site for Japanese Government Statistics (E-stat) and save your API KEY in `.config/e-stat.json' as
```
{
  "APIKEY" : "your api key"
}
```

2. run scripts to obtain data 
```
$make get2021 # download migration data in 2021 from e-etat.go.jp
$make tidy2021 # tidy downloaded migration data and save it in data/2021-migrate.csv
```
see `Makefile` for details.

During the tidy process, some `R` packages are needed, such as `tidyverse`, `ggplot2`, `ggsci`, `scales`.
