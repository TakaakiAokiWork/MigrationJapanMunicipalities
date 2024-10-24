import sys
import json
import pandas as pd

with open(sys.argv[1]) as f:
    meta = json.load(f)

code2text = dict()
for item in meta:
    column = item["@id"]
    if column not in ["cat02","cat03"]:
        continue

    code2text[column] = dict()
    for v in item["CLASS"]:
        code2text[column][v["@code"] ] = v["@name"]

print(code2text,file=sys.stderr)

# replace code by text
data_dict = pd.read_csv(sys.argv[2], dtype=str).to_dict(orient="dict")
for column, codemap in code2text.items():
    colname = "@" + column
    data_dict[colname].update( (k, codemap[v]) for k,v in data_dict[colname].items() )

pd.DataFrame(data_dict).to_csv(sys.stdout, index=None)
