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
    print("Stopwatch: " .. timeStr)
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
    print("Timer: " .. timeStr)
    sleep(1)
  end
  term.clear()
  term.setCursorPos(1,1)
  print("Time's up!")
  sleep(2)
end

local function getTimerDuration()
  term.clear()
  term.setCursorPos(1,1)
  print("Set timer duration (in seconds):")
  local duration = 0
  while true do
    term.setCursorPos(1,3)
    term.clearLine()
    print("Duration: " .. duration .. " seconds")
    local event, _, _, _, _ = os.pullEventRaw()
    if event == "mouse_click" then
      return duration
    elseif event == "key" then
      if _ == keys.up then
        duration = duration + 1
      elseif _ == keys.down then
        if duration > 0 then
          duration = duration - 1
        end
      end
    end
    sleep(0.1)
  end
end

print("== Clock ==")
print("Tap screen to return.")

while true do
  local timeStr = formatTime(os.time())
  term.setCursorPos(1, 3)
  term.clearLine()
  print("Time: " .. timeStr)
  print("1 - Start Stopwatch")
  print("2 - Start Timer")

  local event, _, _, x, y = os.pullEventRaw()

  if event == "mouse_click" then
    if x >= 1 and x <= 1 + 22 and y >= 5 and y <= 5 then -- Stopwatch click area
      startStopwatch()
    elseif x >= 1 and x <= 1 + 22 and y >= 6 and y <= 6 then -- Timer click area
      local duration = getTimerDuration()
      startTimer(duration)
    else
      break
    end
  end
  sleep(0.5)
end
