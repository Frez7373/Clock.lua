-- Touchscreen Number Guessing Game with Timer & Stopwatch

local num = math.random(1, 100)
local input = ""
local startTime = os.epoch("utc")
local timeLimit = 60000 -- 60 seconds
local gameOver = false
local win = false

term.clear()
local w, h = term.getSize()

-- Buttons: digits, OK, CLR
local buttons = {
  {label="1", x=3, y=5}, {label="2", x=7, y=5}, {label="3", x=11, y=5},
  {label="4", x=3, y=7}, {label="5", x=7, y=7}, {label="6", x=11, y=7},
  {label="7", x=3, y=9}, {label="8", x=7, y=9}, {label="9", x=11, y=9},
  {label="0", x=7, y=11}, {label="OK", x=15, y=7}, {label="CLR", x=15, y=9}
}

local function drawButtons()
  for _, b in ipairs(buttons) do
    term.setCursorPos(b.x, b.y)
    term.write("[" .. b.label .. "]")
  end
end

local function drawUI(msg)
  term.setCursorPos(1, 1)
  term.clearLine()
  term.write("== Guess the Number ==")

  term.setCursorPos(1, 2)
  term.clearLine()
  term.write("Input: " .. input)

  term.setCursorPos(1, 3)
  term.clearLine()
  term.write("Message: " .. (msg or ""))

  term.setCursorPos(1, 4)
  term.clearLine()
  local elapsed = math.floor((os.epoch("utc") - startTime) / 1000)
  local remaining = math.max(0, timeLimit // 1000 - elapsed)
  term.write("⏱️ " .. elapsed .. "s used / " .. remaining .. "s left")
end

local function getButtonAt(x, y)
  for _, b in ipairs(buttons) do
    if x >= b.x and x <= b.x + #b.label + 1 and y == b.y then
      return b.label
    end
  end
  return nil
end

-- Main loop
local message = ""
while not gameOver do
  drawUI(message)
  drawButtons()

  if os.epoch("utc") - startTime > timeLimit then
    message = "⛔ Time's up!"
    gameOver = true
    break
  end

  local event, _, x, y = os.pullEvent("mouse_click")
  local b = getButtonAt(x, y)
  if b then
    if b == "OK" then
      local guess = tonumber(input)
      if guess then
        if guess < num then
          message = "Too low!"
        elseif guess > num then
          message = "Too high!"
        else
          win = true
          gameOver = true
          break
        end
      else
        message = "Invalid input!"
      end
      input = ""
    elseif b == "CLR" then
      input = ""
    else
      input = input .. b
    end
  end
end

-- End screen
term.clear()
term.setCursorPos(1, 2)

if win then
  local finalTime = math.floor((os.epoch("utc") - startTime) / 1000)
  print("🎉 Correct! You guessed it!")
  print("⏱️ Time taken: " .. finalTime .. " seconds")
else
  print("😢 Time's up! The number was: " .. num)
end

print("\nTap anywhere to exit...")
os.pullEvent("mouse_click")
