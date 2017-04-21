input = {}
local inputs = { [constants.OYO.inputPins[1]] = 1, [constants.OYO.inputPins[2]] = 1, [constants.OYO.inputPins[3]] = 1, [constants.OYO.inputPins[4]] = 1 }

local subscriber = { notify = nil }

function input.initialize()
    for pin, level in pairs(inputs) do
        gpio.mode(pin, gpio.INPUT, level)
        detectChanges()
    end
end

function detectChanges()
    tmr.alarm(6, 500, tmr.ALARM_AUTO, function()
        for pin, level in pairs(inputs) do
            if inputs[pin] ~= gpio.read(pin) then
                inputs[pin] = gpio.read(pin)
                if subscriber.notify then
                    subscriber.notify({ pin = pin, level = level })
                end
            end
        end
    end)
end

function input.subscribe(callback)
    subscriber.notify = callback
end

function input.unsubscribe()
    subscriber.notify = nil
end
