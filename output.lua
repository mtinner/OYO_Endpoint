output = {}

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
            else
                gpio.write(pin, value)
            end
        end
    end
end
