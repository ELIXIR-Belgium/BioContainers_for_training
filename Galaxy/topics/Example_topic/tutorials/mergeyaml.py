#!/usr/bin/env python

import glob
import yaml


def extend_dict(merged, a):
    if isinstance(merged, dict):
        for k, v in a.items():
            if k in merged:
                extend_dict(merged[k], v)
            else:
                merged[k] = v
    elif isinstance(merged, list):
        extend_list(merged, a)


def extend_list(merged, a):
    missing = []
    for itemm in merged:
        for itema in a:
            if itemm['name'] == itema['name']:
                extend_dict(itemm, itema)
            else:
                missing += [itema, ]
    merged += missing


merged = {}

for filename in glob.iglob('./**/data-library.yaml'):
    a = yaml.load(open(filename))
    extend_dict(merged, a)


print(yaml.dump(merged, default_flow_style=False, default_style=''))
