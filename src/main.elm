import Html exposing (div, text, Html, section)
import Html.Attributes exposing (classList)
import Task exposing (Task, andThen)
import Http
import Keyboard
import Set
import Regex
import Markdown
import History
import String exposing (dropLeft, toInt)

-- types

type alias Data = {
  nodes: List Html,
  index: Int
}

type Action = NoOp | Response (List Html) | GoAbs Int | GoRel Int

prev = Set.fromList [33, 37, 38]  
next = Set.fromList [32, 34, 39, 40]

init =
  Data ([text "Loading…"]) 0

-- signals, mailboxes

response =
  Signal.mailbox NoOp

keyboardSignal = 
  let
    kbToAction keys =
      if Set.size (Set.intersect keys prev) > 0 then
        GoRel -1
      else if Set.size (Set.intersect keys next) > 0 then
        GoRel 1
      else
        NoOp
  in
    Signal.map kbToAction Keyboard.keysDown

actions =
  Signal.mergeMany [ response.signal, keyboardSignal, historySignal ]

model =
  Signal.foldp update init actions

-- history

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

port history : Signal (Task error ())
port history =
  Signal.map History.setPath currentSignal

-- update 

update action data =
  let clampIndex i =
    clamp 0 (List.length data.nodes - 1) i 
  in
    case action of
      NoOp ->
        data

      Response nodes ->
        Data nodes 0
      
      GoAbs index ->
        { data | index = clampIndex index }

      GoRel diff ->
        { data | index = clampIndex (data.index + diff) }

-- view

display current index =
  if current == index then
    "block"
  else
    "none"

slide current index node =
  section [
    classList [ ("active", index == current) ]
  ] [ node ]

view data =
  let
    slides =
      List.indexedMap (slide data.index) data.nodes 
  in    
    div [] slides

-- http

processResponse str =
  Regex.split (Regex.All) (Regex.regex "-+8<-+") str
    |> List.map Markdown.toHtml
    |> Response 
    |> Signal.send response.address

port request : Task Http.Error ()
port request =
  Http.getString "data.md" `andThen` processResponse

-- setup
main =
  Signal.map view model
--  Signal.map text History.hash
