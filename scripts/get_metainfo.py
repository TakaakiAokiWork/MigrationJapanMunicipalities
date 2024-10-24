import requests
import json
import os
import sys

with open( os.environ['HOME'] + "/.config/e-stat.json") as w:
    app_id = json.load(w)["app_id"]

stats_data_id = sys.argv[1] # "0003448458"  住民基本台帳人口移動報告 (2021)

# メタ情報取得のURL
url = 'https://api.e-stat.go.jp/rest/3.0/app/json/getMetaInfo?'
url += 'appId={0:s}&'.format(app_id) 
url += 'statsDataId={0:s}&'.format(stats_data_id)
url += 'explanationGetFlg=N&'   # 解説情報有無：無し

# メタ情報取得
res = requests.get(url).json()
print("Status code is", res['GET_META_INFO']["RESULT"], file=sys.stderr)

# メタ情報から各表のCLASS(行や列)を抽出
class_objs = res['GET_META_INFO']['METADATA_INF']['CLASS_INF']['CLASS_OBJ']
print(json.dumps(class_objs, indent=2, ensure_ascii=False))

