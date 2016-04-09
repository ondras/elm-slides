module Hash (signal, tasks) where

import History
import Actions
import Task
import String exposing (dropLeft, toInt)

hashToAction hash =
  if hash == "" then
    Actions.NoOp
  else
    hash
      |> dropLeft 1
      |> toInt
      |> Result.withDefault 1
      |> (\number -> Actions.GoAbs (number-1))
  
signal =
  Signal.map hashToAction History.hash |> Signal.dropRepeats

currentIndex model = 
  Signal.map .index model |> Signal.dropRepeats

indexToTask index =
  if index >= 0 then
    History.setPath ("#" ++ toString (index+1))
  else
    Task.succeed ()
  
tasks model =
  Signal.map indexToTask (currentIndex model)
