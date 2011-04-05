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

-- Utils {{{
local defaultcolor = {
    1, 0, 0,
    1, 1, 0,
    0, 1, 0
}

local inf = math.huge
function colorGradient(perc, ...)
    -- Translate divison by zeros into 0, so we don't blow select.
    -- We check perc against itself because we rely on the fact that NaN can't equal NaN.
    if(perc ~= perc or perc == inf) then perc = 0 end

    if perc >= 1 then
        local r, g, b = select(select('#', ...) - 2, ...)
        return r, g, b
    elseif perc <= 0 then
        local r, g, b = ...
        return r, g, b
    end

    local num = select('#', ...) / 3
    local segment, relperc = math.modf(perc*(num-1))
    local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

function toHex(r, g, b)
    if type(r) == "table" then
        if r.r then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
    end
    return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

function toSpan(text, r, g, b)
    if(r and type(r) == 'number' and g and b) then
        r = toHex(r, g, b)
    end
    --print(text, r)
    return string.format("<span color='#%s'>%s</span>", r, text)
end
--}}}

-- APIs {{{
function getBatteryState()
    local state, full, curr, file
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

    local r, g, b = colorGradient(perc, unpack(defaultcolor))
    -- discharging
    if(state:match'Discharging') then
        text = '(Discharging)' .. text
        r, g, b = 1, 0, 0
    end

    return toSpan(text, r, g, b)
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

