# dotfiles

Managed with [chezmoi](https://chezmoi.io). Secrets via 1Password CLI.

## New machine bootstrap

### 1. Xcode Command Line Tools
```sh
xcode-select --install
```

### 2. Homebrew, chezmoi, and 1Password CLI
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi 1password-cli
```

### 3. Install 1Password 8 and enable CLI integration
Install 1Password 8, then: **Settings → Developer → Connect with 1Password CLI**

### 4. Apply dotfiles
```sh
chezmoi init --apply https://github.com/silkm/dotfiles.git
```
This clones the repo and automatically:
- Deploys all config files
- Runs `brew bundle install --global`
- Installs Doom Emacs
- Installs GHCup
- Starts SketchyBar
- Writes `~/.doom.d/secrets.el` from 1Password

### 5. Manual steps
- Install **BetterTouchTool** (outside brew), then run `chezmoi apply` to import the preset

## Post install extras

### Emacs launcher app
Create an Automator app (`~/Applications/Emacs.app`) with a **Shell Script** action:
```sh
EMACSDIR="$(dirname $(dirname $(readlink -f /opt/homebrew/bin/emacs)))"
zsh --login -c "open -na $EMACSDIR/bin/emacs $@"
```

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
