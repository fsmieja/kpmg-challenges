import getmetafunction
import argparse

parser = argparse.ArgumentParser(description='Get instance data as JSON')
args = parser.parse_args()

if __name__ == '__main__':

    res = getmetafunction.process()
    print(res)
