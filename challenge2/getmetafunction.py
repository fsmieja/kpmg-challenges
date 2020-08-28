import sys
sys.path.insert(2, './lib')

import string
import json
import urllib3
from urllib.error import HTTPError


def get_token():
    #print("Opening URL: " + url)
    url = 'http://169.254.169.254/latest/api/token'
    user_agent = 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7 Chrome/41.0.2228.0 Safari/537.3Chrome/41.0.2228.0 Safari/537.3'
    #headers={'User-Agent':user_agent, 'X-aws-ec2-metadata-token-ttl-seconds': 21600}
    headers={'X-aws-ec2-metadata-token-ttl-seconds': '21600'}
    res = []
    try:
        http = urllib3.PoolManager()
        http.headers = headers
        r = http.request('PUT', url)
        token = r.data.decode('utf-8')
    except HTTPError as e:
        print("ERROR getting token from API: Code: %s" % (e.code))
    return token


def fetch_instance_data(token, key):
    url = 'http://169.254.169.254/latest/meta-data/'+key
    headers={'X-aws-ec2-metadata-token': token}
    res = []
    try:
        http = urllib3.PoolManager()
        http.headers = headers
        r = http.request('GET', url)
        list = r.data.decode('utf-8').split('\n')
    except HTTPError as e:
        print("ERROR getting information from API: Code: %s" % (e.code))
        return res
    return list

# this function is used recursively to get through all the sub-meta folders
def add_to_json(token, key, res):

    list = fetch_instance_data(token, key)
    for l in list:
        if l[len(l)-1] == '/':
            k = l[:(len(l)-1)]  # remove the final / when using as json key
            res[k] = {}
            #print("Meta folder: %s (%s)" % (l,k))
            add_to_json(token, key+l, res[k])
        else:
            res[l] = fetch_instance_data(token, key+l)[0]



def process():

    token = get_token()
    print("token = "+token)
    res = {}

    add_to_json(token, '', res)

    return res
