# Logentries - Logstash Plugin

This is a plugin for Logentries [Logentries](https://www.logentries.com).

# Send logs using token
You can forward logs from Logstash to Legentries using unique token. To do this you have to configure the output sectin of your .conf file in your logstash main folder.

output {
    logentries{
    token => "LOGENTRIES_TOKEN"
    }
}


## Need Help?

Need help? Try #logstash on freenode IRC or the logstash-users@googlegroups.com mailing 
