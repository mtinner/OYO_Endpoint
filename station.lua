station = {}

function station.start(callback)
    local wifiConfig = helper:getWifiConfig()
    if wifiConfig == nil then
        tmr.alarm(0, 500, tmr.ALARM_SINGLE, function()
            helper.setState(constants.states.MISSING_WIFI_CREDENTIALS)
            callback()
        end)
        return nil
    end

    if (helper.getState() ~= constants.states.RETRY_CONNECTING_WIFI) then
        wifi.setmode(wifi.STATION)
        wifi.sta.config(wifiConfig)
        wifi.sta.connect()
    end
    helper.setState(constants.states.WAITING_FOR_WIFI_CONNECTION)
    station.checkConnection(callback)
    return nil
end

function station.checkConnection(callback)
    tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
        if (wifi.sta.getip() == nil) then
            callback()
        else
            helper.setState(constants.states.WIFI_CONNECTED)
            callback()
        end
    end)
end

function station.saveCredentials(params)
    if params.ssid and params.pwd and file.open("wifi.json", "w+") then
        file.writeline(cjson.encode(params))
        file.close()
        node.restart()
    end
end
