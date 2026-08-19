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
the rest commented out — uncomment what you use:

```lua
{ import = "yoda.extras.lang.lua" },
{ import = "yoda.extras.lang.go" },
{ import = "yoda.extras.lang.node" },
{ import = "yoda.extras.lang.python" },
{ import = "yoda.extras.lang.rust" },
```

Each brings that language's neotest adapter, DAP adapter and tooling. A Go
developer should not pay startup cost for the Rust toolchain.

## Updating

```vim
:Lazy update
```

`lazy-lock.json` in *your* clone pins exact revisions — commit it. To roll back
a bad update, restore the previous lock file and run `:Lazy restore`.

## Pre-release note

yoda.nvim v1.0.0 is not tagged yet, so `lua/plugins/yoda.lua` currently tracks
`branch = "main"`. When v1.0.0 ships, change that line to `version = "*"` to
follow released majors instead — which is what you want for a stable install.

## Links

- [yoda.nvim](https://github.com/jedi-knights/yoda.nvim) — the distribution
- [Issues](https://github.com/jedi-knights/yoda.nvim/issues) — report problems
  against yoda.nvim unless they are specific to this template

## License

MIT
