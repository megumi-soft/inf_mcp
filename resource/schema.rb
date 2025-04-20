module Resource
  class Schema < FastMcp::Resource
    uri 'file://schema'
    resource_name 'schema'
    description 'データベースのテーブルとカラム定義の一覧を返す'
    mime_type 'application/json'

    def content
      sql = <<-SQL
      SELECT
          t.name AS table_name,
          c.name AS column_name,
          ty.name AS data_type
      FROM
          sys.tables AS t
      INNER JOIN
          sys.schemas AS s ON t.schema_id = s.schema_id
      INNER JOIN
          sys.columns AS c ON t.object_id = c.object_id
      INNER JOIN
          sys.types AS ty ON c.user_type_id = ty.user_type_id
      ORDER BY
          s.name,
          t.name,
          c.column_id;
      SQL
      Db::Connect.client.execute(sql).to_a.to_json
    end
  end
end
