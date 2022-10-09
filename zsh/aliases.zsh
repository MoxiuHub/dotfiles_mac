# common commands
alias c="clear"
alias ...="cd ../../"
alias ....="cd ../../../"
alias mkdir="mkdir -p"
alias cp="cp -rf"
alias rm="rm -rf"
alias reload="source ~/.zshrc"
alias python='python3'
alias pip='pip3'
alias appstoreapps='mdfind kMDItemAppStoreHasReceipt=1'

# remix-ide
alias startremix='/bin/zsh $HOME/scripts/start_remix.sh'
alias stopremix='/bin/zsh $HOME/scripts/stop_remix.sh'

# zsh
alias vzsh="vim ~/.zshrc"
alias rezsh="source ~/.zshrc"

# grep
alias cls='tput reset'
alias egrep='egrep -G'
alias fgrep='fgrep -G'
alias grep='grep -nir --exclude-dir={.git,dist,build,.idea,.vscode,.history,node_modules}'

# list
alias l.='exa -ld .* --color=auto --icons --no-permissions'
alias la='exa -a --color=auto --icons --no-permissions'
alias ls='exa -l --color=auto --icons --no-permissions'
alias ld='exa -D --color=auto --icons --no-permissions'
alias ll='exa -la --color=auto --icons --no-permissions'
alias lt='exa -T --color=auto --icons --no-permissions'

# Desktop App
alias bob="open /Applications/Bob.app"
alias music="open /System/Applications/Music.app"
alias calculator="open /System/Applications/Calculator.app"
alias mail="open /System/Applications/Mail.app"
alias maps="open /System/Applications/Maps.app"
alias notes="open /System/Applications/Notes.app"
alias photos="open /System/Applications/Photos.app"
alias findmy="open /System/Applications/FindMy.app"
alias setting="open /System/Applications/System\ Preferences.app"
alias findmy="open /System/Applications/FindMy.app"
alias chrome="open /Applications/Google\ Chrome.app"

