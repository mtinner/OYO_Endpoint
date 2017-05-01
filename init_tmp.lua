require('constants')
require('softap')
require('server')
require('station')
require('helper')
require('routes')
require('input')
require('output')
require('socket')
require('introducer')
--[[
function startStation(wifiConfig)
    station:start(wifiConfig)
end

function startConfigAP()
    softap:start()
    server:start()
end



input:initialize()
output:initialize()

if wifiConfig then
    local config = wifiConfig
    startStation(config)
else
    startConfigAP()
end
]]

-- TODO add repetition thresholds
function actionExecuter()
    if helper.getState() == constants.states.CONNECTING_WIFI then
        station.start(actionExecuter)
    end

    if helper.getState() == constants.states.WAITING_FOR_WIFI_CONNECTION then
        station.checkConnection(actionExecuter)
    end

    if helper.getState() == constants.states.MISSING_WIFI_CREDENTIALS then
    end

    if helper.getState() == constants.states.WIFI_CONNECTED then
        server.start(actionExecuter)
    end

    if helper.getState() == constants.states.SERVER_STARTED then
        -- TODO check if AP mode active, if so this is an end state
        if wifi.ap.getip() == nil then
            introducer.start(actionExecuter)
        end
    end

    if helper.getState() == constants.states.WAITING_FOR_INTRODUCING then
        introducer.checkState(actionExecuter)
    end

    if helper.getState() == constants.states.INTRODUCED then
        socket.start(actionExecuter)
    end

    if helper.getState() == constants.states.WAITING_WS_CONNECTION then
        socket.checkConnection(actionExecuter)
    end

    if helper.getState() == constants.states.WS_CONNECTION_ESTABLISHED then
        -- endstate
    end

    if helper.getState() == constants.states.WS_CONNECTION_CLOSED then
        introducer.close()
        socket.close()
        introducer.start(actionExecuter)
    end
    if helper.getState() == constants.states.START_AP then
    end
    helper.attemptsOnSameState = helper.attemptsOnSameState + 1
    collectgarbage();
end

actionExecuter()
