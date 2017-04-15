routes = {}

function routes.manage(_, conn, method, route, params)
    if method == 'GET' then
        if route == '/' or route == '/index.html' then
            sendFile(conn)
        end
    elseif method == 'POST' then
        if (route == '/' or route == '/index.html') and params then
            station.saveCredentials(params)
        elseif route == '/output' then
            print(route)
            output.setOutput(2, 1)
        end
    else
        print("[ " .. method .. " not found]");
        conn:send("HTTP/1.1 404 Not Found\r\n\r\n")
        conn:close();
    end
end

function sendFile(conn)
    requestFile = 'index.html';
    print("[Sending file " .. requestFile .. "]");
    conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
end

function sendJson(conn)
    conn:send("HTTP/1.1 204 No Content\r\nContent-Type: application/json\r\n\r\n");
end

