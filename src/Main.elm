import Types exposing (Data)
import Msg
import Request
import Keys
import View
-- import Hash
import Title exposing (setTitle)
import Hash exposing (setHash, hashToIndex)

import Html.App exposing (programWithFlags)

type alias Flags = { hash : String }

clampIndex index slides =
  clamp 0 (List.length slides - 1) index

newIndex oldIndex msg slides =
  case msg of
    Msg.NoOp -> oldIndex
    Msg.First -> 0
    Msg.Last -> List.length slides-1
    Msg.Prev -> oldIndex-1
    Msg.Next -> oldIndex+1
    Msg.Go index -> index
    Msg.Response _ -> oldIndex

update msg data =
  let
    index =
      newIndex data.index msg data.slides
  in
    case msg of
      Msg.NoOp -> data ! [Cmd.none]

      Msg.Response slides ->
        let newModel = { data | slides = slides, index = clampIndex index slides }
        in newModel ! [setTitle newModel, setHash newModel]

      _ ->
        let newModel = { data | index = clampIndex index data.slides }
        in newModel ! [setTitle newModel, setHash newModel]

init : Flags -> (Data, Cmd Msg.Msg)
init flags =
  Data [] (hashToIndex flags.hash) ! [Request.command "data.md"]

subscriptions _ =
  Sub.batch [ Keys.subscription, Hash.listen ]

main =
  programWithFlags {
    init = init,
    view = View.all,
    update = update,
    subscriptions = subscriptions
  }
