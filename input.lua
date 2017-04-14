input = {}

local inputs = { 1, 3, 5, 7 }

function input.initialize()
    for i, pin in ipairs(inputs) do
        gpio.mode(pin, gpio.INPUT, gpio.PULLDOWN)
    end
end
