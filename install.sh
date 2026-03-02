#!/bin/zsh
set -euo pipefail
setopt PIPEFAIL

# install.sh
# - default: dry-run (shows actions)
# - to perform changes: run with --apply

# Determine directory in zsh
DIR="$(cd "$(dirname $0)" && pwd)"

DRY_RUN=true
if [ "${1:-}" = "--apply" ]; then
  DRY_RUN=false
fi

echo "Dotfiles dir: $DIR"
if [ "$DRY_RUN" = true ]; then
  echo "Mode: dry-run (no changes). Run with --apply to make changes."
else
  echo "Mode: apply (will make changes)."
fi

# Hard-coded list of dotfiles to symlink (change here to control which files)
files=("$DIR/.zshrc" "$DIR/.gitconfig" "$DIR/.aliases")

for src in "${files[@]}"; do
  if [ ! -e "$src" ]; then
    echo "[missing] $(basename "$src") not found in $DIR — skipping"
    continue
  fi
  filename=$(basename "$src")
  dest="$HOME/$filename"

  if [ "$DRY_RUN" = true ]; then
    echo "[link]  $dest -> $src"
  else
    if [ -L "$dest" ]; then
        echo "Removing existing symlink $dest"
        rm -rf "$dest"
    elif [ -e "$dest" ]; then
        echo "Backing up $dest -> $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
done

if [ "$DRY_RUN" = true ]; then
  echo "Done. To apply changes run: ./install.sh --apply"
else
  echo "Symlinks created. Backups made for existing files if necessary."
  source $HOME/.zshrc
fi

