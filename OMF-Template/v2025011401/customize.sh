. ${SH:=$MODPATH/ohmyfont}

### INSTALLATION ###

ui_print '- Installing'

ui_print '+ Prepare'
prep

ui_print '+ Configure'
config

ui_print '+ Font'
install_font

src

ui_print '+ Rom'
rom

ui_print '- Finalizing'
fontspoof
svc
finish
