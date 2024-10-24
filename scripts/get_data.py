import requests
import json
import os
import pandas as pd
import sys

with open( os.environ['HOME'] + "/.config/e-stat.json") as w:
    app_id = json.load(w)["app_id"]

stats_data_id = sys.argv[1] # "0003448458"  住民基本台帳人口移動報告 (2021)

# 統計データ取得のURL
def make_url(startPosition = 1):
    url = 'https://api.e-stat.go.jp/rest/3.0/app/json/getStatsData?'
    url += 'appId={0:s}&'.format(app_id) 
    url += 'statsDataId={0:s}&'.format(stats_data_id)
    url += 'metaGetFlg=N&'          # メタ情報有無
    url += 'explanationGetFlg=N&'   # 解説情報有無
    url += 'annotationGetFlg=N&'    # 注釈情報有無
    url += 'limit={0:s}&'.format(str(10*10000))    # データ取得件数
    url += 'startPosition={0:s}&'.format(str(startPosition))    # 
    return(url)
# Q7 : 【統計データ取得機能】10万件を超えるデータを取得できません。
# A7 : API機能は、一度に最大で10万件のデータを返却します。そのため、統計データが一度に取得できない場合には、継続データの取得開始位置をレスポンスの<NEXT_KEY>タグの値として出力します。継続データを要求する場合は、データ取得開始位置パラメータ(startPosition)にこの値を指定することで、取得できます。


step = 0
startPosition = 1
df = pd.DataFrame()
while(True):
    # 統計データ取得
    res = requests.get(make_url(startPosition)).json()
    print("Status code is", res['GET_STATS_DATA']["RESULT"], file=sys.stderr)

    print("Got {FROM_NUMBER} to {TO_NUMBER}, total = {TOTAL_NUMBER}".format(**res['GET_STATS_DATA']['STATISTICAL_DATA']['RESULT_INF']), file=sys.stderr)

    # 統計データからデータ部取得
    values = res['GET_STATS_DATA']['STATISTICAL_DATA']['DATA_INF']['VALUE']
    
    # jsonからDataFrameを作成
    tmpdf = pd.DataFrame(values)
    print(tmpdf, file=sys.stderr)
    df = pd.concat([df,tmpdf])
    
    # update startPosition for next 
    if "NEXT_KEY" in res['GET_STATS_DATA']['STATISTICAL_DATA']['RESULT_INF']:
        startPosition = res['GET_STATS_DATA']['STATISTICAL_DATA']['RESULT_INF']['NEXT_KEY']
    else:
        break


df.to_csv(sys.stdout,index=None)
