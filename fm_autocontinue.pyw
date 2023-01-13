import pyautogui as pgui
import win32gui
import time
# import cv2
# import mss
# import numpy
# import pytesseract

def windowProperties(hwnd):
    rect = win32gui.GetWindowRect(hwnd)
    x = rect[0]
    y = rect[1]
    w = rect[2] - x
    h = rect[3] - y
    return {'top': y, 'left': x, 'width':w, 'height':h}

def isFocused(hwnd):
    print(win32gui.GetForegroundWindow(), hwnd)
    return win32gui.GetForegroundWindow() == hwnd

def getCursorsPosition():
    return pgui.position()

# def findButton(hwnd):
#     with mss.mss() as sct:
#         im = numpy.asarray(sct.grab(windowProperties(hwnd)))
#         # im = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)

#         pytesseract.pytesseract.tesseract_cmd = R'C:\Users\USER\AppData\Local\Tesseract-OCR\tesseract.exe'

#         text = pytesseract.image_to_string(im)
#         print(text)

#         cv2.imshow('Image', im)

#         # # Press "q" to quit
#         # if cv2.waitKey(25) & 0xFF == ord('q'):
#         #     cv2.destroyAllWindows()
#         #     break

#         # One screenshot per second
#         time.sleep(1)          

def clickButton(hwnd, t, clicks):

    dimensions = windowProperties(hwnd)
    focusedOn =  win32gui.GetForegroundWindow()
    prevPosition = getCursorsPosition()
    win32gui.SetForegroundWindow(hwnd)
    pgui.moveTo(int((dimensions['left'] + dimensions['width'] )* 0.95), dimensions['top'] + int(dimensions['height'] * 0.05))
    time.sleep(t)
    for i in range(clicks):
        pgui.click()
    win32gui.SetForegroundWindow(focusedOn)
    pgui.moveTo(prevPosition)

def main(repeat:bool=False, refreshRate:float = 10.0, previewTime:float = 0.0, clicks:int=1):
    while True:
        try:
            hwnd = win32gui.FindWindow(None, "Football Manager 2023")
            clickButton(hwnd, previewTime, clicks)
            time.sleep(refreshRate)
            if not repeat: break
        except pgui.FailSafeException:
            pgui.moveTo(0,0)
            win32gui.SetForegroundWindow(hwnd)     

if __name__ == '__main__':
    main()
    exit()
    # refreshRate - jak często w sekundach nastąpi przeklikiwanie
    # previewTime - jak długo program pozostawi widocznego fma przed przeklikaniu (tj. ile czasu będzie na przeczytanie zanim kliknie się continue)
    # clicks - ile razy kliknie w kontynuuj 
    #   (każde kliknięcie przechodzi przez jedną wiadomość, więc im więcej, tym więcej wiadomości zostanie przeklikanych na raz, jednocześnie wydłużając czas wykonania)     