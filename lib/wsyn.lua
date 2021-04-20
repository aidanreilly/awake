--- w/syn lib for norns
-- 0.1 @oootini, with thanks to @vicimity who wrote the w/syn code replicated here in Less Concepts 3.

-- w/syn variables
local pset_wsyn_curve = 0
local pset_wsyn_ramp = 0
local pset_wsyn_fm_index = 0
local pset_wsyn_fm_env = 0
local pset_wsyn_fm_ratio_num = 0
local pset_wsyn_fm_ratio_den = 0
local pset_wsyn_lpg_time = 0
local pset_wsyn_lpg_symmetry = 0
local pset_wsyn_vel = 0

--w/syn support

function wsyn_add_params()
  params:add_group("w/syn",12)
  params:add {
    type = "option",
    id = "wsyn_ar_mode",
    name = "AR mode",
    options = {"off", "on"},
    default = 2,
    action = function(val) 
      crow.send("ii.wsyn.ar_mode(".. (val-1) ..")")
    end
  }
  params:add {
    type = "control",
    id = "wsyn_vel",
    name = "Velocity",
    controlspec = controlspec.new(0, 5, "lin", 0, 2, "v"),
    action = function(val) 
      pset_wsyn_vel = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_curve",
    name = "Curve",
    controlspec = controlspec.new(-5, 5, "lin", 0, 0, "v"),
    action = function(val) 
      crow.send("ii.wsyn.curve(" .. val .. ")") 
      pset_wsyn_curve = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_ramp",
    name = "Ramp",
    controlspec = controlspec.new(-5, 5, "lin", 0, 0, "v"),
    action = function(val) 
      crow.send("ii.wsyn.ramp(" .. val .. ")") 
      pset_wsyn_ramp = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_fm_index",
    name = "FM index",
    controlspec = controlspec.new(0, 5, "lin", 0, 0, "v"),
    action = function(val) 
      crow.send("ii.wsyn.fm_index(" .. val .. ")") 
      pset_wsyn_fm_index = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_fm_env",
    name = "FM env",
    controlspec = controlspec.new(-5, 5, "lin", 0, 0, "v"),
    action = function(val) 
      crow.send("ii.wsyn.fm_env(" .. val .. ")") 
      pset_wsyn_fm_env = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_fm_ratio_num",
    name = "FM ratio numerator",
    controlspec = controlspec.new(1, 20, "lin", 1, 2),
    action = function(val) 
      crow.send("ii.wsyn.fm_ratio(" .. val .. "," .. params:get("wsyn_fm_ratio_den") .. ")") 
      pset_wsyn_fm_ratio_num = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_fm_ratio_den",
    name = "FM ratio denominator",
    controlspec = controlspec.new(1, 20, "lin", 1, 1),
    action = function(val) 
      crow.send("ii.wsyn.fm_ratio(" .. params:get("wsyn_fm_ratio_num") .. "," .. val .. ")") 
      pset_wsyn_fm_ratio_den = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_lpg_time",
    name = "LPG time",
    controlspec = controlspec.new(-5, 5, "lin", 0, 0, "v"),
    action = function(val) 
      crow.send("ii.wsyn.lpg_time(" .. val .. ")") 
      pset_wsyn_lpg_time = val
    end
  }
  params:add {
    type = "control",
    id = "wsyn_lpg_symmetry",
    name = "LPG symmetry",
    controlspec = controlspec.new(-5, 5, "lin", 0, 0, "v"),
    action = function(val) 
      crow.send("ii.wsyn.lpg_symmetry(" .. val .. ")") 
      pset_wsyn_lpg_symmetry = val
    end
  }
  params:add{
    type = "trigger",
    id = "wsyn_pluckylog",
    name = "Pluckylogger >>>",
    action = function()
      params:set("wsyn_curve", math.random(-40, 40)/10)
      params:set("wsyn_ramp", math.random(-5, 5)/10)
      params:set("wsyn_fm_index", math.random(-50, 50)/10)
      params:set("wsyn_fm_env", math.random(-50, 40)/10)
      params:set("wsyn_fm_ratio_num", math.random(1, 4))
      params:set("wsyn_fm_ratio_den", math.random(1, 4))
      params:set("wsyn_lpg_time", math.random(-28, -5)/10)
      params:set("wsyn_lpg_symmetry", math.random(-50, -30)/10)
    end
  }
  params:add{
    type = "trigger",
    id = "wsyn_randomize",
    name = "Randomize all >>>",
    action = function()
      params:set("wsyn_curve", math.random(-50, 50)/10)
      params:set("wsyn_ramp", math.random(-50, 50)/10)
      params:set("wsyn_fm_index", math.random(0, 50)/10)
      params:set("wsyn_fm_env", math.random(-50, 50)/10)
      params:set("wsyn_fm_ratio_num", math.random(1, 20))
      params:set("wsyn_fm_ratio_den", math.random(1, 20))
      params:set("wsyn_lpg_time", math.random(-50, 50)/10)
      params:set("wsyn_lpg_symmetry", math.random(-50, 50)/10)
    end
  }
  params:add{
    type = "trigger",
    id = "wsyn_init",
    name = "Init",
    action = function()
      params:set("wsyn_curve", pset_wsyn_curve)
      params:set("wsyn_ramp", pset_wsyn_ramp)
      params:set("wsyn_fm_index", pset_wsyn_fm_index)
      params:set("wsyn_fm_env", pset_wsyn_fm_env)
      params:set("wsyn_fm_ratio_num", pset_wsyn_fm_ratio_num)
      params:set("wsyn_fm_ratio_den", pset_wsyn_fm_ratio_den)
      params:set("wsyn_lpg_time", pset_wsyn_lpg_time)
      params:set("wsyn_lpg_symmetry", pset_wsyn_lpg_symmetry)
      params:set("wsyn_vel", pset_wsyn_vel)
    end
  }
  params:hide("wsyn_init")
end

local function play_wsyn_note(note)
  crow.send("ii.wsyn.play_note(".. (note-48)/12 ..", " .. pset_wsyn_vel .. ")")
end