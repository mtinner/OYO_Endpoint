station = {}

function station.start(self, wifiConfig, failureCallback)

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
            if (cnt < 20) then print("Config done, IP is " .. wifi.sta.getip())
            else
                print("Wifi setup time more than 40s.")
                failureCallback()
            end
            cnt = nil;

            collectgarbage();
        end
    end)
    return nil
end
