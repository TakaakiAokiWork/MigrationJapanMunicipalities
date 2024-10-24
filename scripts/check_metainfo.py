import requests
import json
import os
import sys

with open(sys.argv[1]) as f:
    meta = json.load(f)

for item in meta:
    if item["@id"] == "tab": # table info
        continue
    print("column {@id} is {@name}".format(**item) )
    num_values = len(item["CLASS"])
    if isinstance(item["CLASS"], dict):
        print("value = {@code}({@name})".format(**item["CLASS"]) )
    else:
        values = ["{@code}({@name})".format(**v) for v in item["CLASS"][:10] ]
        print("values:", ",".join(values), end="")
    if num_values > 10:
        print(",...",end="")
    print("\n")

