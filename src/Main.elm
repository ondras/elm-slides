import Types exposing (Data)
import Msg
import Request
import Keys
import View
-- import Hash
-- import Taps
-- import Title

import Html.App exposing (program)

-- port title : String -> Cmd msg

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
    Msg.Response _ -> 0

update msg data =
  let
    index =
      newIndex data.index msg data.slides
  in
    case msg of
      Msg.NoOp -> data ! [Cmd.none]

      Msg.Response slides ->
        { data |
          slides = slides,
          index = clampIndex index slides
        } ! [Cmd.none]

      _ -> { data | index = clampIndex index data.slides } ! [Cmd.none]

init =
  (Data [] -1, Request.command "data.md")

subscriptions _ =
  Keys.subscription

main =
  program {
    init = init,
    view = View.all,
    update = update,
    subscriptions = subscriptions
  }
