local laptop = false
do
    local f = io.open('/usr/bin/ibam', 'r')
    if(f) then
        laptop = true
        f:close()
    end
end


--=============================
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- vicious widgets library
--require"vicious"
local runonce = require("runonce")

--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients.  Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   --{{{
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if table.getn(ctags) == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn_with_shell(cmd)
   --awful.util.spawn(cmd)
end
--}}}

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
local configdir = awful.util.getdir("config")
beautiful.init(configdir .. "/theme.lua")
local icons = "/usr/share/icons/hicolor/"
local icons16 = icons .. "16x16/"

-- run at startup
for _, c in next, {
    'wmname LG3D',
    'xmodmap ~/.Xmodmap',
    'xscreensaver -no-splash',
    'ibus-daemon --xim',
    laptop and 'wicd-client',
    laptop and 'ibamtray',
    'sylpheed',
    'pidgin',
    'dualscreen.sh; #cairo-compmgr',
} do
    if(c) then
        runonce.run(c)
    end
end

for _, c in next, {
    'urxvtd -q -o -f',
} do
    if(c)then
        awful.util.spawn(c)
    end
end

-- This is used later as the default terminal and editor to run.
terminal = 'urxvtc'
term1 = terminal
term2 = 'urxvt'
term3 = 'lilyterm'
--editor = os.getenv("EDITOR") or "vi"
editor = 'vim'
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

local FLT =  awful.layout.suit.floating
local TILE = awful.layout.suit.tile
local TILE_L =  awful.layout.suit.tile.left
local TILE_B =  awful.layout.suit.tile.bottom
local TILE_TOP =  awful.layout.suit.tile.top
local FAIR =  awful.layout.suit.fair
local FAIR_H =  awful.layout.suit.fair.horizontal
local MAX =  awful.layout.suit.max
local FULLSCREEN = awful.layout.suit.max.fullscreen
local MAGNIFIER =  awful.layout.suit.magnifier
local SPIRAL =  awful.layout.suit.spiral
local SPIRAL_DWINDLE = awful.layout.suit.spiral.dwindle
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    FLT,
    MAX,
    FULLSCREEN,
    TILE_B,
    TILE,
    MAGNIFIER
}

-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags = {
    -- names = { "☠", "⌥", "✇", "⌤", "⍜", "✣", "⌨", "⌘", "☕" },
   names  = { "风", "林", "火", "山",5, 6, 7 },
   layout = {TILE, MAX, MAGNIFIER, FLT, FLT, FLT, FLT}
}
 for s = 1, screen.count() do
     tags[s] = awful.tag(tags.names, s, tags.layout)
     awful.tag.setproperty(tags[s][5], "hide", 0.13)
     awful.tag.setproperty(tags[s][6], "hide",   true)
     awful.tag.setproperty(tags[s][7], "hide",   true)
 end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/myrc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "chromium", "chromium", configdir .. "/icons/chromium.png" },
                                    { "firefox", "firefox", configdir .. "/icons/firefox.png" },
                                    { "eclipse", "eclipse", configdir .. "/icons/eclipse.xpm" },
                                    { "inkscape", "inkscape", configdir .. "/icons/inkscape.png" },
                                    { "nitrogen", "nitrogen", configdir .. "/icons/nitrogen.png" },
                                    { "gajim", "gajim" },
                                    { "wmc2d", "wmc2d" },
                                    { "pidgin", "pidgin", configdir .. "/icons/pidgin.png" },
                                    { "terminal", terminal, configdir .. "/icons/terminal.png" },
                                    { "reboot", "sudo reboot", configdir .. "/icons/power_off.png"},
                                    { "halt", "sudo halt", configdir .. "/icons/power_off.png"}
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
local zh_numbers={"零","一","二","三","四","五","六","七","八","九",
   "十", "十一","十二","十三","十四","十五","十六","十七","十八","十九",
   "二十","二十一","二十二","二十三","二十四","二十五","二十六","二十七","二十八","二十九",
   "三十","三十一","三十二","三十三","三十四","三十五","三十六","三十七","三十八","三十九",
   "四十","四十一","四十二","四十三","四十四","四十五","四十六","四十七","四十八","四十九",
   "五十","五十一","五十二","五十三","五十四","五十五","五十六","五十七","五十八","五十九"
   }

local function zh_date(s)
    return zh_numbers[tonumber(os.date(s)) + 1]
end

