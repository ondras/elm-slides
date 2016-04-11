import Task
import Http

import Types
import Actions
import Request
import Keys
import Hash
import View
import Taps
import Title

clampIndex index slides =
  clamp 0 (List.length slides - 1) index

newIndex oldIndex action slides =
  case action of
    Actions.NoOp -> oldIndex
    Actions.First -> 0
    Actions.Last -> List.length slides-1
    Actions.Prev -> oldIndex-1
    Actions.Next -> oldIndex+1
    Actions.Go index -> index
    Actions.Response _ index -> index

update action data =
  let
    index =
      newIndex data.index action data.slides
  in
    case action of
      Actions.NoOp -> data

      Actions.Response slides _ ->
        { data |
          slides = slides,
          index = clampIndex index slides
        }
        
      _ -> { data | index = clampIndex index data.slides }

port request : Task.Task Http.Error ()
port request =
  Request.task "data.md"

port history : Signal (Task.Task error ())
port history =
  Hash.tasks model

port title : Signal String
port title =
  Title.title model

init =
  Types.Data [] -1

actions =
  Signal.mergeMany [ Request.signal, Keys.signal, Hash.signal, Taps.signal ]

model =
  Signal.foldp update init actions
  
main =
  Signal.map View.all model
