module Resource::Tables
  class MstMakerKbn < FastMcp::Resource
    uri 'file://tables/mst_maker_kbn'
    resource_name 'mst_maker_kbn'
    description 'メーカー区分のマスタデータテーブル'
    mime_type 'application/json'

    def content
      result = Db::Connect.client.execute('SELECT * FROM mst_メーカー区分')
      result.to_a.to_json
    end
  end
end
