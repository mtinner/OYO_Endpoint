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
            if body.value and body.outputPin then
                sendJson(conn, body.outputPin, body.value, body.toggle)
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

function sendJson(conn, outputPin, value, toggle)
    conn:send("HTTP/1.1 204 No Content\r\nContent-Type: application/json\r\n\r\n", function()
        output.setOutput(outputPin, value, toggle)
    end);
end

