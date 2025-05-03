# !/bin/sh

# ln = link
# -s = symbolic
#
# ln -s <source_file_or_directory> <result_filename>

# nvim goes in ~/.config/nvim/
cd ~/.config && ln -s ~/dotfiles/nvim nvim

# zshrc, tmux, etc. go in ~
#cd ~ && ln -s ~/dotfiles/p10k.zsh .p10k.zsh
#cd ~ && ln -s ~/dotfiles/zshrc .zshrc
