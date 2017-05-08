input = {}
local inputs = { [constants.OYO.ios[1].inputPin] = 0, [constants.OYO.ios[2].inputPin] = 0, [constants.OYO.ios[3].inputPin] = 0, [constants.OYO.ios[4].inputPin] = 0 }

local subscriber = { notify = nil }

function input.initialize()
    for pin, level in pairs(inputs) do
        gpio.mode(pin, gpio.INPUT)
        gpio.write(pin, level)
        detectChanges()
    end
end

function detectChanges()
    tmr.alarm(6, 500, tmr.ALARM_AUTO, function()
        for pin, level in pairs(inputs) do
            if inputs[pin] ~= gpio.read(pin) then
                inputs[pin] = gpio.read(pin)
                if subscriber.notify then
                    subscriber.notify({ event = constants.events.CHANGE, inputPin = pin, inputLevel = gpio.read(pin) })
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

function input.getState()
    local state = {}
    for pin, level in pairs(inputs) do
        table.insert(state, { inputLevel = gpio.read(pin), inputPin = pin })
    end
    return { event = constants.events.INITIAL, ios = state }
end
