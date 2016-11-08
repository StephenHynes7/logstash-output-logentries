require "logstash/outputs/base"
require "logstash/namespace"
require "socket"



class LogStash::Outputs::Logentries < LogStash::Outputs::Base
    config_name "logentries"
    milestone 2
    
    # www.logentries.com
    #
    # You will read this token from your config file. Just put the following lines to your .config file:
    #
    # output {
    #     logentries{
    #     token => "LOGENTRIES_TOKEN"
    #               }
    # }
    
    config :token, :validate => :string, :required => true
    
    public
    def register
    end
    
    def receive(event)
        return unless output?(event)
        
        if event == LogStash::SHUTDOWN
            finished
            return
        end
        
        # Open socket
        sock = TCPSocket.new('data.logentries.com', 80)
        
        # Debug
        @logger.info("Sending using #{event.sprintf(@token)} Logentries Token")

        # Prepend the message body with token and write
        sock.write(event.sprintf(@token) + event)
        sock.close
        end

    end # receive
end #LogStash::Outputs::Logentries
