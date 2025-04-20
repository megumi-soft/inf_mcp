module Resource
  module Tables
    class MstShohin < FastMcp::Resource
      uri 'file://tables/mst_shohin'
      resource_name 'mst_shohin'
      description '商品のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_商品')
        result.to_a.to_json
      end
    end
  end
end
