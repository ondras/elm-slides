module Hash (signal, signal', tasks) where

import History
import Actions
import Task
import String exposing (dropLeft, toInt)

toIndex hash =
  dropLeft 1 hash
    |> toInt
    |> Result.withDefault 1
    |> (\x -> x-1)

toAction hash =
  if hash == "" then
    Actions.NoOp
  else
    Actions.Go (toIndex hash)

signal' =
  Signal.map toIndex History.hash |> Signal.dropRepeats
  
signal =
  Signal.map toAction History.hash |> Signal.dropRepeats

currentIndex model = 
  Signal.map .index model |> Signal.dropRepeats

indexToTask index =
  if index >= 0 then
    History.setPath ("#" ++ toString (index+1))
  else
    Task.succeed ()
  
tasks model =
  Signal.map indexToTask (currentIndex model)
