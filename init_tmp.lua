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

function actionExecuter()

    if constants.RETRY_THRESHOLD <= helper.attemptsOnSameState then
        helper.setState(constants.states.TIMEOUT)
        introducer.close()
        socket.close()
        server.close()
        collectgarbage();
    end

    if helper.getState() == constants.states.CONNECTING_WIFI then
        station.start(actionExecuter)
    end

    if helper.getState() == constants.states.WAITING_FOR_WIFI_CONNECTION then
        station.checkConnection(actionExecuter)
    end

    if helper.getState() == constants.states.WAITING_FOR_AP then
        softap.checkState(actionExecuter)
    end

    if helper.getState() == constants.states.WIFI_CONNECTED or
            helper.getState() == constants.states.AP_STARTED then
        server.start(actionExecuter)
    end

    if helper.getState() == constants.states.SERVER_STARTED then
        -- TODO check if AP mode active, if so this is an end state
        if wifi.ap.getip() == nil then
            introducer.start(actionExecuter)
        else
            print('SERVER_STARTED')
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
        print('WS_CONNECTION_ESTABLISHED')
    end

    if helper.getState() == constants.states.WS_CONNECTION_CLOSED then
        introducer.close()
        socket.close()
        collectgarbage();
        introducer.start(actionExecuter)
    end
    if helper.getState() == constants.states.INTRODUCTION_FAILED or
            helper.getState() == constants.states.TIMEOUT or
            helper.getState() == constants.states.MISSING_WIFI_CREDENTIALS then
        softap.start(actionExecuter)
    end

    helper.attemptsOnSameState = helper.attemptsOnSameState + 1
    collectgarbage();
end

actionExecuter()
