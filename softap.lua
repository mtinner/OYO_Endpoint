softap = {}

function softap.start(callback)
    wifi.setmode(wifi.SOFTAP)

    local cfg

    cfg = {
        ip = "192.168.4.1",
        netmask = "255.255.255.0",
        gateway = "192.168.4.1"
    }
    wifi.ap.setip(cfg)
    cfg = nil
    cfg = {
        ssid = "OYO" .. node.chipid(),
        save = false
    }
    wifi.ap.config(cfg)
    cfg = nil
    helper.setState(constants.states.WAITING_FOR_AP)
    softap.checkState(callback)
end

-- todo check
function softap.checkState(callback)
    tmr.alarm(0, 2000, tmr.ALARM_SINGLE, function()
        if wifi.ap.getip() then

            print("\r\n********************")
            print("OYO IP:\r\n", wifi.ap.getip())
            print("OYO" .. node.chipid())
            helper.setState(constants.states.AP_STARTED)
        end
        callback()
    end)
end
