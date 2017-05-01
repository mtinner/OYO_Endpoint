server = {}

local filePos, srv = 0, nil

function server.start(callback)

    srv = net.createServer(net.TCP)
    srv:listen(80, function(conn)
        conn:on("receive", function(conn, request)

            local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
            if (method == nil) then
                _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
            end

            local params = helper.getParams(request)
            local body = helper.getJson(request)
            routes:manage(conn, method, path, params, body)
            filePos = 0
        end)

        conn:on("sent", function(conn)
            if requestFile then
                if file.open(requestFile, r) then
                    file.seek("set", filePos);
                    local partial_data = file.read(512);
                    file.close();
                    if partial_data then
                        filePos = filePos + #partial_data;
                        print("[" .. filePos .. " bytes sent]");
                        conn:send(partial_data);
                        if (string.len(partial_data) == 512) then
                            return;
                        end
                    end
                else
                    print("[Error opening file" .. requestFile .. "]");
                end
            end
            conn:close();
        end)
    end)
    tmr.alarm(0, 1000, tmr.ALARM_SINGLE, function()
        helper.setState(constants.states.SERVER_STARTED)
        callback()
    end)
end

function server.close()
    if srv ~= nil then
        srv:close()
        srv = nil
    end
end
