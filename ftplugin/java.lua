local home = os.getenv("HOME")
local jdtls = require("jdtls")

-- 1. 自動定位 Mason 安裝的 jdtls 路徑
local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = mason_path .. "/config_linux"


-- 2. 設定 Workspace (每個專案獨立)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.jdtls_workspace/" .. project_name

-- 3. 獲取補全能力
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- 自動使用 Mason 裡的 Lombok
    "-javaagent:" .. mason_path .. "/lombok.jar",

    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew" }),
  capabilities = capabilities,
}

-- 啟動
jdtls.start_or_attach(config)


-- local home = os.getenv("HOME")
-- local jdtls = require("jdtls")
-- 
-- -- Path to your manually extracted JDTLS distribution
-- local jdtls_home = home .. "/jdtls-1.57.0"
-- 
-- -- Create a workspace directory for JDTLS metadata
-- local workspace_dir = home .. "/.jdtls_workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- 
-- -- Specify your desired Lombok version and build the path based on your Maven repository
-- local lombok_version = "1.18.38"
-- local lombok_jar = home .. "/.m2/repository/org/projectlombok/lombok/" ..
--                     lombok_version .. "/lombok-" .. lombok_version .. ".jar"
-- 
-- local config = {
--   cmd = {
--     "java",
--     "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--     "-Dosgi.bundles.defaultStartLevel=4",
--     "-Declipse.product=org.eclipse.jdt.ls.core.product",
--     "-Dlog.protocol=true",
--     "-Dlog.level=ALL",
--     "-Xmx1g",
--     "--add-modules=ALL-SYSTEM",
--     "--add-opens", "java.base/java.util=ALL-UNNAMED",
--     "--add-opens", "java.base/java.lang=ALL-UNNAMED",
-- 
--     -- Attach Lombok as a Java agent
--     "-javaagent:" .. lombok_jar,
--     "--add-opens", "java.base/java.lang.reflect=ALL-UNNAMED",
-- 
--     -- Specify the launcher jar (adjust the version if necessary)
--     "-jar", jdtls_home .. "/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar",
-- 
--     -- Specify the configuration directory (for Linux, for example)
--     "-configuration", jdtls_home .. "/config_linux",
-- 
--     -- Workspace directory; JDTLS stores project-specific data here
--     "-data", workspace_dir,
--   },
-- 
--   -- Determines the project root: you may adjust the markers if needed.
--   root_dir = require("jdtls.setup").find_root({ ".git" }),
-- 
--   -- Attach other plugins or custom behavior here
--   -- on_attach = function(client, bufnr)
--   --   require("nvim-navic").attach(client, bufnr)
--   -- end,
-- }
-- 
-- -- Start or attach JDTLS using your configuration.
-- jdtls.start_or_attach(config)
