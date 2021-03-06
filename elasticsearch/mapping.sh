curl -XPUT "http://$LOCALIP:9200/_template/person-data" -H 'Content-Type: application/json' -d'
{
  "index_patterns": "person-data-json-*",
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "doc": {
      "properties": {
        "@timestamp": {
          "type": "date"
        },
        "@version": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword",
              "ignore_above": 256
            }
          }
        },
        "env": {
          "properties": {
            "domain": {
              "type": "keyword"
            },
            "physical_environment": {
              "type": "keyword"
            },
            "runtime_enviroment": {
              "type": "keyword"
            }
          }
        },
        "fqdn": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword",
              "ignore_above": 256
            }
          }
        },
        "host": {
          "type": "keyword"
        },
        "ip_address": {
          "type": "ip"
        },
        "offset": {
          "type": "long"
        },
        "person": {
          "properties": {
            "_id": {
              "type": "keyword"
            },
            "about": {
              "type": "text",
              "analyzer": "english"
            },
            "address": {
              "type": "text",
              "analyzer": "english",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "age": {
              "type": "byte"
            },
            "balance": {
              "type": "float"
            },
            "city": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "company": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "email": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "eyeColor": {
              "type": "keyword"
            },
            "favoriteFruit": {
              "type": "keyword"
            },
            "friends": {
              "properties": {
                "id": {
                  "type": "byte"
                },
                "name": {
                  "type": "text",
                  "fields": {
                    "keyword": {
                      "type": "keyword",
                      "ignore_above": 256
                    }
                  }
                }
              }
            },
            "gender": {
              "type": "keyword"
            },
            "gps": {
              "type": "geo_point"
            },
            "greeting": {
              "type": "text",
              "analyzer": "english"
            },
            "guid": {
              "type": "keyword"
            },
            "index": {
              "type": "long"
            },
            "isActive": {
              "type": "boolean"
            },
            "name": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "phone": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "picture": {
              "type": "keyword"
            },
            "street": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "tags": {
              "type": "text"
            },
            "zip": {
              "type": "keyword"
            }
          }
        },
        "pit_codec": {
          "type": "keyword"
        },
        "pit_document_type": {
          "type": "keyword"
        },
        "source": {
          "type": "keyword"
        },
        "tags": {
          "type": "text"
        },
        "timestamp": {
          "properties": {
            "dayOfMonth": {
              "type": "byte"
            },
            "dayOfWeek": {
              "type": "keyword"
            },
            "dayOfYear": {
              "type": "short"
            },
            "hourOfDay": {
              "type": "byte"
            },
            "minuteOfHour": {
              "type": "byte"
            },
            "monthOfYear": {
              "type": "keyword"
            },
            "weekNumber": {
              "type": "byte"
            }
          }
        }
      }
    }
  }
}'