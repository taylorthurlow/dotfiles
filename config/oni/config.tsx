import * as React from "react"
import * as Oni from "oni-api"

const activate = (oni: Oni.Plugin.Api) => {
	oni.input.bind("<s-c-g>", () => oni.commands.executeCommand("sneak.show"))
	oni.input.bind("<c-p>", () => oni.commands.executeCommand("quickOpen.show"))

	// Move about splits easier.
	oni.input.bind("<c-h>", () => oni.editors.activeEditor.neovim.command(`call OniNextWindow('h')<CR>`))
	oni.input.bind("<c-j>", () => oni.editors.activeEditor.neovim.command(`call OniNextWindow('j')<CR>`))
	oni.input.bind("<c-k>", () => oni.editors.activeEditor.neovim.command(`call OniNextWindow('k')<CR>`))
	oni.input.bind("<c-l>", () => oni.editors.activeEditor.neovim.command(`call OniNextWindow('l')<CR>`))

	// Use <c-x> to quick-open a file horizontally
	oni.input.bind("<c-x>", () => oni.commands.executeCommand("quickOpen.openFileHorizontal"))
};

module.exports = {
	activate,
	"achievements.enabled": false,
	"autoUpdate.enabled": true,
	"autoClosingPairs.enabled": true,
	"browser.defaultUrl": "about:blank",
	"editor.fontFamily": "FiraCode-Retina",
	"editor.fontSize": "16px",
	"editor.quickOpen.execCommand": "rg --files --hidden --smart-case --glob \"!.git/*\"",
	"editor.clipboard.enabled": false,
	"editor.quickInfo.enabled": false,
	"editor.quickOpen.defaultOpenMode": "Oni.FileOpenMode.ExistingTab",
	"editor.quickOpen.alternativeOpenMode": "Oni.FileOpenMode.ExistingTab"
	"editor.formatting.formatOnSwitchToNormalMode": true,
	"editor.textMateHighlighting.enabled": true,
	"environment.additionalPaths": ["/Users/taylor/.rbenv/shims", "/Users/taylor/.rbenv/bin"],
	"language.ruby.languageServer.arguments": ["stdio"],
	"language.ruby.languageServer.command": "/Users/taylor/.rbenv/shims/solargraph",
	"learning.enabled": false,
	"oni.hideMenu": "hidden",
	"oni.loadInitVim": true,
	"oni.useDefaultConfig": false,
	"sidebar.default.open": false,
	"sidebar.width": "25em",
	"stautsbar.fontSize": "12px",
	"ui.colorscheme": "n/a",
};
