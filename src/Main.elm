import Html exposing (text, Html)

import Task exposing (Task, andThen)
import Http

import Types
import Actions
import Keys
import Parser
import Hash
import View

init =
  Types.Data [] -1

response =
  Signal.mailbox Actions.NoOp

actions =
  Signal.mergeMany [ response.signal, Keys.signal, Hash.signal ]

model =
  Signal.foldp update init Hash.signal
  
clampIndex index slides =
  if List.length slides > 0 then
    clamp 0 (List.length slides - 1) index
  else index

update action data =
  case (Debug.log "action" action) of
    Actions.NoOp ->
      data

    Actions.Response slides ->
      { data |
        slides = slides,
        index = clampIndex data.index slides
      }
  
    Actions.GoAbs index ->
      { data |
        index = clampIndex index data.slides
      }

    Actions.GoRel diff ->
      { data |
        index = clampIndex (data.index + diff) data.slides
      }

{-
port request : Task Http.Error ()
port request =
  Http.getString "data.md" `andThen` (Parser.parse >> Signal.send response.address)
-}


port history : Signal (Task error ())
port history =
  Hash.tasks model

main =
  Signal.map View.all model
