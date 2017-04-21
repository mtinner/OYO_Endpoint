require('constants')
require('softap')
require('server')
require('station')
require('helper')
require('routes')
require('input')
require('output')
require('socket')

function startStation(wifiConfig)
    station:start(wifiConfig)
end

function startConfigAP()
    softap:start()
    server:start()
end



local wifiConfig = helper:getWifiConfig()
input:initialize()
output:initialize()

if wifiConfig then
    local config = wifiConfig
    startStation(config)
else
    startConfigAP()
end


