module Resource
  module Tables
    class MstCustomer < FastMcp::Resource
      uri 'file://tables/mst_customer'
      resource_name 'mst_customer'
      description '得意先のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_得意先')
        result.to_a.to_json
      end
    end
  end
end
