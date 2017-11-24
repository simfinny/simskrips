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
    if (i % 2 == 0) then
      return -1
    else
      return 1
    end
  end
  
  generate_core(buf, value_func)
  
end

local function generate_square(buf)

  local value_func = function(i)
    local halfway = num_samples / 2
    if (i > halfway) then
      return 1
    else
      return -1
    end
  end
  
  generate_core(buf,value_func)
  
end

local function generate_pulse(buf)

  local value_func = function(i)
    local one_fourth = num_samples / 4
    if (i > one_fourth) then
      return 1
    else  
      return -1
    end
  end
  
  generate_core(buf, value_func)
  
end

local function generate_saw(buf)

  local value_func = function(i)
    local increment = 2 * num_cycles / num_samples
    return 0.5*increment*(i - 1) - 1;
  end
  
  generate_core(buf,value_func)
  
end

local function generate_random(buf)

  local value_func = function(i)
    return 2*math.random() - 1
  end
  
  generate_core(buf, value_func)
  
end

function generate(wave)

  local index = renoise.song().selected_instrument_index
  local instrument = renoise.song().instruments[index]
  local sample_index = renoise.song().selected_sample_index
  local sample = instrument.samples[sample_index]
  local buf = sample.sample_buffer
  local sample_rate = sample_rates[selected_sample_rate]
  local bit_depth = bit_depths[selected_bit_depth]

  buf:create_sample_data(sample_rate,bit_depth,1,num_samples)
  buf:prepare_sample_data_changes()
  
  if (wave == sine) then
    generate_sine(buf)
    
  elseif (wave_types[selected_wave] == triangle) then
    generate_triangle(buf)
    
  elseif (wave_types[selected_wave] == square) then
    generate_square(buf)
    
  elseif (wave_types[selected_wave] == pulse) then
    generate_pulse(buf)
    
  elseif (wave_types[selected_wave] == saw) then
    generate_saw(buf)
    
  elseif (wave_types[selected_wave] == random) then
    generate_random(buf)
    
  end
  
  buf:finalize_sample_data_changes()
  
end
