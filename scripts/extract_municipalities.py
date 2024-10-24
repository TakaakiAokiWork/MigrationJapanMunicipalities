import requests
import json
import os
import sys

# 市区町村だけをとりだす

# 全国地方公共団体コード
# https://ja.wikipedia.org/wiki/%E5%85%A8%E5%9B%BD%E5%9C%B0%E6%96%B9%E5%85%AC%E5%85%B1%E5%9B%A3%E4%BD%93%E3%82%B3%E3%83%BC%E3%83%89

with open(sys.argv[1]) as f:
    meta = json.load(f)

area_col = [v for v in meta if v["@id"] == "area"][0]

provinces = dict()
code2name = dict() 
for location in area_col["CLASS"]:
    code = location["@code"]
    name = location["@name"]
    province_code = code[:2] 
    minicipacity_code = code[2:] 
    if minicipacity_code == "000":
        provinces[province_code] = name
    code2name[code] = name

# 市区町村だけをとりだす
print("code,name")
for location in area_col["CLASS"]:
    code = location["@code"]
    name = location["@name"]
    province_code = code[:2] 
    municipacity_code = code[2:] 
    if municipacity_code == "000": # 都道府県 skip
        continue
    if municipacity_code == "999" : # その他の市町村 skip
        continue
    if municipacity_code in ["199", "149", "139", "129"] : # その他の区 skip
        continue


    if int(municipacity_code) > 100 and int(municipacity_code) < 200: # 特別区の区域および政令指定都市
        if location["@level"] == "4":
            parent = code2name[location["@parentCode"]]
            print(code,",", provinces[province_code],parent,name,sep="")
    if int(municipacity_code) > 200: # 政令指定都市以外の市, 町村
            print(code,",", provinces[province_code],name,sep="")
        
    
    
