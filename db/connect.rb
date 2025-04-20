require 'tiny_tds'

module Db
  class Connect
    def self.client
      database_url = ENV['DATABASE_URL']
      username = database_url.split(/[:\/@]/)[3]
      password = database_url.split(/[:\/@]/)[4]
      host = database_url.split(/[:\/@]/)[5]
      @client ||= TinyTds::Client.new username:, password:, host:
    end
  end
end
