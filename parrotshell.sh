#!/usr/bin/env bash

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

function set_online_frames(){
  onlineFrames=(
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/0.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/1.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/2.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/3.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/4.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/5.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/6.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/7.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/8.txt)"
    "$(curl -sL https://raw.githubusercontent.com/Aliarame/parrotshell/main/frames/9.txt)"
  )
}

function print_help(){
  printf "placeholder again\n"
  
}

#Write "parrot" with colors from the terminal while moving from left to right
#It's only a glimpse of the script that will come later with the ascii
function written_parrot() {

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

function online_parrot() {

  set_online_frames #get the frames online once
  theColor=0
  theLoop=1
  interval=0.070 #70ms in parrot.live & 75ms in terminal-parrot
  i=0
  
  while [ "$theLoop" -eq 1 ]; do

    printf "\033[2J\033[3J\033[H" #Clear the terminal
    printf "${colorsTerminal[$theColor]}" #Set the color to use for the print
    printf "${onlineFrames[$i]}" #Print the frame
    printf "${noColor}" #Keep the cursor with no color

    #Loop colors and frames
    if [ "$theColor" -ge $(($numColors-1)) ]; then theColor=0; else theColor=$(($theColor+1)); fi
    if [ "$i" -ge 9 ]; then i=0; else i=$((i+1)); fi

    sleep $interval 

  done
}

case ${1} in
  1)
    printf "placeholder\n"
    ;;
  -h|--help)
    print_help
    ;;
  -w|--written)
    written_parrot
    ;;
  *)
    online_parrot
    ;;
esac

