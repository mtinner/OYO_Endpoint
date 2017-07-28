constants = {}
constants.OYO = {
    chipId = node.chipid(),
    ios = {
        { inputPin = 0, outputPin = 5 },
        { inputPin = 1, outputPin = 6 },
        { inputPin = 2, outputPin = 7 },
        { inputPin = 3, outputPin = 8 }
    }
}
constants.events = {
    INITIAL = 'INITIAL',
    INPUT_CHANGE = 'INPUT_CHANGE',
    OUTPUT_CHANGE = 'OUTPUT_CHANGE'
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
