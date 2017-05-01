routes = {}

function routes.manage(_, conn, method, route, params, body)
    if method == 'GET' then
        if route == '/' or route == '/index.html' then
            sendFile(conn)
        end
    elseif method == 'POST' then
        if (route == '/' or route == '/index.html') and params then
            if not station.saveCredentials(params) then
                sendFile(conn)
            end
        elseif route == '/output' then
            if body.value and body.pin then
                output.setOutput(body.pin, body.value, body.toggle)
                sendJson(conn)
            end
        end
    else
        print("[ " .. method .. " not found]");
        conn:send("HTTP/1.1 404 Not Found\r\n\r\n")
        conn:close();
    end
end

function sendFile(conn)
    requestFile = 'index.html';
    conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
end

function sendJson(conn)
    conn:send("HTTP/1.1 204 No Content\r\nContent-Type: application/json\r\n\r\n");
end

