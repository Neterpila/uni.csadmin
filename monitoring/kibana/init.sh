while [ true ]
do
    response_code="$(\
        curl -s -w '%{http_code}' -o /dev/null \
        -X POST \
        -H 'Content-Type: application/json' \
        -H 'kbn-xsrf: true' \
        "http://kibana:5601/api/index_patterns/index_pattern" \
        -d "{\"index_pattern\":{\"title\":\"logstash-*\",\"timeFieldName\":\"@timestamp\"}}"\
    )"
    echo $response_code
    if [ $response_code -eq 200 -o $response_code -eq 400 ]; then
        break
    fi
    sleep 10s
done