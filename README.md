# dotfiles

Managed with [chezmoi](https://chezmoi.io). Secrets via 1Password CLI.

## New machine bootstrap

### 1. Xcode Command Line Tools
```sh
xcode-select --install
```

### 2. Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Follow the **Next steps** the installer prints to add Homebrew's `PATH` lines to `~/.zprofile`, then reload it:
```sh
source ~/.zprofile
```

### 3. chezmoi
```sh
brew install chezmoi
```

### 4. Install 1Password and enable CLI integration
```sh
brew install --cask 1password 1password-cli
```
Open 1Password 8, then: **Settings → Developer → Connect with 1Password CLI**

### 5. Apply dotfiles
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

### 6. Manual steps
- Add `~/.ssh/id_ed25519.pub` to GitHub
- Clone the private notebook repo (needs the SSH key above on GitHub first):
  ```sh
  git clone git@github.com:silkm/notebook.git ~/notebook
  ```
- Install **Zoom** manually from [zoom.us/download](https://zoom.us/download)
- Enable the **Zotero Connector** in Safari: **Safari → Settings → Extensions** and tick **Zotero Connector** (installed with the Zotero cask)
- Install the **Better BibTeX** plugin in Zotero ([docs](https://retorque.re/zotero-better-bibtex/installation/)):
  1. Download the latest `.xpi` from the [GitHub releases page](https://github.com/retorquere/zotero-better-bibtex/releases/latest) — right-click and save the file rather than opening it.
  2. In Zotero: **Tools → Plugins**, click the gear icon, choose **Install Plugin From File…**, and select the downloaded `.xpi`.

  Auto-updates after install, so this is a one-time step.
- System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts → `+` → choose Safari, menu title `Move Tab to New Window`, press meh+F.

## Post install extras

### Google Cloud SDK
Installed automatically via `brew bundle`. After first install, authenticate:
```sh
gcloud auth login
gcloud config set project <your-project>
```

### GitHub CLI
Installed automatically via `brew bundle`. Authenticate via OAuth device flow (token stored in macOS keychain):
```sh
gh auth login
```
Pick **GitHub.com → SSH → Login with a web browser** to match the SSH-based git setup.

After `gh auth login`, create `~/.authinfo` so Magit Forge can authenticate:
```sh
TOKEN=$(gh auth token)
printf 'machine api.github.com login silkm^forge password %s\n' "$TOKEN" > ~/.authinfo
chmod 600 ~/.authinfo
```
The `^forge` suffix scopes the token to Forge. `github.user = silkm` is already set in the managed `~/.gitconfig` — required for ghub to find the token.

### Kanata (home row mods)
Installed automatically via `brew bundle`. Uses the Karabiner-DriverKit-VirtualHIDDevice driver that ships with Karabiner Elements, so no separate driver install is needed.

1. Grant **Input Monitoring** permission to the terminal (or to `kanata` once it's run once and prompts) in **System Settings → Privacy & Security → Input Monitoring**.
2. Start it:
   ```sh
   sudo kanata -c ~/.config/kanata/kanata.kbd
   ```

Karabiner Elements stays installed but should only have rules that disable the built-in keyboard when an external one is connected — leave actual remapping to kanata.

### Google Calendar in SketchyBar
SketchyBar shows upcoming meetings via the macOS Calendar app.

1. Open **System Settings → Internet Accounts → Add Account → Google**
2. Sign in and enable **Calendars**

Meetings appear 15 minutes before start. Font turns red at 2 minutes. Meetings linger for 5 minutes after start then clear.

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

- [x] Add GHC to PATH in zshrc
- [ ] Add Karabiner Elements config from new laptop (separate repo via chezmoi external)
- [x] Add Aerospace config
- [x] Add Ghostty config (~/.config/ghostty/config)
- [x] Add clean ~/.ssh/config for new machine (via 1Password)
- [ ] Test kanata home row mods, then wire up auto-start (LaunchDaemon)
- [ ] Add symbol layer(s) to kanata config
