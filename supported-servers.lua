-- Copyright (c) 2022 Florian Fischer. All rights reserved.
--
-- This file is part of vis-lspc.
--
-- vis-lspc is free software: you can redistribute it and/or modify it under the
-- terms of the GNU General Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your option) any later
-- version.
--
-- vis-lspc is distributed in the hope that it will be useful, but WITHOUT ANY
-- WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License along with
-- vis-lspc found in the LICENSE file. If not, see <https://www.gnu.org/licenses/>.
--
-- List of supported and preconfigured language server implementations
local source_str = debug.getinfo(1, 'S').source:sub(2)
local source_path = source_str:match('(.*/)')

local lspc = dofile(source_path .. 'lspc.lua')

local clangd = {name = 'clangd', cmd = 'clangd', roots = {'compile_commands.json', '.clangd'}}
local typescript = {
  name = 'typescript',
  cmd = 'typescript-language-server --stdio',
  roots = {'package.json', 'tsconfig.json', 'jsconfig.json'},
}

return {
  cpp = clangd,
  ansi_c = clangd,
  -- pylsp (python-lsp-server) language server configuration
  -- https://github.com/python-lsp/python-lsp-server
  python = {name = 'python-lsp-server', cmd = 'pylsp', roots = {'requirements.txt', 'setup.py'}},
  -- lua (lua-language-server) language server configuration
  -- https://github.com/sumneko/lua-language-server
  lua = {
    name = 'lua-language-server',
    cmd = 'lua-language-server',
    settings = {
      Lua = {diagnostics = {globals = {'vis'}}, telemetry = {enable = false}},
    },
  },
  -- typescript (typescript-language-server) language server configuration
  -- https://github.com/typescript-language-server/typescript-language-server
  javascript = typescript,
  typescript = typescript,
  -- dart language server configuration
  -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md
  dart = {
    name = 'dart',
    cmd = 'dart language-server --client-id vis-lspc --client-version ' .. lspc.version,
    roots = {'pubspec.yaml'},
  },
  -- haskell (haskell-language-server)
  -- https://github.com/haskell/haskell-language-server
  haskell = {name = 'haskell', cmd = 'haskell-language-server-wrapper --lsp', roots = {'hie.yaml', 'cabal.project', 'Setup.hs', 'stack.yaml', '*.cabal'}},

  -- ocaml (ocaml-language-server)
  -- https://github.com/ocaml/ocaml-lsp
  caml = {name = 'ocaml', cmd = 'ocamllsp', roots = {'dune-workspace', 'dune-project', 'Makefile', 'opam', '*.opam', 'esy.json', 'dune'}},

  -- go (gopls)
  -- https://github.com/golang/tools/tree/master/gopls
  go = {name = 'go', cmd = 'gopls', roots = {'Gopkg.toml', 'go.mod'}},

  -- rust (rust-analyzer)
  -- https://github.com/rust-lang/rust-analyzer
  rust = {name = 'rust', cmd = 'rust-analyzer', roots = {'Cargo.toml'}},

  -- zig (zls)
  -- https://github.com/zigtools/zls
  zig = {name = 'zig', cmd = 'zls', roots = {'build.zig'}}
}
