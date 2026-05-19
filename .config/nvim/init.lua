require("config.options")
require("config.keymaps")
require("config.lazy")

-- Load dynamic colors from Matugen if they exist
pcall(require, "config.matugen")
