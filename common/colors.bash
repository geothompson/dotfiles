export escape=$'\033'
export reset=$'\033[0m'
export bold=$'\033[1m'
export underline=$'\033[4m'
export blinkon=$'\033[5m'
export blinkoff=$'\033[25m'
export inverse=$'\033[7m'
export inverseoff=$'\033[27m'
export normal=$'\033[39m'
export normalbg=$'\033[49m'

export clear=$'\033[H\033[2J'
clear () { echo -n $clear; }
