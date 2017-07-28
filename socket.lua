socket = {}
socket.ws = nil

function socket.start(callback)
    socket.ws = websocket.createClient()
    socket.ws:config({ headers = { ['Chip-Id'] = node.chipid() } })
    socket.ws:on("connection", function(ws)
        input.subscribe(socket.send)
        output.subscribe(socket.send)
        socket.send(input.getState())
        helper.setState(constants.states.WS_CONNECTION_ESTABLISHED)
    end)
    socket.ws:on("receive", function(_, msg, opcode)
        print('got message:', msg, opcode) -- opcode is 1 for text message, 2 for binary
    end)
    socket.ws:on("close", function(_, status)
        socket.ws = nil -- required to lua gc the websocket client
        input.unsubscribe()
        output.unsubscribe()
        helper.setState(constants.states.WS_CONNECTION_CLOSED)
        callback()
    end)
    local wsURL = 'ws://' .. IP .. ':1990'
    helper.setState(constants.states.WAITING_WS_CONNECTION)
    socket.ws:connect(wsURL)
    socket.checkConnection(callback)
    return nil
end

function socket.checkConnection(callback)
    tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
        callback()
    end)
end

function socket.send(table)
    if socket and socket.ws then
        socket.ws:send(cjson.encode(table))
    end
end

function socket.close()
    if socket.ws ~= nil then
        socket.ws = nil
    end
end
