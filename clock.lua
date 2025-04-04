-- Touchscreen Number Guessing Game with Timer & Stopwatch

-- Initialize game variables
local targetNumber = math.random(1, 100)
local userInput = ""
local gameStartTime = os.epoch("utc")
local gameTimeLimit = 60000 -- 60 seconds
local gameEnded = false
local playerWon = false

-- Clear the terminal and get screen dimensions
term.clear()
local screenWidth, screenHeight = term.getSize()

-- Define buttons for digits, OK, and CLR
local buttons = {
  {label="1", x=3, y=5}, {label="2", x=7, y=5}, {label="3", x=11, y=5},
  {label="4", x=3, y=7}, {label="5", x=7, y=7}, {label="6", x=11, y=7},
  {label="7", x=3, y=9}, {label="8", x=7, y=9}, {label="9", x=11, y=9},
  {label="0", x=7, y=11}, {label="OK", x=15, y=7}, {label="CLR", x=15, y=9}
}

-- Function to draw buttons on the screen
local function drawButtons()
  for _, button in ipairs(buttons) do
    term.setCursorPos(button.x, button.y)
    term.write("[" .. button.label .. "]")
  end
end

-- Function to update the game interface
local function updateUI(message)
  term.setCursorPos(1, 1)
  term.clearLine()
  term.write("== Guess the Number ==")

  term.setCursorPos(1, 2)
  term.clearLine()
  term.write("Input: " .. userInput)

  term.setCursorPos(1, 3)
  term.clearLine()
  term.write("Message: " .. (message or ""))

  term.setCursorPos(1, 4)
  term.clearLine()
  local elapsedTime = math.floor((os.epoch("utc") - gameStartTime) / 1000)
  local remainingTime = math.max(0, math.floor(gameTimeLimit / 1000) - elapsedTime)
  term.write("⏱️ " .. elapsedTime .. "s used / " .. remainingTime .. "s left")
end

-- Function to detect which button was pressed based on coordinates
local function detectButtonPress(x, y)
  for _, button in ipairs(buttons) do
    if x >= button.x and x <= button.x + #button.label + 1 and y == button.y then
      return button.label
    end
  end
  return nil
end

-- Main game loop
local feedbackMessage = ""
while not gameEnded do
  updateUI(feedbackMessage)
  drawButtons()

  if os.epoch("utc") - gameStartTime > gameTimeLimit then
    feedbackMessage = "⛔ Time's up!"
    gameEnded = true
    break
  end

  local event, _, x, y = os.pullEvent("mouse_click")
  local pressedButton = detectButtonPress(x, y)
  if pressedButton then
    if pressedButton == "OK" then
      local playerGuess = tonumber(userInput)
      if playerGuess then
        if playerGuess < targetNumber then
          feedbackMessage = "Too low!"
        elseif playerGuess > targetNumber then
          feedbackMessage = "Too high!"
        else
          playerWon = true
          gameEnded = true
          break
        end
      else
        feedbackMessage = "Invalid input!"
      end
      userInput = ""
    elseif pressedButton == "CLR" then
      userInput = ""
    else
      userInput = userInput .. pressedButton
    end
  end
end

-- Display end-of-game messages
term.clear()
term.setCursorPos(1, 2)

if playerWon then
  local totalTime = math.floor((os.epoch("utc") - gameStartTime) / 1000)
  print("🎉 Correct! You guessed it!")
  print("⏱️ Time taken: " .. totalTime .. " seconds")
else
  print("😢 Time's up! The number was: " .. targetNumber)
end

print("\nTap anywhere to exit...")
os.pullEvent("mouse_click")
