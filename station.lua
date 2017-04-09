station = {}

function station.start()

    if file.open("wifi.json", "r") then
        wifi.setmode(wifi.STATION)
        --  print(file.readline())
        local wificonfig
        while true
        do
            local line
            line = file.readline()
            if (line == nil) then
                file.close()
                break
            end
            print(cjson.decode(line))
            wificonfig = cjson.decode(line)
        end

        if not wificonfig.ssid or not wificonfig.pwd then
            return nil
        end
        
        wificonfig.auto = false

        wifi.sta.config(wificonfig)
        
        wifi.sta.connect()

        local cnt = 0
        tmr.alarm(3, 2000, 1, function()
            if (wifi.sta.getip() == nil) and (cnt < 20) then
                print("Trying Connect to Router, Waiting...")
                cnt = cnt + 1
            else
                tmr.stop(3)
                if (cnt < 20) then print("Config done, IP is " .. wifi.sta.getip())
                else print("Wifi setup time more than 40s, Please verify wifi.sta.config() function. Then re-download the file.")
                end
                cnt = nil;
                collectgarbage();
            end
        end)



        return true
    end
    return nil
end
