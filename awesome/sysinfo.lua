-- local {{{
local io, string, math = io, string, math
local tostring = tostring
local type = type
local tonumber = tonumber
local print = print
local unpack = unpack
local select = select

module('sysinfo')
--}}}

-- APIs {{{
function getBatteryState()
    local state, full, curr, file, color
    file = io.open('/sys/class/power_supply/CMB1/charge_now', 'r')
    curr = tonumber(file:read'*a')
    file:close()

    file = io.open('/sys/class/power_supply/CMB1/charge_full_design', 'r')
    full = tonumber(file:read'*a')
    file:close()

    file = io.open('/sys/class/power_supply/CMB1/status', 'r')
    state = file:read'*a'
    file:close()

    local perc = curr/full
    local text = math.floor((math.min(1, perc)) * 100) .. '%'
    if(perc>0.7) then
        color = 'green'
    elseif(perc>0.3) then
        color = 'yellow'
    else
        color = 'red'
    end
    text = '<span color="' .. color ..'">' .. text .. '</span>'
    -- discharging
    if(state:match'Discharging') then
        text = text .. '(Discharging)'
    else
        if(perc>0.7) then 
            return ''
        end

    end

    return '<span color="green">' .. text .. '</span>'
end

function getVolume(cardid, device)
    cardid = cardid or 0
    device = device or 'default'
    local f = io.popen(string.format('amixer -c %s -D %s', tostring(cardid), device))

    local volume
    if(f) then
        for line in f:lines() do
            volume = line:match('^%s-Mono: Playback %d+ %[(%d+)%%%]')
            if(volume) then
                break
            end
        end
    end

    if(volume) then
        local r, g, b = colorGradient(1 - tonumber(volume)/100, unpack(defaultcolor))
        return toSpan(volume .. '%', r, g, b)
    else
        return 'ERR'
    end
end
--}}}

