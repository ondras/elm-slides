module Taps exposing (signal)

import Actions
import Touch
import Window

combine tap width =
  if tap.x > width // 2 then
    Actions.Next
  else
    Actions.Prev

signal =
  Signal.map2 combine (Touch.taps |> Signal.dropRepeats) Window.width
