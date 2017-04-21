socket = {}
socket.ws = nil

function socket.connect(ip)
    socket.ws = websocket.createClient()
    socket.ws:on("connection", function(ws)
        print('got ws connection')
        tmr.unregister(3)
        input.subscribe(socket.send)
    end)
    socket.ws:on("receive", function(_, msg, opcode)
        print('got message:', msg, opcode) -- opcode is 1 for text message, 2 for binary
    end)
    socket.ws:on("close", function(_, status)
        print('connection closed', status)
        socket.ws = nil -- required to lua gc the websocket client
        socket.reconnect(ip)
        input.unsubscribe()
    end)
    local wsURL = 'ws://' .. ip .. ':1990'
    print(wsURL)
    socket.ws:connect(wsURL)
end

function socket.reconnect(ip)
    local cnt = 0
    tmr.alarm(3, 10000, tmr.ALARM_AUTO, function()
        cnt = cnt + 1
        print("Try to reconnect to websocket")
        socket.connect(ip)
        if cnt > 12 then
            tmr.unregister(3)
            print("Could not connect to websocket")
            startConfigAP()
        end
    end)
end

function socket.send(table)
    if socket and socket.ws then
        socket.ws:send(cjson.encode(table))
    end
end
