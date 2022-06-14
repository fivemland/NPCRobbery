fx_version 'cerulean'
game 'gta5'

author 'MedveMarci'
description 'NPCRobbery by MedveMarci'
version '0.0.1'

shared_scripts {
    "config.lua",
    "@es_extended/imports.lua"
    }

client_script {
    'locales/*.lua',
    'client.lua',
}
server_script {
    'locales/*.lua',
    'server.lua'
}