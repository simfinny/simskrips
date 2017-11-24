-- parameters
-------------------------------------------------------------------
sine = "Sine"
triangle = "Triangle"
square = "Square"
pulse = "Pulse"
saw = "Saw"
random = "Random"

wave_types = {sine, triangle, square, pulse, saw, random}

for i = 1, #wave_types, 1 do
  print(wave_types[i])
end

selected_wave = 1
num_samples = 168

-- sample rate and bit depth are currently hard-coded
sample_rates = {44100,96000}
selected_sample_rate = 1
bit_depths = {16,32}
selected_bit_depth = 2
-------------------------------------------------------------------
-- require
-------------------------------------------------------------------
require "generator"
require "ui"
-------------------------------------------------------------------

show_modal()

--[[
renoise.tool():add_menu_entry {
  name = "Sample Editor:Generate Wave...",
  invoke = function() show_modal() end 
}--]]
