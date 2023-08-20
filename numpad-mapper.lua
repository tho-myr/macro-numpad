-- These 2 lines will minimize the script automatically at launch.
lmc.minimizeToTray = true
lmc_minimize()

-- assign name to external keyboard
lmc_device_set_name ('MacroKeyboard', '1AEA1415');

-- assign button ids with the resulting keys/hotkeys
profile_numpad_inactive = {
  a = {id = 111, result = '%{F13}'},
  b = {id = 106, result = '%{F14}'},
  c = {id = 8, result = '%{F15}'},
  d = {id = 36, result = '%{F16}'},
  e = {id = 38, result = '%{F17}'},
  f = {id = 33, result = '%{F18}'},
  g = {id = 109, result = '%{F19}'},
  h = {id = 37, result = '%{F20}'},
  i = {id = 12, result = '%{F21}'},
  j = {id = 39, result = '%{F22}'},
  k = {id = 107, result = '%{F23}'},
  l = {id = 35, result = '%{F24}'},
  m = {id = 40, result = '{F13}'},
  n = {id = 34, result = '{F14}'},
  o = {id = 45, result = '{F15}'},
  p = {id = 46, result = '{F16}'},
  enter = {id = 13, result = '{ENTER}'}
}
profile_numpad_active = {
  a = {id = 111, result = '^{F13}'},
  b = {id = 106, result = '^{F14}'},
  c = {id = 8, result = '^{F15}'},
  d = {id = 103, result = '^{F16}'},
  e = {id = 104, result = '^{F17}'},
  f = {id = 105, result = '^{F18}'},
  g = {id = 109, result = '^{F19}'},
  h = {id = 100, result = '^{F20}'},
  i = {id = 101, result = '^{F21}'},
  j = {id = 102, result = '^{F22}'},
  k = {id = 107, result = '^{F23}'},
  l = {id = 97, result = '^{F24}'},
  m = {id = 98, result = '{F17}'},
  n = {id = 99, result = '{F18}'},
  o = {id = 96, result = '{F19}'},
  p = {id = 110, result = '{F20}'},
  enter = {id = 13, result = '{ENTER}'}
}
-- setup profiling
current_profile_id = 1
profile_switch_button = 144
profiles = { profile_numpad_inactive, profile_numpad_active }

-- define callback for whole device
lmc_set_handler('MacroKeyboard',function(button, direction)
  --if (direction == 0) then return end  -- ignore up
  if (direction == 1) then return end  -- ignore down

  if (button == profile_switch_button) then
    print('Previously selected profile id: ' .. getCurrentProfileId())
    if (isProfileValid()) then
      switchProfile()
    else
      print(getCurrentProfileId() .. 'is an invalid profile id')
      current_profile_id = 1
      print('Profile id was set back to ' .. getCurrentProfileId())
    end
    print('Currently selected profile id: ' .. getCurrentProfileId())
  else
    local currentProfile = profiles[getCurrentProfileId()]
    for _, v in pairs(currentProfile) do
      if (button == v.id) then
        lmc_send_keys(v.result)
        print(v.id .. ' -> ' .. v.result)
        return
      end
    end
    print('Not yet assigned: ' .. button)
    print('Button ' .. button .. ' may not be assigned due to asynchronous behaviour of this program and the numpad.')
    switchProfile()
    print('Profile was set to ' .. getCurrentProfileId() .. ', which may result in synchronizing numpad and program.')
  end

end)

function isProfileValid()
  return (getCurrentProfileId() > 0) and (getCurrentProfileId() < 3)
end

function getCurrentProfileId()
  return current_profile_id;
end

function switchProfile()
  if     (current_profile_id == 1) then current_profile_id = 2
  elseif (current_profile_id == 2) then current_profile_id = 1
  end
end
