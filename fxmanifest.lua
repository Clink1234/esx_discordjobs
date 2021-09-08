fx_version 'cerulean'

game 'gta5'

author 'Clink123'

version '0.1.0'

description 'ESX Discord Jobs'

version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
	'config.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}

dependencies {
    'es_extended',
    'discordroles'
}
