
# Kibana Documentation

## Links

- <https://www.tutorialspoint.com/elasticsearch/elasticsearch_query_dsl.htm>

```javascript
function exportObj() { return [...document.querySelectorAll("td.discover-table-datafield")].map(x => x.innerText.replace(/\\/g, "")).reverse().join("\n") } exportObj();
```

```json
{
    "query": {
        "simple_query_string": {
            "query": "7636a330-69e7-4723-a063-0d9071a156de",
            "default_operator": "AND"
        }
    }
}
```

```json
{
    "query": {
        "simple_query_string": {
            "query": "Neix",
            "default_operator": "AND"
        }
    }
}
```

```json
{
    "query": {
        "simple_query_string": {
            "query": "LeadDelegate:2078",
            "default_operator": "AND"
        }
    }
}
```

```json
{
  "query": {
    "match_phrase": {
      "operationName": "/leads"
    }
  }
}
```

```json
{
  "query": {
    "match_phrase": {
      "operationName": "/leads/lead-stage-summary"
    }
  }
}
```
