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
- Add `~/.ssh/id_ed25519.pub` to GitHub
- Install **BetterTouchTool** (outside brew), then run `chezmoi apply` to import the preset
- Install **Zoom** manually from [zoom.us/download](https://zoom.us/download)

## Post install extras

### Google Cloud SDK
Install following the [official instructions](https://docs.cloud.google.com/sdk/docs/install-sdk#mac).

### Google Calendar in SketchyBar
SketchyBar shows upcoming meetings (within 5 minutes of start time) via the macOS Calendar app.

1. Open **System Settings → Internet Accounts → Add Account → Google**
2. Sign in and enable **Calendars**

The bar item appears automatically when a meeting is 5 minutes away and prepends `!!!` at 1 minute. No extra tools required.

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

## 1Password items required
| Item | Vault | Used for |
|------|-------|----------|
| `chezmoi_doom_emacs_secrets.el` | Private | `~/.doom.d/secrets.el` |
| `chezmoi_ssh_config` | Private | `~/.ssh/config` |

## TODO

- [ ] Add GHC to PATH in zshrc
- [ ] Add Karabiner Elements config from new laptop (separate repo via chezmoi external)
- [x] Add Aerospace config
- [x] Add Ghostty config (~/.config/ghostty/config)
- [x] Add clean ~/.ssh/config for new machine (via 1Password)
