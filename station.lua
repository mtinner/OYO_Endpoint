station = {}

function station.start(self, wifiConfig)

    wifi.setmode(wifi.STATION)
    wifi.sta.config(wifiConfig)

    wifi.sta.connect()

    local cnt = 0
    tmr.alarm(0, 2000, tmr.ALARM_AUTO, function()
        if (wifi.sta.getip() == nil) and (cnt < 20) then
            print("Trying Connect to Router, Waiting...")
            cnt = cnt + 1
        else
            tmr.unregister(0)
            if (cnt < 20) then
                print("Config done, IP is " .. wifi.sta.getip())
                server:start()
                srv = net.createServer(net.UDP)
                srv:on("receive", function(_, _, _, ip)
                    tmr.unregister(1)
                    socket.connect(ip)
                    srv:close()
                end)
                tmr.alarm(1, 120000, tmr.ALARM_SINGLE, function()
                    print("No broadcast message received within 120s")
                    srv:close()
                    startConfigAP()
                end)
                srv:listen(1990)
            else
                print("Wifi setup time more than 40s.")
                startConfigAP()
            end
            cnt = nil;

            collectgarbage();
        end
    end)
    return nil
end

function station.saveCredentials(params)
    if params.ssid and params.pwd and file.open("wifi.json", "w+") then
        file.writeline(cjson.encode(params))
        file.close()
        node.restart()
    end
end
