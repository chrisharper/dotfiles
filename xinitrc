setxkbmap -layout gb -variant mac -option lv3:lalt_switch 
xsetroot -solid '#222222'
xrandr -s 3840x2160 
xrandr --dpi 96
eval $(ssh-agent)
vmware-user-suid-wrapper
exec dwm 
