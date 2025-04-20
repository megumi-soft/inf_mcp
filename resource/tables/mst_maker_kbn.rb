module Resource
  module Tables
    class MstMakerKbn < FastMcp::Resource
      uri 'file://tables/mst_メーカー区分'
      resource_name 'mst_メーカー区分'
      description 'メーカー区分のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_メーカー区分')
        result.to_a.to_json
      end
    end
  end
end
