lvim.builtin.treesitter.ensure_installed = {
  "json",
  "javascript",
  "jsdoc",
  "typescript",
  "tsx",
  "yaml",
  "json",
  "html",
  "css",
  "bash",
  "lua",
  "vim",
  "python",
  "c",
  "make",
  "c_sharp",
  "java",
  "dockerfile",
  "gitignore",
  "markdown",
  "bibtex",
  "latex",
  "mermaid",
  "gotmpl"
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


local treesitter_parsers_status, treesitter_parsers = pcall(require, "nvim-treesitter.parsers")
if not treesitter_parsers_status then
  return
end


local parser_config = treesitter_parsers.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}
