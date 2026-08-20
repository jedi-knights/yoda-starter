# yoda-starter

Starter template for [**yoda.nvim**](https://github.com/jedi-knights/yoda.nvim),
an AI-first Neovim distribution.

This repository is the *config* — you clone it into `~/.config/nvim` and own it.
yoda.nvim itself is a plugin, installed and updated by lazy.nvim like any other.
That split means you can update the distribution without your personal
configuration fighting it, and rewind to a released version if an update
misbehaves.

## Requirements

- Neovim **0.10.1+**
- Git
- ripgrep (used by the pickers)
- A [Nerd Font](https://www.nerdfonts.com/) for icons

## Install

Back up anything you already have:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

Then clone this repo (or click **Use this template** on GitHub and clone yours):

```bash
git clone https://github.com/jedi-knights/yoda-starter ~/.config/nvim
rm -rf ~/.config/nvim/.git   # skip this if you cloned your own template copy
nvim
```

First launch bootstraps lazy.nvim and installs everything. Give it a minute.

### Try it without touching your current setup

`NVIM_APPNAME` keeps this entirely separate from `~/.config/nvim`:

```bash
git clone https://github.com/jedi-knights/yoda-starter ~/.config/yoda
NVIM_APPNAME=yoda nvim
```

Delete `~/.config/yoda` and `~/.local/share/yoda` to undo it.

## Layout

```
.
├── init.lua                   # Leader keys, then hands off to lazy
├── lua/
│   ├── config/
│   │   └── lazy.lua           # lazy.nvim bootstrap and options
│   └── plugins/
│       ├── yoda.lua           # yoda.nvim + which language extras you want
│       └── overrides.lua      # your plugins and your overrides
├── stylua.toml
└── LICENSE
```

Two files matter:

- **`lua/plugins/yoda.lua`** — distribution-level configuration. yoda's `opts`,
  and the language extras you opt into.
- **`lua/plugins/overrides.lua`** — everything personal. Add plugins, change
  yoda's, disable yoda's.

## Configure

Everything is optional; yoda's defaults apply to anything you leave out.

```lua
opts = {
  ui         = { show_environment_notification = true },
  large_file = { size_threshold = 100 * 1024 },

  -- Keep yoda's plugins but bring your own options/keymaps/autocmds
  defaults = { options = true, keymaps = true, autocmds = true },
}
```

Run `:help yoda-configuration` for the full schema, and `:checkhealth yoda` if
something looks wrong.

## Language extras

Language stacks are opt-in. `lua/plugins/yoda.lua` ships with Lua enabled and
the rest commented out — uncomment what you use. A Go developer should not pay
startup cost for the Rust toolchain.

| extra | LSP | tests | debug |
|---|---|---|---|
| `lang.lua` | lazydev | — | — |
| `lang.go` | gopls | neotest-golang | nvim-dap-go |
| `lang.node` | ts_ls | jest + vitest | vscode-js-debug |
| `lang.python` | basedpyright | neotest-python | nvim-dap-python |
| `lang.rust` | rust-analyzer | rustaceanvim | rustaceanvim |
| `lang.java` | jdtls¹ | neotest-java | java-debug-adapter |
| `lang.csharp` | omnisharp | neotest-dotnet | netcoredbg |
| `lang.ruby` | ruby-lsp | rspec + minitest | nvim-dap-ruby |
| `lang.vbnet` | omnisharp² | — | netcoredbg |
| `lang.perl` | perlnavigator | — | perl-debug-adapter |
| `lang.ocaml` | ocaml-lsp | — | — |
| `lang.cobol` | cobol_ls | — | — |

A dash means no integration exists for that language, not that it was left
out — there is no neotest adapter for COBOL to ship.

¹ **Java needs one manual step.** jdtls requires a workspace directory and JVM
flags Mason cannot supply, so install it yourself: `brew install jdtls`.
Everything else in the table installs automatically via Mason on first use.

² omnisharp serves both C# and VB.NET. Enabling `lang.csharp` and
`lang.vbnet` together is fine — the shared server and debugger are installed
once.

## Updating

```vim
:Lazy update
```

`lazy-lock.json` in *your* clone pins exact revisions — commit it. To roll back
a bad update, restore the previous lock file and run `:Lazy restore`.

`lua/plugins/yoda.lua` pins `version = "^2.0.0"`, which lazy.nvim reads as
`>=2.0.0 <3.0.0`. You get every fix and feature in the v2 line, but a future
v3.0.0 is not installed until you change that line yourself.

Note that `version = "*"` does **not** do this — it parses to an unbounded
range and will happily install a new major.

## Links

- [yoda.nvim](https://github.com/jedi-knights/yoda.nvim) — the distribution
- [Issues](https://github.com/jedi-knights/yoda.nvim/issues) — report problems
  against yoda.nvim unless they are specific to this template

## License

MIT
