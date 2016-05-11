module View exposing (all)

import Msg
import Html exposing (div, section)
import Html.App as Html
import Html.Attributes exposing (classList)

display current index =
  if current == index then
    "block"
  else
    "none"

slide current index slide =
  section [
    classList [
      ("active", index == current),
      ("slide", True)
    ]
  ] [ slide.node ]

slides data =
  List.indexedMap (slide data.index) data.slides

all data =
  Html.map (always Msg.NoOp) (div [] (slides data))
