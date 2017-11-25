function show_modal()

  local vb = renoise.ViewBuilder()
  
  local num_samples_valuebox = vb:valuebox {
    min = 4,
    max = 65536,
    value = 168
  }
  
  local column = vb:column {
    vb:text {
      text = "Number of Samples"
    },
    
    num_samples_valuebox
  }
  
  local wave = renoise.app():show_custom_prompt("Generate Wave", column, wave_types)
  num_samples = num_samples_valuebox.value
  generate(wave)
  
end
