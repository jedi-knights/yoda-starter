-- lua/plugins/yoda.lua
-- yoda.nvim itself, plus the language extras you want.
--
-- This is the file to edit for distribution-level configuration. Personal
-- plugins and per-plugin overrides belong in overrides.lua.

return {
  {
    "jedi-knights/yoda.nvim",

    -- Pin to the v2 major. lazy.nvim parses "^2.0.0" as >=2.0.0 <3.0.0, so
    -- you get every fix and feature in v2 but never an unannounced breaking
    -- change; moving to v3 is a deliberate edit here.
    --
    -- NOT `version = "*"` -- that parses to an unbounded range starting at
    -- 0.0.0 and matches ANY release, majors included, which is the opposite
    -- of what a pin is for.
    version = "^2.0.0",

    -- Pulls in yoda's core plugin specs. Without this you get the yoda Lua
    -- modules but none of the plugins the distribution is built from.
    import = "yoda.plugins",

    -- Loaded eagerly and early: setup() installs options, keymaps and
    -- autocmds that the rest of the session assumes are already in place.
    lazy = false,
    priority = 10000,

    -- Everything here is optional — the defaults in yoda's config.lua apply
    -- for anything you leave out. See `:help yoda-configuration`.
    opts = {
      ui = {
        show_environment_notification = true,
      },

      -- Escape hatches. Set any of these false to keep yoda's plugins but
      -- supply your own options / keymaps / autocmds.
      defaults = {
        options = true,
        keymaps = true,
        autocmds = true,
      },
    },

    -- Options must be applied before lazy sources the plugins they affect,
    -- which is earlier than `config` runs. apply() is idempotent, so setup()
    -- re-applying below is a no-op.
    init = function()
      require("yoda.options").apply()
    end,

    config = function(_, opts)
      require("yoda").setup(opts)
    end,
  },

  -- ── Language extras ────────────────────────────────────────────────────
  -- Uncomment the stacks you use. Nothing here is required; yoda's core
  -- works with none of them enabled, and each one you leave commented is
  -- startup time you do not pay.
  --
  -- Full stacks -- language server, test runner and debugger:
  { import = "yoda.extras.lang.lua" },
  -- { import = "yoda.extras.lang.go" },
  -- { import = "yoda.extras.lang.node" },
  -- { import = "yoda.extras.lang.python" },
  -- { import = "yoda.extras.lang.rust" },
  -- { import = "yoda.extras.lang.java" },    -- jdtls must be installed
  --                                          -- separately: brew install jdtls
  -- { import = "yoda.extras.lang.csharp" },
  -- { import = "yoda.extras.lang.ruby" },
  --
  -- Language server and debugger, but no test integration -- no neotest
  -- adapter exists for these languages:
  -- { import = "yoda.extras.lang.vbnet" },
  -- { import = "yoda.extras.lang.perl" },
  --
  -- Language server only -- no test or debug adapter exists:
  -- { import = "yoda.extras.lang.ocaml" },
  -- { import = "yoda.extras.lang.cobol" },
}
