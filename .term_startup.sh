#!/bin/bash

GREEN="\e[92m"
RED="\e[91m"
BLUE="\e[94m"
YELLOW="\e[93m"
WHITE="\e[97m"
BLACK="\e[90m"
BOLD="\e[1m"
RESET="\e[0m"

USER_HOSTNAME="${BLACK}host\e[0m $(whoami)@$(hostname)"
KERNEL="${BLACK}kernel\e[0m $(uname -r)"
UPTIME="${BLACK}since\e[0m $(uptime -p)"
BATTERY_PERCENTAGE="${BLACK}battery\e[0m $(cat /sys/class/power_supply/BAT0/capacity)%"

logo="
                    -@                 
                   .##@                
                  .####@               
                  @#####@              
                . *######@             
               .##@o@#####@                  
              /############@                 
             /##############@                
            @######@**%######@         
           @######.     %#####o        
          @######@       ######%       
        -@#######h       ######@..     
       /#####h**..       .**%@####@    
      @H@*.                    .*%#@   
     *.                            .*  "

logo2='
           .
          /#\
         /###\      
        /p^###\     
       /##P^q##\    
      /##(   )##\   
     /###P   q#,^\
    /P^         ^q\ 
'

colors=(
  # "\e[91m"
  "\e[92m"
  "\e[93m"
  "\e[95m"
  "\e[90m"
)
random_index=$((RANDOM % ${#colors[@]}))
rchar="${BLUE}\e[0m"
indent="    ${rchar}"

reset
echo -e "${colors[$random_index]}$logo2"
echo -e "$indent$USER_HOSTNAME ${rchar} $KERNEL ${rchar} $BATTERY_PERCENTAGE"
echo -e "$indent$UPTIME"
echo -e "\n$indent\e[1;35m$(date)\e[0m"
echo -e ""
