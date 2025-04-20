module Resource
  module Tables
    class MstCustomerPerson < FastMcp::Resource
      uri 'file://tables/mst_customer_person'
      resource_name 'mst_customer_person'
      description '得意先担当者のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_担当者')
        result.to_a.to_json
      end
    end
  end
end
