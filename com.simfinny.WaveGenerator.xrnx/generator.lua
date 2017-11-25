local function generate_core(buf, sample_value_func)

  for i = 1, num_samples, 1 do
    local sample_value = sample_value_func(i)
    buf:set_sample_data(1,i,sample_value)
  end
  
end

local function generate_sine(buf)

  local value_func = function(i)
    local increment = math.pi * 2 / num_samples  
    return math.sin(increment * (i - 1))
  end
  
  generate_core(buf, value_func)
  
end

local function generate_triangle(buf)

  local value_func = function(i)
    local increment = 2 / num_samples
    local halfway = num_samples / 2
    if (i <= halfway / 2) then
      return 2*increment*(i - 1)
    elseif (i > halfway / 2 and i <= 3 * halfway / 2) then
      return -2*increment*(i - 1) + 2
    else
      return 2*increment*(i - 1) - 4
    end
  end
  
  generate_core(buf, value_func)
  
end

local function generate_square(buf)

  local value_func = function(i)
    local halfway = num_samples / 2
    if (i > halfway) then
      return -1
    else
      return 1
    end
  end
  
  generate_core(buf,value_func)
  
end

local function generate_pulse(buf)

  local value_func = function(i)
    local one_fourth = num_samples / 4
    if (i > one_fourth) then
      return -1
    else  
      return 1
    end
  end
  
  generate_core(buf, value_func)
  
end

local function generate_saw(buf)

  local value_func = function(i)
    local increment = 2 / num_samples
    return increment*(i - 1) - 1;
  end
  
  generate_core(buf,value_func)
  
end

local function generate_ramp(buf)

  local value_func = function(i)
    local increment = 2 / num_samples
    return -increment*(i-1)+1
  end
  
  generate_core(buf, value_func)

end

local function generate_random(buf)

  local value_func = function(i)
    return 2*math.random() - 1
  end
  
  generate_core(buf, value_func)
  
end

function generate(wave)

  if (wave == "Cancel") then
    return
  end

  local index = renoise.song().selected_instrument_index
  local instrument = renoise.song().instruments[index]
  local sample_index = renoise.song().selected_sample_index
  if (sample_index == nil or sample_index == 0) then
    instrument:insert_sample_at(1)
    sample_index = 1
  end
  local sample = instrument.samples[sample_index]
  local buf = sample.sample_buffer
  local sample_rate = sample_rates[selected_sample_rate]
  local bit_depth = bit_depths[selected_bit_depth]

  buf:create_sample_data(sample_rate,bit_depth,1,num_samples)
  buf:prepare_sample_data_changes()
  
  if (wave == sine) then
    generate_sine(buf)
    
  elseif (wave == triangle) then
    generate_triangle(buf)
    
  elseif (wave == square) then
    generate_square(buf)
    
  elseif (wave == pulse) then
    generate_pulse(buf)
    
  elseif (wave == saw) then
    generate_saw(buf)
    
  elseif (wave == ramp) then
    generate_ramp(buf)
    
  elseif (wave == random) then
    generate_random(buf)
    
  end
  
  buf:finalize_sample_data_changes()
  
end
