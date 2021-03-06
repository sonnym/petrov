module Components.Input where

import Graphics.Input (customButton)

import Keyboard

type Input = { space: Bool
             , enter: Bool
             , launch: Bool
             , elapsed: Time
             }

btn_up = image 46 36 "assets/button.png"
btn_down = image 46 36 "assets/button_down.png"
(launchButtonElement, launchButtonSignal) = customButton btn_up btn_up btn_down

delta = inSeconds <~ fps 35
input = sampleOn delta (Input <~ Keyboard.space
                               ~ Keyboard.enter
                               ~ merges [constant False, (\_ -> True) <~ launchButtonSignal, sampleOn Keyboard.enter (constant False)]
                               ~ every second)