local mytextclock = widget{type = "textbox"}
local mydate_timer = timer {timeout = 1}
local function mydate_update()
   os.setlocale("zh_CN.UTF8", "time")
   mytextclock.text = os.date("周%a %B")..  zh_date("%e").."日 "..  os.date("%H:%M:%S")
   os.setlocale("en_US.UTF8", "time")
end
mydate_update()
mydate_timer:add_signal("timeout", mydate_update)
mydate_timer:start()
--mytextclock = awful.widget.textclock({ align = "right" }," %Y年%d月%m日 %H:%M:%S %A", 1)

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({					  }, "Print",  function() awful.util.spawn("scrot -e 'mv $f ~/ 2>/dev/null'") end),
    --awful.key({ modkey,           }, "BackSpace", function() awful.util.spawn(term3) end),
    awful.key({ modkey,           }, "\\", function() awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then 
                client.focus:raise()
--                client.focus:swap(awful.client.getmaster()) 
            end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
                client.focus:swap(awful.client.getmaster()) 
            end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn(term2) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Control" }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey },            "q",     function () awful.util.spawn('dmenu-run') end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Run and Raise
    awful.key({ modkey, }, "Return", function () run_or_raise("urxvt -e tmuxat", { instance = "urxvt" }) end),
    awful.key({ modkey, }, "BackSpace", function () run_or_raise("", { name = "VIM", instance="urxvt" }) end),
    awful.key({ modkey, }, "e", function () run_or_raise("eclipse", { class = "Eclipse" }) end),
    awful.key({ modkey, }, "p", function () run_or_raise("sylpheed", { class = "Sylpheed" }) end),
    awful.key({ modkey, }, "v", function () run_or_raise("startxp", { class = "VirtualBox" }) end),
    awful.key({ modkey, }, "'", function () run_or_raise("pidgin", { class = "Pidgin" }) end),
    awful.key({ modkey, }, "\"", function () run_or_raise("pidgin", { class = "Pidgin" }) end),
    awful.key({ modkey, }, "`", function () run_or_raise("firefox", { instance = "Navigator" }) end),
    awful.key({ modkey, }, "~", function () run_or_raise("firefox", { instance = "Navigator" }) end)
--    awful.key({ modkey, }, "w", function () run_or_raise("google-chrome", { name = "Google Chrome" }) end),

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey            }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "a",      function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey,           }, "i",
        function (c)
            local geom = c:geometry()

            local t = ""
            if c.class then t = t .. "Class: " .. c.class .. "\n" end
            if c.instance then t = t .. "Instance: " .. c.instance .. "\n" end
            if c.role then t = t .. "Role: " .. c.role .. "\n" end
            if c.name then t = t .. "Name: " .. c.name .. "\n" end
            if c.type then t = t .. "Type: " .. c.type .. "\n" end
            if geom.width and geom.height and geom.x and geom.y then
                t = t .. "Dimensions: " .. "x:" .. geom.x .. " y:" .. geom.y .. " w:" .. geom.width .. " h:" .. geom.height
            end

            naughty.notify({
                text = t,
                timeout = 30,
            })

        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
--                     tag = tags[mouse.screen][5],
                     switchtotag = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
--    { rule = { name = "urxvt" }, properties = { tag = tags[screen.count()][1], switchtotag = true }},
--    { rule = { name = "VIM" }, properties = { tag = tags[screen.count()][2], switchtotag = true }},
--    { rule = { name = "cmus" }, properties = { tag = tags[screen.count()][5], switchtotag = true }},
    { rule = { instance = "Eclipse" }, properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { class = "Namoroka" }, properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { instance = "Navigator" }, properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { instance = "firefox" }, properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { instance = "Pidgin" }, properties = { tag = tags[screen.count()][3], switchtotag = true }},
    { rule = { instance = "Pidgin", name = "Buddy List" }, properties = { floating = true }},
    { rule = { class = "Sylpheed" }, properties = { tag = tags[1][2], switchtotag = true, minimized = true }},
    { rule = { class = "VirtualBox" }, properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
	{ rule = { class = "smplayer" },
	  properties = { floating = true} },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    --[[
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)
    ]]--

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)
client.add_signal("focus", function(c) 
    c.border_color = beautiful.border_focus
--    c:swap(awful.client.getmaster()) 
end)
client.add_signal("unfocus", function(c) 
    c.border_color = beautiful.border_normal 
end)
-- }}}
