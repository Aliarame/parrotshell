#!/usr/bin/env bash

#Write "parrot" with colors from the terminal while moving from left to right
#It's only a glimpse of the script that will come later with the ascii
function moving_parrot() {

  #Define colors variables:
  colorsTerminal=(
    '\033[0;31m'  #Red
    '\033[0;32m'  #Green
    '\033[0;33m'  #Yellow
    '\033[0;34m'  #Blue
    '\033[0;35m'  #Magenta
    '\033[0;36m'  #Cyan
    '\033[0;37m'  #White
  )
  noColor='\033[0m'  #No Color
  numColors=${#colorsTerminal[@]} #7 colors

  #Terminal size (width and height)
  terminalWidth=$(tput cols)
  terminalHeight=$(tput lines)

  theWidth=$(($terminalWidth-6)) #Remove "parrot" from the width
  theLoop=1
  isAscending=1
  interval=0.1
  j=0
  
  printf "\033[2J\033[3J\033[H" #Clear the terminal

  while [ "$theLoop" -eq 1 ]; do
  
    for ((i = 0; i < j;i++)); do
      printf " "
    done

    #Print section
    theColor=$((j%$numColors)) #Set a color from the 7 availables
    printf "${colorsTerminal[$theColor]}%s${noColor}" "parrot" 
    if [ "$isAscending" -eq 0 ]; then printf " "; fi #Remove a ghosting letter during descent 
    printf "\r"
    
    #Reset variables according to ascent/descent
    if [ "$j" -ge $theWidth ]; then isAscending=0; elif [ "$j" -le 0 ]; then isAscending=1; fi
    if [ "$isAscending" -eq 1 ]; then j=$((j+1)); else j=$((j-1)); fi

    sleep $interval

  done
}

case ${1} in
  1)
    printf "placeholder\n"
    ;;
  *)
    moving_parrot
    ;;
esac

