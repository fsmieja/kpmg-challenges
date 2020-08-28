#!/usr/bin/env bash

echo "Test 1 : object = '{\"a\":{\"b\":{\"c\":\"d\"}}}', key = 'a/b/c'"
python3 keyvalue.py -k a/b/c '{"a":{"b":{"c":"d"}}}'
echo "================================"
echo "Test 2 : object = '{\"dog\":{\"color\": \"brown\", \"skills\": {\"climbing\": \"good\", \"fetching\": \"excellent\", \"running\": \"fast\"}}', key = 'dog/skills'"
python3 keyvalue.py -k dog/skills '{"dog":{"color": "brown", "skills": {"climbing": "good", "fetching": "excellent", "running": "fast"}}}'

echo "================================"
echo "Test 3 : object = '{\"dog\":{\"color\": \"brown\", \"skills\": {\"climbing\": \"good\", \"fetching\": \"excellent\", \"running\": \"fast\"}}', key = 'dog/skills/fetching'"
python3 keyvalue.py -k dog/skills/fetching '{"dog":{"color": "brown", "skills": {"climbing": "good", "fetching": "excellent", "running": "fast"}}}'

echo "================================"
echo "Test 4 (negative) : object = '{\"dog\":{\"color\": \"brown\", \"skills\": {\"climbing\": \"good\", \"fetching\": \"excellent\", \"running\": \"fast\"}}', key = 'dog/skills/eating'"
python3 keyvalue.py -k dog/skills/eating '{"dog":{"color": "brown", "skills": {"climbing": "good", "fetching": "excellent", "running": "fast"}}}'
