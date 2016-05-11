module Keys exposing (subscription)

import Set
import Keyboard
import Msg

prev = Set.fromList [8, 33, 37, 38]
next = Set.fromList [32, 34, 39, 40]

keysToMessage keyCode =
  if keyCode == 36 then
    Msg.First
  else if keyCode == 35 then
    Msg.Last
  else if Set.member keyCode prev then
    Msg.Prev
  else if Set.member keyCode next then
    Msg.Next
  else
    Msg.NoOp

subscription =
  Keyboard.downs keysToMessage
