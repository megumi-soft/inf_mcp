module Resource::Tables
  class MstArea < FastMcp::Resource
    uri 'file://tables/mst_area'
    resource_name 'mst_area'
    description 'エリアのマスタデータテーブル'
    mime_type 'application/json'

    def content
      result = Db::Connect.client.execute('SELECT * FROM mst_area')
      result.to_a.to_json
    end
  end
end
