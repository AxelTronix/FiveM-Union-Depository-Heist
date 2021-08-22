-- .___________..______        ______   .__   __.  __  ___   ___ 
-- |           ||   _  \      /  __  \  |  \ |  | |  | \  \ /  / 
-- `---|  |----`|  |_)  |    |  |  |  | |   \|  | |  |  \  V  /  
--     |  |     |      /     |  |  |  | |  . `  | |  |   >   <   
--     |  |     |  |\  \----.|  `--'  | |  |\   | |  |  /  .  \  
--     |__|     | _| `._____| \______/  |__| \__| |__| /__/ \__\ 




fx_version 'adamant'
games { 'rdr3', 'gta5' }


description 'Union Heist by Tronix'

version '1.0'

server_scripts {
	'server/sv_*.lua',
	'config.lua'

}

client_scripts {
	'client/cl_*.lua',
	'config.lua'
}

 