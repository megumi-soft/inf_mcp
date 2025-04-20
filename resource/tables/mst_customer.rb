module Resource
  module Tables
    class MstCustomer < FastMcp::Resource
      uri 'file://tables/mst_得意先'
      resource_name 'mst_得意先'
      description '得意先のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_得意先')
        result.to_a.to_json
      end
    end
  end
end
