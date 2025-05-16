fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'iski-hud'
version '2.2.1'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts { 'server/*.lua' }

ui_page 'html/index.html'

files {
    'html/*',
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/assets/fonts/*',
    'html/assets/images/*.png',
	'html/assets/images/*.svg',
    'html/assets/images/*.gif',
}