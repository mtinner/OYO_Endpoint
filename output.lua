output = {}
local subscriber = { notify = nil }

function output.initialize()
    for i, io in ipairs(constants.OYO.ios) do
        gpio.mode(io.outputPin, gpio.OUTPUT)
        gpio.write(io.outputPin, gpio.LOW)
    end
end


-- TODO does not work anymore ouputPins does not exist
function output.setOutput(pin, value, toggle)
    if helper.hasArrayObjectValue(constants.OYO.ios, 'outputPin', pin) then
        if (value == gpio.LOW or value == gpio.HIGH) then
            if toggle then
                gpio.serout(pin, value, { 300000 }, 2)
                subscriber.notify({ event = constants.events.OUTPUT_CHANGE, outputPin = pin, outputLevel = value, inputPin = findInputPin(pin) })
            else
                gpio.write(pin, value)
                subscriber.notify({ event = constants.events.OUTPUT_CHANGE, outputPin = pin, outputLevel = gpio.read(pin), inputPin = findInputPin(pin) })
            end
        end
    end
end


function output.subscribe(callback)
    subscriber.notify = callback
end

function output.unsubscribe()
    subscriber.notify = nil
end

function findInputPin(outputPin)
    for _, io in pairs(constants.OYO.ios) do
        if io.outputPin == outputPin then
            return io.inputPin
        end
    end
end
