module Tools
  class SqlSelect < FastMcp::Tool
    description 'SQLを実行する'

    arguments do
      required(:sql).filled(:string).description('SQL')
    end

    def call(sql:)
      # SELECTから始まっていないSQLの場合はエラー
      unless sql.start_with?('SELECT')
        return { status: 'error', message: 'SQL must start with SELECT' }.to_json
      end

      Db::Connect.client.execute(sql).to_a.to_json
    end
  end
end
