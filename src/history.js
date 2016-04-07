module history where

import History

historySignal =
  let
    hashToAction hash =
      if hash == "" then
        NoOp
      else
        hash |> dropLeft 1 |> toInt |> (Result.withDefault 0) |> GoAbs
  in
    Signal.map hashToAction History.hash |> Signal.dropRepeats

currentSignal = 
  let
    modelToHash model =
      ("#" ++ toString model.index)
  in
    Signal.map modelToHash model |> Signal.dropRepeats

tasks =
  Signal.map History.setPath currentSignal
