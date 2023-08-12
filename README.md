## Installation

### 1. Clone

```
git clone https://github.com/fukamachi/neovim-config ~/.config/nvim
```

### 2. Install dein.vim

```
mkdir -p ~/.cache/dein/repos/github.com/Shougo
git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo
```

### 3. Python3 support

```
sudo apt install python3
sudo apt install python3-pip
pip install neovim
```

### 4. Install libraries by dein.vim

```
:UpdateRemotePlugins
:call dein#install()
```
