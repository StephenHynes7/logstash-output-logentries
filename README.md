# Logentries - Logstash Output Plugin

This is a plugin for [Logentries](https://www.logentries.com) and Logstash.

# Send logs using token
You can forward logs from Logstash to Logentries using unique token. To do this you have to configure the output sectin of your .conf file in your logstash main folder.

```
output{
    logentries{
    token => "LOGENTRIES_TOKEN"
    reconnect_interval => 10
    ssl_enable => true
    host => "data.logentries.com"
    port => 443
              }
      }
```

Only `token => "LOGENTRIES_TOKEN"` is a required variable, the rest are optional. If you set `ssl_enable` to `false`, you must set the port to `80` or `514`

Please refer to Logstash documentation for more information and instruction on how to set up your .config file.

# Logentries Token

You can find the instructions about Token based input [here](https://logentries.com/doc/input-token/)


## Need Help?

Try #logstash on freenode IRC or the logstash-users@googlegroups.com mailing

You can also refer to [Logentries DOCs](https://logentries.com/doc/)
