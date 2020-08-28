import string
import json

def get_value(obj, key):

    res = {"obj": obj, "key": key}
    jobj = json.loads(obj)
    if not '/' in key:
        if key in jobj:
            res['value'] = jobj[key]
            return res
        else:
            res['value'] = 'not found'
            return res
    keys = key.strip(' /').split('/')
    o = jobj
    for k in keys:
        if k in o:
            o = o[k]
        else:
            res['value'] = 'not found'
            return res
    res['value'] = o
    return res

    #print(res)
    return res
