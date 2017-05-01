constants = {}
constants.OYO = {
    chipId = node.chipid(),
    inputPins = { 1, 3, 5, 7 },
    outputPins = { 0, 2, 6, 8 }
}
constants.JsonHeader = 'Content-Type: application/json\r\n'
constants.states = {
    CONNECTING_WIFI = 0,
    WAITING_FOR_WIFI_CONNECTION = 1,
    MISSING_WIFI_CREDENTIALS = 2,
    WIFI_CONNECTED = 3,
    SERVER_STARTED = 10,
    WAITING_FOR_INTRODUCING = 4,
    INTRODUCED = 5,
    WAITING_WS_CONNECTION = 6,
    WS_CONNECTION_ESTABLISHED = 7,
    WS_CONNECTION_CLOSED = 8,
    START_AP = 9,
}
