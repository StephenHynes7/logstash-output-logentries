# Logentries - Logstash Output Plugin

This is a plugin for [Logentries](https://www.logentries.com) and Logstash. 

# Send logs using token
You can forward logs from Logstash to Legentries using unique token. To do this you have to configure the output sectin of your .conf file in your logstash main folder.

output {
    logentries{
    token => "LOGENTRIES_TOKEN"
    }
}

Please refer to this [blog](link here) for more information and instruction on how to set up your .config file. 

# Legentries Token 

You can find the instructions about Token based input [here](https://logentries.com/doc/input-token/)


## Need Help?

Try #logstash on freenode IRC or the logstash-users@googlegroups.com mailing 
You can also refer to [Logentries DOCs](https://logentries.com/doc/)
