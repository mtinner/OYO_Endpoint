input = {}

local inputs = { 1, 3, 5, 7 }

function input.initialize()
    for i, pin in ipairs(inputs) do
        gpio.mode(pin, gpio.INPUT, gpio.PULLDOWN)
        gpio.trig(pin, 'both', pinTrig(pin))
    end
end

function pinTrig(pin)
    local affectedPin = pin
    return function(level, when)
        print('trig')
        print(affectedPin)
        print(level)
    end
end
