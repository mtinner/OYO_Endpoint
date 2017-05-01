introducer = {}
local newState, srv

function introducer.start(callback)
    newState = constants.states.WAITING_FOR_INTRODUCING
    srv = net.createServer(net.UDP)
    srv:on("receive", function(_, _, _, ip)
        local registerEndpointURL = 'http://' .. ip .. ':' .. 8610 .. '/api/endpoints'
        print(registerEndpointURL)
        http.post(registerEndpointURL, constants.JsonHeader, cjson.encode(constants.OYO), function(code, data)
            if (code < 0) then
                print("HTTP request failed")
                newState = constants.states.START_AP
            else
                print(code, data)
                IP = ip
                newState = constants.states.INTRODUCED
            end
        end)

        srv:close()
        srv = nil
    end)
    srv:listen(1990)
    introducer.checkState(callback)
    return nil
end

function introducer.checkState(callback)
    tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
        helper.setState(newState)
        callback()
    end)
end

function introducer.close()
    if srv ~= nil then
        srv:close()
        srv = nil
    end
end
