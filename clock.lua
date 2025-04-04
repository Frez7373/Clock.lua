term.clear()
term.setCursorPos(1,1)

local function formatTime(time)
  return textutils.formatTime(time, true)
end

local function startStopwatch()
  local startTime = os.time()
  while true do
    term.clear()
    term.setCursorPos(1,1)
    local elapsed = os.time() - startTime
    local timeStr = string.format("%02d:%02d:%02d", math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), elapsed % 60)
    print("Stopwatch")
    print("------------")
    print("Time: " .. timeStr)
    print("Tap anywhere to stop")
    local event, _, _, _, _ = os.pullEventRaw()
    if event == "mouse_click" then break end
    sleep(1)
  end
end

local function startTimer(duration)
  local endTime = os.time() + duration
  while os.time() < endTime do
    term.clear()
    term.setCursorPos(1,1)
    local remaining = endTime - os.time()
    local timeStr = string.format("%02d:%02d:%02d", math.floor(remaining / 3600), math.floor((remaining % 3600) / 60), remaining % 60)
    print("Timer")
    print("------------")
    print("Time remaining: " .. timeStr)
    sleep(1)
  end
  term.clear()
  term.setCursorPos(1,1)
  print("Timer finished!")
  sleep(2)
end

local function getTimerDuration()
  local duration = 10 -- default to 10 seconds
  term.clear()
  term.setCursorPos(1,1)
  print("Set timer duration")
  print("(Use arrows to adjust, tap to confirm)")
  print("Duration: " .. duration .. " seconds")

  while true do
    local event, _, _, _, _ = os.pullEventRaw()
    if event == "mouse_click" then
      return duration
    elseif event == "key" then
      if _ == keys.up then
        duration = duration + 1
      elseif _ == keys.down then
        if duration > 1 then
          duration = duration - 1
        end
      end
    end
    term.setCursorPos(1,4)
    term.clearLine()
    print("Duration: " .. duration .. " seconds")
    sleep(0.1)
  end
end

local function drawMainMenu()
  term.clear()
  term.setCursorPos(1,1)
  print("== Clock App ==")
  print("================")
  print("1. Start Stopwatch")
  print("2. Start Timer")
  print("Tap the number to choose an option.")
end

-- Main program loop
while true do
  drawMainMenu()

  local event, _, _, x, y = os.pullEventRaw()
  
  if event == "mouse_click" then
    if x >= 1 and x <= 18 and y == 3 then -- Start Stopwatch
      startStopwatch()
    elseif x >= 1 and x <= 18 and y == 4 then -- Start Timer
      local duration = getTimerDuration()
      startTimer(duration)
    else
      break -- Exit program on click outside menu
    end
  end
  sleep(0.5)
end
