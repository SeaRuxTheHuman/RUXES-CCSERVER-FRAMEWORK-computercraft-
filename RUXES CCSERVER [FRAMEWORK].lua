--RUX'S CCSERVER FRAMEWORK

--packet structure $TARGET;SENDER$<TYPE;METHOD;SUB_DATA(unkown var count)>
local psudo_packet = "##TARGET;SENDER##<TYPE;METHOD;SUB_DATA(unkown var count)"

QUE = {}
    QUE.STREAMS = {}
    QUE.REQUESTS = {}

TYPES = {}
    function TYPES.RESPONSE()
        --function for special handling
        --of the DIRECT message type.
    end

METHODS = {}
    METHODS.OPEN = {}
        --methods of OPEN message type
    METHODS.DIRECT = {}
        --methods of DIRECT message type
        function METHODS.DIRECT.HELLO()
            textutils.slowPrint("Hello World")
        end
    METHODS.REQUEST = {}
        --methods of REQUEST message type
    METHODS.RESPONSE = {}
        --methods of RESPONSE message type
    METHODS.STREAM = {}
        --methods of STREAM message type

nio = {} --Network Input/Output - nio
    nio.hardware = {}
        function nio.hardware:setupModem(port) --to make porting to OC easier
            self.modem = peripheral.find("modem")
            return self.modem.open(port)
        end
        function nio.hardware.getSignal() --to make porting to OC easier
            return{os.pullEvent("modem_message")}
        end
        function nio.hardware.breakdown(event_table)
            return event_table[5], {event_table[3],event_table[4],event_table[6]}
        end
    function nio.isPacket(packet_string)

        if string.find(packet_string,"<") and string.find(packet_string,">") and string.find(packet_string,"#") then
            return true
        end
    end

    function nio.getParties(full_message)
        local base = full_message
        local sender = base:sub(base:find("##")+2,base:find(";")-1)
        base = base:sub(base:find(";"), #base)
        local reciever = base:sub(base:find(";")+1,base:find("##")-1)
        local packet_message = base:sub(base:find("##")+2, #base)
        return {sender, reciever}, packet_message
    end
    function nio.getPacket(packet_string)
        local output = {}
        local base = packet_string:sub(2,#packet_string)
        repeat
            local splitter = base:find(";")
            if not splitter then splitter = #base end
            local data = base:sub(1,splitter-1)
            table.insert(output,data)
            base = base:sub(splitter+1, #base)
        until #base <= 1
        return output
    end

    function nio.sort(package_table, parties_table, hardware_table)
        if TYPES[package_table[1]] then
            TYPES[package_table[1]](package_table, parties_table, hardware_table)
            --if thares a special case for that message type, use that
        elseif METHODS[package_table[1]] then
            METHODS[package_table[1]][package_table[2]](package_table, parties_table, hardware_table)
            --otherwise run the associated method directly, if said method exists

        else
            printError('invalid type')
            --print an error if the method does not exist (debug only)
        end
    end

local function main()
    nio.hardware:setupModem(1) --setup modem on port 1
    while true do
        local event_table = nio.hardware.getSignal() --get table containing 'event' data
        local message, hardware_table = nio.hardware.breakdown(event_table)
        if nio.isPacket(message) then
            local parties_table, packet_info = nio.getParties(message)
            local packet_table = nio.getPacket(packet_info)
            nio.sort(packet_table, parties_table, hardware_table)
        end
    end
end


main()
