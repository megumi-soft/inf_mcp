# インフォース MCP Server

## 開発

### 環境設定
- Ruby on rbenv
  - $ rbenv install {version}
  - $ bundle install
- Node.js
  - $ npm install


### 起動

```bash
bundle exec ruby app.rb
npx @modelcontextprotocol/inspector http://localhost:9292/mcp/sse
```

## データベース

.env にデータベースの接続情報を記載してください。

```
DATABASE_URL=mssql://user:password@localhost:5432/dbname
```

## サーバ

- 開発
  - http://localhost:9292/mcp/sse
- 本番
