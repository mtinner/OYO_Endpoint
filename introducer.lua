introducer = {}
local newState, srv

function introducer.start(callback)
    srv = net.createServer(net.UDP)
    srv:on("receive", function(_, _, _, ip)
        local registerEndpointURL = 'http://' .. ip .. ':' .. 8610 .. '/api/endpoints'
        http.post(registerEndpointURL, constants.JsonHeader, cjson.encode(constants.OYO), function(code, data)
            if (code < 0) then
                helper.setState(constants.states.INTRODUCTION_FAILED)
            else
                IP = ip
                helper.setState(constants.states.INTRODUCED)
            end
        end)

        srv:close()
        srv = nil
    end)
    helper.setState(constants.states.WAITING_FOR_INTRODUCING)
    srv:listen(1990)
    introducer.checkState(callback)
    return nil
end

function introducer.checkState(callback)
    tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
        callback()
    end)
end

function introducer.close()
    if srv ~= nil then
        srv:close()
        srv = nil
    end
end
