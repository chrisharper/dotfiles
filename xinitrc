setxkbmap -layout gb -variant mac -option lv3:lalt_switch 
xsetroot -solid '#222222'
xrandr -s 2560x1600
xrandr --dpi 227
eval $(ssh-agent)
vmware-user-suid-wrapper
exec dwm 
