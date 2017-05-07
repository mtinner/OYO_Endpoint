constants = {}
constants.OYO = {
    chipId = node.chipid(),
    inputPins = { 1, 3, 5, 7 },
    outputPins = { 0, 2, 6, 8 }
}
constants.events = {
    INITIAL = 'INITIAL',
    CHANGE = 'CHANGE'
}
constants.JsonHeader = 'Content-Type: application/json\r\n'
constants.states = {
    CONNECTING_WIFI = 0,
    WAITING_FOR_WIFI_CONNECTION = 1,
    MISSING_WIFI_CREDENTIALS = 2,
    WIFI_CONNECTED = 3,
    SERVER_STARTED = 4,
    WAITING_FOR_INTRODUCING = 5,
    INTRODUCED = 6,
    INTRODUCTION_FAILED = 90,
    WAITING_WS_CONNECTION = 8,
    WS_CONNECTION_ESTABLISHED = 9,
    WAITING_FOR_AP = 10,
    AP_STARTED = 11,
    WS_CONNECTION_CLOSED = 91,
    TIMEOUT = 92,
}
constants.RETRY_THRESHOLD = 12
