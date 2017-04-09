softap = {}

function softap.start()
    wifi.setmode(wifi.SOFTAP)

    local cfg

    cfg = {
        ip = "192.168.0.1",
        netmask = "255.255.255.0",
        gateway = "192.168.0.1"
    }
    wifi.ap.setip(cfg)

    cfg = {
        ssid = "OYO" .. node.chipid()
    }
    wifi.ap.config(cfg)

    print("\r\n********************")
    print("OYO IP:\r\n", wifi.ap.getip())

    cfg = nil
end
