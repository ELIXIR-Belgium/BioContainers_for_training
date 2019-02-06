#!/usr/bin/env python3

import glob
import yaml


def extend_dict(extend_me, extend_by):
    if isinstance(extend_by, dict):
        for k, v in extend_by.items():
            if k in extend_me:
                extend_dict(extend_me.get(k), v)
            else:
                extend_me[k] = v
    else:
        extend_me += extend_by

merged = {}

for filename in glob.iglob('./**/data-library.yaml'):
    a = yaml.load(open(filename))
    extend_dict(merged, a)


print(yaml.dump( merged, default_flow_style=False, default_style='' ))


