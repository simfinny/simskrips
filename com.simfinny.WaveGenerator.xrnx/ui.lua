function show_modal()

  local vb = renoise.ViewBuilder()
  
  local num_samples_valuebox = vb:valuebox {
    min = 4,
    max = 65536,
    value = 168
  }
  
  local num_cycles_valuebox = vb:valuebox {
    min = 1,
    max = 256,
    value = 1
  }
  
  local column = vb:column {
    vb:text {
      text = "Number of Samples"
    },
    
    num_samples_valuebox,
    
    vb:text {
      text = "Number of Cycles"
    }
  }
  
  local wave = renoise.app():show_custom_prompt("Generate Wave", column, wave_types)
  
  generate(wave)
  
end
