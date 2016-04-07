import Html exposing (div, text, Html, section)
import Html.Attributes exposing (class, classList)
import Task exposing (Task, andThen)
import Http
import Keys
import History
import Actions
import Parser
import String exposing (dropLeft, toInt)

-- types

type alias Data = {
  nodes: List Html,
  index: Int
}

init =
  Data ([text "Loading…"]) 0

-- signals, mailboxes

response =
  Signal.mailbox Actions.NoOp

actions =
  Signal.mergeMany [ response.signal, Keys.signal, historySignal ]

model =
  Signal.foldp update init actions

-- history

historySignal =
  let
    hashToAction hash =
      if hash == "" then
        Actions.NoOp
      else
        hash |> dropLeft 1 |> toInt |> (Result.withDefault 0) |> Actions.GoAbs
  in
    Signal.map hashToAction History.hash |> Signal.dropRepeats

currentSignal = 
  let
    modelToHash model =
      ("#" ++ toString model.index)
  in
    Signal.map modelToHash model |> Signal.dropRepeats

port history : Signal (Task error ())
port history =
  Signal.map History.setPath currentSignal

-- update 

update action data =
  let clampIndex i =
    clamp 0 (List.length data.nodes - 1) i 
  in
    case action of
      Actions.NoOp ->
        data

      Actions.Response nodes ->
        Data nodes 0
      
      Actions.GoAbs index ->
        { data | index = clampIndex index }

      Actions.GoRel diff ->
        { data | index = clampIndex (data.index + diff) }

-- view

display current index =
  if current == index then
    "block"
  else
    "none"

slide current index node =
  section [
    classList [
      ("active", index == current),
      ("slide", True)
    ]
  ] [ node ]

view data =
  let
    slides =
      List.indexedMap (slide data.index) data.nodes 
  in    
    div [] slides

port request : Task Http.Error ()
port request =
  Http.getString "data.md" `andThen` (Parser.parse >> Signal.send response.address)

main =
  Signal.map view model
