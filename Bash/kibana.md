
# Kibana Documentation

## Links

- <https://medium.com/elasticsearch/introduction-to-elasticsearch-queries-b5ea254bf455>
- <https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html>
- <https://kwan.com/blog/an-introduction-to-query-dsl-creating-queries-in-elasticsearch/>
- <https://elasticsearch-cheatsheet.jolicode.com/>
- <https://medium.com/appscode/deploy-elasticsearch-and-kibana-in-azure-kubernetes-service-using-kubedb-7473b1720dd0>
- <https://cloud.tencent.com/developer/article/1803943>
- <https://www.cnblogs.com/charles101/p/14488609.html>
- <https://www.elastic.co/guide/en/elasticsearch/reference/current/fix-watermark-errors.html>

- `match` is partial
- `match_phrase` is exact
- Software AG DSL does not support `match_phrase`

## Export Logs using Javascript

```javascript
function genKibanaLog() { 
    const t_arr = [...document.querySelectorAll(`td[data-test-subj="docTableField"]`)]
        .map(x => x.innerText.replace(/\\/g, ""));

    const parseDate = (dtStr) => {
        const [dt, ts] = dtStr.split(", "); 
        let [month, day, year] = dt.split(" "); 
        day = day.replace(/th|st|nd|rd/, ""); 
        const res = new Date(`${year} ${month} ${day} ${ts}`);
        return res.toISOString();
    }

    let arr = [];

    for (let ind = 1; ind < t_arr.length; ind += 2) {
        const dt = parseDate(t_arr[ind - 1]);
        const log = t_arr[ind];
        arr.push([dt, log]);
    }

    return arr.map(x => x.join(" ")).reverse().join("\n");
}
genKibanaLog();
```

## Sample Kibana Queries

```json
{
    "query": {
        "simple_query_string": {
            "query": "<query>",
            "default_operator": "AND"
        }
    }
}
```

```json
{
  "query": {
    "query_string": {
      "query": "remote connection",
      "default_field": "log"
    }
  }
}
```

```yaml
start_time: "2024-11-04 10:43:01.641"
end_time: "2024-11-04 10:43:04.539"
```

```json
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "kubernetes.container_name": "<container_name>"
          }
        }
      ],
      "should": [
        {
          "match": {
            "log": "<unique-id>"
          }
        },
        {
          "match": {
            "log": "SQLServerException"
          }
        },
        {
          "match": {
            "log": "ConnectionID:8817"
          }
        }
      ],
      "minimum_should_match": 1
    }
  }
}
```
