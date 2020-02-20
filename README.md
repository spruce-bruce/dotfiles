# Dotfiles

## Install
Clone this repo then run a couple symlink commands:

```
$ git clone git@github.com:spruce-bruce/dotfiles.git
$ ln -s ./dotfiles/.vim ~/.vim
$ ln -s ./dotfiles/.vimrc ~/.vimrc
$ ln -s ./dotfiles/.zshrc ~/.zshrc
```

## Dependencies

My .vimrc is set up to use a couple of plugins and settings that will not work correctly if these dependencies aren't set up first.

### base16-shell
Set up [base16-shell](https://github.com/chriskempson/base16-shell) in whatever terminal you're using in order to get nice terminal colors (and therefore vim colors). I use iterm2 so I get my color themes from [here](https://github.com/martinlindhe/base16-iterm2). Having the theme available isn't important, but having color set up correctly in your terminal is. The base16-shell repo is packaged with a color test cli script that you can run to make sure things look right.

### ripgrep
ripgrep is a super fast CLI search tool. Install with homebrew

```
brew install ripgrep
```
