helper = {}
helper.attemptsOnSameState = 0
local _state = constants.states.CONNECTING_WIFI


function helper.getParams(request)
    params = {}
    for k, v in string.gmatch(request, "[\n|&]([^&=\n ;]+)=([^=;\n&]+)") do
        params[k] = v
    end
    return params
end

function helper.getJson(request)
    local jsonString = string.match(request, "{.*}$")
    if not jsonString then
        jsonString = '{}'
    end
    return cjson.decode(jsonString)
end


function helper.getWifiConfig()
    if file.open("wifi.json", "r") then
        local wificonfig
        local line = file.readline()
        file.close()
        wificonfig = cjson.decode(line)

        if not wificonfig or not wificonfig.ssid or not wificonfig.pwd then
            return nil
        end

        wificonfig.auto = false
        return wificonfig
    end
    return nil
end

function helper.hasArrayObjectValue(arr,attribute, value)
    for i, v in ipairs(arr) do
        if v[attribute] == value then
            return true
        end
    end
    return false
end


function helper.setState(state)
    _state = state
    helper.attemptsOnSameState = 0;
    print(state)
end

function helper.getState()
    return _state
end
