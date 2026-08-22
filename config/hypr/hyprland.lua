-- esta es mi configuracion de hyprland

hl.monitor({ -- monitor config 
  output = "eDP-1",
  mode = "preferred",
  position = "0x0",
  scale = 1,
  transform = 0,
})

hl.monitor({ --hdmi monitor config 
  output = "HDMI-A-3",
  mode = "1920x1080@60",
  position = "1920x0",
  scale = 1,
})


hl.on("hyprland.start", function () -- init aplications
    hl.exec_cmd("terminal")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync")
    hl.exec_cmd("udiskie")
end)


hl.config({
    animations = {
        enabled = false,
    }
})



hl.config ({
	general = {
		gaps_in = 5,
		gaps_out = 20,
  	},
  	decoration = {
    		blur = {
      		enabled = true,
    		},
  	},
})

hl.config({
	input = {
      		kb_layout = "us",
      		kb_variant = "intl",
      		force_no_accel = true,

      		touchpad = {
        		natural_scroll = true,
        		scroll_factor = 0.5
      		}
    }
    
})



hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

local mainMod = "SUPER"

-- aplications shortcuts 
hl.bind("PRINT ", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Images/Screenshots/Screenshot-$(date +%F_%T).png")) -- Screenshot
hl.bind(mainMod .. " + SHIFT + W ",hl.dsp.exec_cmd("pkill waybar && waybar")) --Reboot waybar
hl.bind(mainMod .. " + W ", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")) -- minimize waybar
hl.bind(mainMod .. " + N ", hl.dsp.exec_cmd("swaync-client -t -sw")) -- swaync
hl.bind(mainMod .. " + L ", hl.dsp.exec_cmd("hyprlock")) -- lock 

 -- hl.bind(mainMod .. " + A ", hl.dsp.exec_cmd("gnome-calculator"))
hl.bind(mainMod .. " + Z ", hl.dsp.exec_cmd("zen"))
hl.bind(mainMod .. " + D ", hl.dsp.exec_cmd("discord"))
hl.bind(mainMod .. " + Q ", hl.dsp.exec_cmd("kitty --hold fastfetch"))
hl.bind(mainMod .. " + E ", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + R ",hl.dsp.exec_cmd(" wofi --show drun"))


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- experience shortcuts

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- switch workspaces 

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- special workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local window = hl.dsp.window -- EDIT: Forgot this in initial post >.<
local mainMod = 'SUPER' -- EDIT: Added mainMod as a var to match OPs setup
local left = { x = -10, y = 0, relative = true }
local down = { x = 0, y = 10, relative = true }
local up = { x = 0, y = -10, relative = true }
local right = { x = 10, y = 0, relative = true }

local function opts(direction)
  return { description = 'Resize the active window ' .. direction, repeating = true }
end

hl.bind(mainMod .. ' + ALT + h', window.resize(left), opts('left'))
hl.bind(mainMod .. ' + ALT + j', window.resize(down), opts('down'))
hl.bind(mainMod .. ' + ALT + k', window.resize(up), opts('up'))
hl.bind(mainMod .. ' + ALT + l', window.resize(right), opts('right'))



-- Devices config

--local trackpad = false,
--
hl.device({
	name = "logitech-g502-hero-gaming-mouse",
	sensitivity = "-0.75",

	})

hl.device({
	name = "synps/2-synaptics-touchpad",
	sensitivity = "1.0",
	enabled = true

    	})

  -- hl.device({
    --  name = "synps/2-synaptics-touchpad",
      --enabled = true
   -- })
--end 



-- windowrules 

hl.window_rule({
  name = "float-steam",
  match = {
    class = "steam"

  },
  float = true,
  center = true,
  size = {"monitor_w * 0.5", "monitor_h * 0.5"},
  
})

hl.window_rule({
  name = "float-discord", 
  match = {
    class = "discord",
  }
})

hl.window_rule({
  name = "float-dolphin",
  match = {
    class = "org.kde.dolphin",
  },
  center = true,
  float = true,
  size = {"1200","800"},
})

-- hl.window_rule({
--  --ignore maximize
 -- match = {
--    class =  ".*",
-- },
--  suppress_event = "fullscreen",
--})
