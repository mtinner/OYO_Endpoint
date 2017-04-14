output = {}

local outputs = { 0, 2, 6, 8 }

function output.initialize()
    for i, pin in ipairs(outputs) do
        gpio.mode(pin, gpio.OUTPUT)
        gpio.write(pin, gpio.LOW)
    end
end


function setOutput(pin, value)
    if helper:hasArrayValue(output, pin) and (value == gpio.LOW or value == gpio.HIGH) then
        gpio.write(pin, value)
    end
end
