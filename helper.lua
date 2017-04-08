helper = {}

function helper.getParams(self, request)
    params = {}
    for k, v in string.gmatch(request, "[\n|&]([^&=\n ;]+)=([^=;\n&]+)") do
        params[k] = v
    end
    return params
end
