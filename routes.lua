routes = {}

local httpRequest = {}
httpRequest["/"] = "index.html";
httpRequest["/index.html"] = "index.html";

local getContentType = {};
getContentType["/"] = "text/html";
getContentType["/index.htm"] = "text/html";


function routes.manage(self,conn, method, path, params)

    if getContentType[path] then
        requestFile = httpRequest[path];
        print("[Sending file " .. requestFile .. "]");
        filePos = 0;
        conn:send("HTTP/1.1 200 OK\r\nContent-Type: " .. getContentType[path] .. "\r\n\r\n");
    else
        print("[File " .. path .. " not found]");
        conn:send("HTTP/1.1 404 Not Found\r\n\r\n")
        conn:close();
    end
end
