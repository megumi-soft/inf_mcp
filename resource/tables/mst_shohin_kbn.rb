module Resource
  module Tables
    class MstShohinKbn < FastMcp::Resource
      uri 'file://tables/mst_shohin_kbn'
      resource_name 'mst_shohin_kbn'
      description '商品区分のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_商品区分')
        result.to_a.to_json
      end
    end
  end
end
