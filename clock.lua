term.clear()
term.setCursorPos(1,1)

local function formatTime(time)
  return textutils.formatTime(time, true)
end

-- Function to draw the clock screen and the exit button
local function drawClockScreen()
  term.clear()
  term.setCursorPos(1,1)
  print("== Clock ==")
  print("==============")
  local timeStr = formatTime(os.time())
  print("Time: " .. timeStr)
  print("")
  print("Tap the button below to exit.")
  print("[ Exit ]") -- Exit button
end

-- Main app loop
while true do
  drawClockScreen()

  local event, _, _, x, y = os.pullEventRaw()
  
  if event == "mouse_click" then
    -- Check if the click was on the exit button
    if x >= 1 and x <= 8 and y >= 7 and y <= 7 then
      term.clear()  -- Clear the screen before exiting
      break  -- Exit the app
    end
  end
  sleep(0.5)
end

