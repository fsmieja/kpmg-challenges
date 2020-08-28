import keyvaluefunction
#import sys
import argparse

parser = argparse.ArgumentParser(description='Return value of key for object')
parser.add_argument("-key",
                    help="The key (use form 'key1/key2/...' to indicate sub-levels of keys)", default="")
parser.add_argument('object', help="The object to get the key-value from, in json format")
args = parser.parse_args()

obj = args.object
key = args.key
res = {}

if __name__ == '__main__':

    res = keyvaluefunction.get_value(obj, key)
    print("Key '%s' of object '%s' has value '%s'" % (res['key'], res['obj'], res['value']))
