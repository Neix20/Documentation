
# Get Elastic Search Version
curl localhost:9200

{
  "name" : "bNlnWtl",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "TPA7pDPYQvG9LDsi_oVJQA",
  "version" : {
    "number" : "6.8.4",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "bca0c8d",
    "build_date" : "2019-10-16T06:19:49.319352Z",
    "build_snapshot" : false,
    "lucene_version" : "7.7.2",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}

# Get Kibana Version
curl -X GET "localhost:5601/api/status" -H 'kbn-xsrf: true'

{
  "name": "kibana-server",
  "uuid": "abcd1234-ef56-7890-gh12-ijklmnop3456",
  "version": {
    "number": "7.10.0",
    "build_snapshot": false,
    "build_number": 36136,
    "build_hash": "7ff72a99"
  },
  ...
}
