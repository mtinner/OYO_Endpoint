output = {}

function output.initialize()
    for i, pin in ipairs(constants.OYO.outputPins) do
        gpio.mode(pin, gpio.OUTPUT)
        gpio.write(pin, gpio.LOW)
    end
end


function output.setOutput(pin, value, toggle)
    if helper.hasArrayValue(constants.OYO.outputPins, pin) then
        if (value == gpio.LOW or value == gpio.HIGH) then
            if toggle then
                gpio.serout(2, value, { 300000 }, 2)
            else
                gpio.write(pin, value)
            end
        end
        gpio.write(pin, value)
    end
end
