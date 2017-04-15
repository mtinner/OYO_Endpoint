routes = {}

local httpRequest = {}
httpRequest["/"] = "index.html";
httpRequest["/index.html"] = "index.html";


function routes.manage(self, conn, method, route, params)
    if method == 'GET' then
        if route == '/' or route == '/index.html' then
            sendFile(conn, route)
        end
    elseif method == 'POST' then
        if (route == '/' or route == '/index.html') and params then
            station:saveCredentials(params)
        elseif route == '/output' then
            print(route)
        end
    else
        print("[ " .. method .. " not found]");
        conn:send("HTTP/1.1 404 Not Found\r\n\r\n")
        conn:close();
    end
end

function sendFile(conn, path)
    print(path)
    requestFile = httpRequest[path];
    print("[Sending file " .. requestFile .. "]");
    conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
end

function sendJson(conn, path)
    -- requestFile = httpRequest[path];
    conn:send("HTTP/1.1 204 No Content\r\nContent-Type: application/json\r\n\r\n");
end

