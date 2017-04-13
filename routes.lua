routes = {}

local httpRequest = {}
httpRequest["/"] = "index.html";
httpRequest["/index.html"] = "index.html";
httpRequest["/connecting"] = "connecting.html";

local getContentType = {};
getContentType["/"] = "text/html";
getContentType["/index.htm"] = "text/html";
getContentType["/connecting"] = "text/html";


function routes.manage(self, conn, method, path, params)

    if getContentType[path] and method == 'GET' then
        sendFile(conn, path)
    elseif path == "/" and method == 'POST' then
        print(params.ssid .. params.pwd)
        if params.ssid and params.pwd and file.open("wifi.json", "w+") then
            file.writeline(cjson.encode(params))
            file.close()
            sendFile(conn, "/connecting")
            node.restart()
        end
    else
        print("[File " .. path .. " not found]");
        conn:send("HTTP/1.1 404 Not Found\r\n\r\n")
        conn:close();
    end
end

function sendFile(conn, path)
    requestFile = httpRequest[path];
    print("[Sending file " .. requestFile .. "]");
    conn:send("HTTP/1.1 200 OK\r\nContent-Type: " .. getContentType[path] .. "\r\n\r\n");
end
