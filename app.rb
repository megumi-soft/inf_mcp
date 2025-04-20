# app.rb ── Heroku / ローカル共通エントリポイント
require 'dotenv/load' if File.exist?('.env')
require 'bundler/setup'
require 'fast_mcp'
require 'rack'
require 'rack/handler/puma'
require 'logger'

# --- ここから自前のファイル群を読み込み ----------------------------
require_relative 'db/connect'
require_relative 'resource/tables/mst_area'
require_relative 'resource/tables/mst_customer_person'
require_relative 'resource/tables/mst_customer'
require_relative 'resource/tables/mst_maker_kbn'
require_relative 'resource/tables/mst_staff'
require_relative 'resource/tables/mst_shohin'
require_relative 'resource/tables/mst_shohin_kbn'
require_relative 'resource/schema'
require_relative 'tools/sql_select'
# ---------------------------------------------------------------------

# シンプルな Rack アプリ
app = ->(_env) {
  [200, { 'Content-Type' => 'text/html' },
   ['<html><body><h1>Hello from Rack!</h1><p>This is a simple Rack app with MCP middleware.</p></body></html>']]
}

# MCP ミドルウェアを組み込む
mcp_app = FastMcp.rack_middleware(
  app,
  name:    'inforce-mcp-server',
  version: '1.0.0',
  logger:  Logger.new($stdout)
) do |server|
  server.register_tool(Tools::SqlSelect)

  server.register_resource(Resource::Tables::MstArea)
  server.register_resource(Resource::Tables::MstMakerKbn)
  server.register_resource(Resource::Tables::MstStaff)
  server.register_resource(Resource::Tables::MstShohin)
  server.register_resource(Resource::Tables::MstShohinKbn)
  server.register_resource(Resource::Tables::MstCustomer)
  server.register_resource(Resource::Tables::MstCustomerPerson)
  server.register_resource(Resource::Schema)
end

# ---------------- Puma 起動設定 ----------------
# Heroku では ENV['PORT'] が必ず渡される。ローカルでは 9292 を既定値に
port = Integer(ENV.fetch('PORT', 9292))

puts "==> Booting (PID: #{Process.pid}) on 0.0.0.0:#{port}"
puts "==> MCP endpoints:"
puts "    • http://localhost:#{port}/mcp/sse"
puts "    • http://localhost:#{port}/mcp/messages"
puts "Press Ctrl+C to stop"

Rack::Handler::Puma.run(
  mcp_app,
  Host: '0.0.0.0',  # must bind to all interfaces on Heroku
  Port: port,
  Threads: "0:5"    # Heroku の free dyno でも無難に動く範囲
)
