## Installation

### 1. Clone

```
git clone https://github.com/fukamachi/neovim-config ~/.config/nvim
```

### 2. Install dein.vim

```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
```

### 3. Install libraries by dein.vim

```
:call dein#install()
```

### 4. Python3 support

```
brew install pyenv pyenv-virtualenv
pyenv install 3.9.1
pyenv virtualenv 3.9.1 neovim3
pyenv activate neovim3
pip install pynvim
```
