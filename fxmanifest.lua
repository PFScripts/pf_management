fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

author 'pf_scripts'
description 'A groups management script built for ox_core'
repository 'https://github.com/PFScripts/pf_management'
version '1.0.0'

ox_libs {'locale'}
shared_scripts {'@ox_lib/init.lua', '@ox_core/lib/init.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'server/*.lua'}
client_scripts {'client/*.lua'}
files {'locales/*.json'}