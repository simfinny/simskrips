--[[
todo:
+ move wave selection from buttons to popup
+ consolidate sq / pulse options and add pulse width control (0.1-99.99)
+ different colors of noise
--]]


-- parameters
-------------------------------------------------------------------
sine = "Sine"
triangle = "Triangle"
square = "Square"
pulse = "Pulse"
saw = "Saw"
ramp = "Ramp"
random = "Random"

wave_types = {sine, triangle, square, pulse, saw, ramp, random}
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

renoise.tool():add_menu_entry {
  name = "Sample Editor:Generate Wave...",
  invoke = function() show_modal() end 
}
