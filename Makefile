
#  Stat IDs of migration in e-stat.go.jp
statDataID2021 = 0003448458
statDataID2020 = 0003420493
statDataID2019 = 0003413173
statDataID2018 = 0003283015
statDataID2017 = 0003213995
statDataID2016 = 0003159820
statDataID2015 = 0003150940
statDataID2014 = 0003146921
statDataID2013 = 0003149520
statDataID2012 = 0003150300

#overlook:
#	mkdir -p tmp
#	Rscript scripts/overlook-data.R $(data)/2021-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2020-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2019-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2018-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2017-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2016-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2015-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2014-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2013-migrate.csv
#	Rscript scripts/overlook-data.R $(data)/2012-migrate.csv

define tidy_data
	python scripts/check_metainfo.py tmp-dl/$(1).meta 
	python scripts/extract_municipalities.py tmp-dl/$(1).meta > tmp-dl/$(1).municipacity.csv
	python scripts/replace_code_by_text.py tmp-dl/$(1).meta tmp-dl/$(1).csv > tmp-dl/$(1)-uncode.csv
	Rscript scripts/rename.R tmp-dl/$(1)-uncode.csv tmp-dl/$(1)-renamed.csv
	Rscript scripts/filter-between-municipalities.R tmp-dl/$(1)-renamed.csv tmp-dl/$(1).municipacity.csv tmp-dl/$(1)-filtered.csv
	cp tmp-dl/$(1)-filtered.csv $(data)/$(1)-migrate.csv
endef


tidy_data_all: tidy2017 tidy2018 tidy2019 tidy2020 tidy2021

setup:
	mkdir -p data
	mkdir -p tmp-dl/

get2021:
	python scripts/get_metainfo.py $(statDataID2021) > tmp-dl/2021.meta
	python scripts/get_data.py $(statDataID2021) > tmp-dl/2021.csv
tidy2021:
	$(call tidy_data,2021)

get2020:
	python scripts/get_metainfo.py $(statDataID2020) > tmp-dl/2020.meta
	python scripts/get_data.py $(statDataID2020) > tmp-dl/2020.csv
tidy2020:
	$(call tidy_data,2020)

get2019:
	python scripts/get_metainfo.py $(statDataID2019) > tmp-dl/2019.meta
	python scripts/get_data.py $(statDataID2019) > tmp-dl/2019.csv
tidy2019:
	$(call tidy_data,2019)

get2018:
	python scripts/get_metainfo.py $(statDataID2018) > tmp-dl/2018.meta
	python scripts/get_data.py $(statDataID2018) > tmp-dl/2018.csv
tidy2018:
	$(call tidy_data,2018)

get2017:
	python scripts/get_metainfo.py $(statDataID2017) > tmp-dl/2017.meta
	python scripts/get_data.py $(statDataID2017) > tmp-dl/2017.csv
tidy2017:
	$(call tidy_data,2017)

get2016:
	mkdir -p tmp-dl/
	python scripts/get_data.py $(statDataID2016) > tmp-dl/2016.csv
tidy2016:
	$(call tidy_data,2016)

get2015:
	python scripts/get_metainfo.py $(statDataID2015) > tmp-dl/2015.meta
	python scripts/get_data.py $(statDataID2015) > tmp-dl/2015.csv
tidy2015:
	$(call tidy_data,2015)

get2014:
	python scripts/get_metainfo.py $(statDataID2014) > tmp-dl/2014.meta
	python scripts/get_data.py $(statDataID2014) > tmp-dl/2014.csv
tidy2014:
	$(call tidy_data,2014)

get2013:
	python scripts/get_metainfo.py $(statDataID2013) > tmp-dl/2013.meta
	python scripts/get_data.py $(statDataID2013) > tmp-dl/2013.csv
tidy2013:
	$(call tidy_data,2013)

get2012:
	python scripts/get_metainfo.py $(statDataID2012) > tmp-dl/2012.meta
	python scripts/get_data.py $(statDataID2012) > tmp-dl/2012.csv
tidy2012:
	$(call tidy_data,2012)