input = {}

local inputs = { 1, 3, 5, 7 }

function input.initialize()
    for i, pin in ipairs(inputs) do
        gpio.mode(pin, gpio.INPUT, gpio.PULLUP)
        gpio.trig(pin, 'none')
        gpio.trig(pin, 'both', pinTrig(pin))
        --gpio.trig(pin, 'down', pinTrig(pin))
    end
end

function pinTrig(pin)
    local affectedPin = pin
    return function(level, when)
        print('trig')
        print(affectedPin)
        print(level)
        local obj = { pin = pin, level = level }
        socket.send(obj)
    end
end
