#press ctrl+v and enter every 5 seconds
import time
import keyboard

print("Press ctrl+v and enter every 5 seconds")
time.sleep(5)
while True:
    keyboard.press_and_release('ctrl+v')
    time.sleep(.5)
    keyboard.press_and_release('enter')
    time.sleep(5)