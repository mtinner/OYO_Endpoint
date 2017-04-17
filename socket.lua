socket = {}
socket.ws = nil

function socket.connect(ip)
    socket.ws = websocket.createClient()
    socket.ws:on("connection", function(ws)
        socket.ws:send('{"chipid":' .. node.chipid() .. '}')
        print('got ws connection')
    end)
    socket.ws:on("receive", function(_, msg, opcode)
        print('got message:', msg, opcode) -- opcode is 1 for text message, 2 for binary
    end)
    socket.ws:on("close", function(_, status)
        print('connection closed', status)
        ws = nil -- required to lua gc the websocket client
    end)
    local wsURL = 'ws://' .. ip .. ':1990'
    print(wsURL)
    socket.ws:connect(wsURL)
end

function socket.send(table)
    if socket and socket.ws then
        print('try to write')
        socket.ws:send(cjson.encode(table))
    end
end
