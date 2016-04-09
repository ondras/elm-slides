import Html exposing (text, Html)

import Task exposing (Task, andThen)
import Http

import Types
import Actions
import Keys
import Parser
import Hash
import View
import Title

clampIndex index slides =
  clamp 0 (List.length slides - 1) index

update action data =
  case (Debug.log "action" action) of
    Actions.NoOp ->
      data

    Actions.Response slides index ->
      { data |
        slides = slides,
        index = clampIndex index slides
      }
  
    Actions.GoAbs index ->
      { data |
        index = clampIndex index data.slides
      }

    Actions.GoRel diff ->
      { data |
        index = clampIndex (data.index + diff) data.slides
      }
      
    Actions.First ->
      { data |
        index = 0
      }

    Actions.Last ->
      { data |
        index = List.length data.slides - 1
      }

port request : Task Http.Error ()
port request =
  Http.getString "data.md" `andThen` (Parser.parse >> Signal.send response.address)

port history : Signal (Task error ())
port history =
  Hash.tasks model

port title : Signal String
port title =
  Title.title model

init =
  Types.Data [] -1

response =
  Signal.mailbox []

hashOnResponse =
  Signal.sampleOn response.signal Hash.signal'

responseWithHash =
  Signal.map2 Actions.Response response.signal hashOnResponse 

actions =
  Signal.mergeMany [ responseWithHash, Keys.signal, Hash.signal ]

model =
  Signal.foldp update init actions
  
main =
  Signal.map View.all model
