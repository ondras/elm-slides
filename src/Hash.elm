module Hash (signal, tasks) where

import History
import Actions
import Task
import String exposing (dropLeft, toInt)

toAction hash =
  dropLeft 1 hash
    |> toInt
    |> Result.withDefault 1
    |> (\x -> x-1)
    |> Actions.Go

signal =
  Signal.map toAction History.hash |> Signal.dropRepeats

currentIndex model = 
  Signal.map .index model |> Signal.dropRepeats

indexToTask index =
  if index >= 0 then
    History.setHash (toString (index+1))
  else
    Task.succeed ()
  
tasks model =
  Signal.map indexToTask (currentIndex model)
