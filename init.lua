require('softap')
require('server')
require('station')
require('helper')
require('routes')

function startStation(wifiConfig)
    station:start(wifiConfig)
end

function startConfigAP()
    softap:start()
    server:start()
end



local wifiConfig = helper:getWifiConfig()

if wifiConfig then
    local config = wifiConfig
    startStation(config)
else
    startConfigAP()
end


