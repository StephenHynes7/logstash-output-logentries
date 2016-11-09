# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "logstash/codecs/plain"
require "socket"

# www.logentries.com
#
# Write events over TCP socket. Each event json is separated by a newline.
#
# You will read this token from your config file. Just put the following lines to your .config file:
#
# output{
#     logentries{
#     token => "LOGENTRIES_TOKEN"
#     reconnect_interval => 10
#     ssl_enable => true
#     host => "data.logentries.com"
#     port => 443
#               }
#       }

class LogStash::Outputs::Logentries < LogStash::Outputs::Base
  config_name "logentries"

  config :token, :validate => :string, :required => true

  config :reconnect_interval, :validate => :number, :default => 10
  config :ssl_enable, :validate => :boolean, :default => true

  config :host, :validate => :string, :default => "data.logentries.com"
  config :port, :validate => :number, :default => 443

  def register
    @client_socket = nil

    if ssl?
      @ssl_context = setup_ssl
    end
  end

  def receive(event)
    message = event.to_json

    begin
      @client_socket ||= connect
      @client_socket.puts("#{@token}" + message)
    rescue => e
      @logger.warn("Socket output exception: closing and resending event", :host => @host, :port => @port, :exception => e, :backtrace => e.backtrace, :event => event)
      @client_socket.close rescue nil
      @client_socket = nil
      sleep(@reconnect_interval)
      retry
    end
  end

  private

  def ssl?
    @ssl_enable == true
  end

  def connect
    socket = nil
    socket = TCPSocket.new(@host, @port)
    if ssl?
      socket = OpenSSL::SSL::SSLSocket.new(socket, @ssl_context)
      begin
        socket.connect
      rescue OpenSSL::SSL::SSLError => ssle
        @logger.error("SSL Error", :exception => ssle, :backtrace => ssle.backtrace)
        sleep(5)
        raise
      end
    end
    socket
  end

  def setup_ssl
    require "openssl"
    cert_store = OpenSSL::X509::Store.new
    cert_store.set_default_paths
    ssl_context = OpenSSL::SSL::SSLContext.new()
    ssl_context.cert_store = cert_store
    ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
    ssl_context
  end
end #LogStash::Outputs::Logentries
