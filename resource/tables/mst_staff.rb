module Resource
  module Tables
    class MstStaff < FastMcp::Resource
      uri 'file://tables/mst_staff'
      resource_name 'mst_staff'
      description '従業員のマスタデータテーブル'
      mime_type 'application/json'

      def content
        result = Db::Connect.client.execute('SELECT * FROM mst_staff')
        result.to_a.to_json
      end
    end
  end
end
