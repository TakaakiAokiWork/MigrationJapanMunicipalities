# MigrationJapanMunicipalities
Obtain Migration flow between Japanse municipalities

[住民基本台帳人口移動報告 / 参考表　2018年～　（年齢（10歳階級），男女，転入・転出市区町村別結果（移動者（外国人含む））](https://www.e-stat.go.jp/stat-search/database?page=1&layout=dataset&data=1&metadata=1&query=%E4%BD%8F%E6%B0%91%E5%9F%BA%E6%9C%AC%E5%8F%B0%E5%B8%B3%E4%BA%BA%E5%8F%A3%E7%A7%BB%E5%8B%95%E5%A0%B1%E5%91%8A%20%E5%8F%82%E8%80%83%E8%A1%A8%E3%80%802018%E5%B9%B4&statdisp_id=0004014380)

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
