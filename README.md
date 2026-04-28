# dotfiles

Managed with [chezmoi](https://chezmoi.io). Secrets via 1Password CLI.

## New machine bootstrap

### 1. Xcode Command Line Tools
```sh
xcode-select --install
```

### 2. Install chezmoi and apply dotfiles
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/silkm/dotfiles.git
```
This installs chezmoi, clones this repo, then automatically:
- Installs Homebrew
- Deploys all config files
- Runs `brew bundle install --global`
- Installs Doom Emacs
- Installs GHCup
- Starts SketchyBar

### 3. Set up 1Password and apply secrets
Install 1Password 8, then enable CLI integration: **Settings → Developer → Connect with 1Password CLI**
```sh
chezmoi apply
```

### 4. Manual steps
- Install **BetterTouchTool** (outside brew), then run `chezmoi apply` to import the preset

## External repos
| Repo | Target |
|------|--------|
| [silkm/doom-config](https://github.com/silkm/doom-config) | `~/.doom.d` |
| [silkm/aerospace-config](https://github.com/silkm/aerospace-config) | `~/.config/aerospace` |

## 1Password items required
| Item | Vault | Used for |
|------|-------|----------|
| `chezmoi_doom_emacs_secrets.el` | Private | `~/.doom.d/secrets.el` |

## TODO

- [ ] Add GHC to PATH in zshrc
- [ ] Add Karabiner Elements config from new laptop (separate repo via chezmoi external)
- [x] Add Aerospace config (separate repo via chezmoi external)
- [ ] Add Ghostty config (~/.config/ghostty/config)
- [ ] Add clean ~/.ssh/config for new machine
