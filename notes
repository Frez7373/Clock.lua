print("== Notes ==")
local file = "notes.txt"

-- Reading saved notes
if fs.exists(file) then
  local h = fs.open(file, "r")
  local text = h.readAll()
  h.close()
  print("Saved notes:")
  print(text)
else
  print("No notes found.")
end

-- Writing a new note
write("New note: ")
local input = read()
local h = fs.open(file, "w")
h.write(input)
h.close()
print("Note saved!")

-- Function to clear the screen with a custom design (borders)
local function clearScreen()
  term.clear()  -- Clear the screen
  term.setCursorPos(1, 1)  -- Reset cursor position
  -- Draw a border around the screen
  print("*************************************")
  for i = 1, 18 do
    print("*                                   *")
  end
  print("*************************************")
  print("Screen cleared!")  -- Inform user
end

-- Function to clear notes
local function clearNotes()
  local h = fs.open(file, "w")
  h.close()  -- Clear the file by opening it in write mode without any content
  print("Notes cleared!")
end

-- Function to exit the program
local function exitProgram()
  term.clear()  -- Clear the screen
  term.setCursorPos(1, 1)
  print("Exiting program...")
  os.sleep(1)  -- Wait for a second before exiting
  os.exit()  -- Exit the program
end

-- Function to display buttons
local function drawButtons()
  term.setCursorPos(1, 20)
  print("[Clear Notes]")
  term.setCursorPos(1, 22)
  print("[Exit]")
  term.setCursorPos(1, 24)
  print("[Return]")
end

-- Initial button drawing
drawButtons()

-- Waiting for mouse clicks on the screen
while true do
  local event, button, x, y = os.pullEvent("mouse_click")
  
  -- Check if the mouse click is within button areas
  if x >= 1 and x <= 14 and y >= 20 and y <= 21 then  -- Clear Notes button
    clearNotes()
    drawButtons()
  elseif x >= 1 and x <= 5 and y >= 22 and y <= 23 then  -- Exit button
    exitProgram()
  elseif x >= 1 and x <= 7 and y >= 24 and y <= 25 then  -- Return button
    print("Returning to the main menu...")
    break  -- Exit the loop and return to the main process
  end
end
