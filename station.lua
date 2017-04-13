station = {}

function station.start(self, wifiConfig)

    wifi.setmode(wifi.STATION)
    wifi.sta.config(wifiConfig)

    wifi.sta.connect()

    local cnt = 0
    tmr.alarm(0, 2000, 1, function()
        if (wifi.sta.getip() == nil) and (cnt < 20) then
            print("Trying Connect to Router, Waiting...")
            cnt = cnt + 1
        else
            tmr.unregister(0)
            if (cnt < 20) then
                print("Config done, IP is " .. wifi.sta.getip())
                srv = net.createServer(net.UDP)
                srv:on("receive", function(s, c, p, i)
                    print(i)
                    print(c)
                    srv:close()
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
