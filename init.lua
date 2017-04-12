require('softap')
require('server')
require('station')


function getWifiConfig()
    if file.open("wifi.json", "r") then
        local wificonfig
        while true
        do
            local line
            line = file.readline()
            if (line == nil) then
                file.close()
                break
            end
            line = line
            wificonfig = cjson.decode(line)
        end

        if not wificonfig or not wificonfig.ssid or not wificonfig.pwd then
            return nil
        end

        wificonfig.auto = false
        return wificonfig
    end
    return nil
end



function startStation(wifiConfig)
    station:start(wifiConfig, startConfigAP)
end

function startConfigAP()
    softap:start()
    server:start()
end



local wifiConfig = getWifiConfig()

if wifiConfig then
    local config = wifiConfig


    startStation(config)
else
    startConfigAP()
end


