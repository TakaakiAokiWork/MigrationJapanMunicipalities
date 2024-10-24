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
$make all
```
see `Makefile` for details.
