require('softap')
require('server')
require('station')

if not station:start() then
    print('Could not connect')
    softap:start()
    server:start()
end
