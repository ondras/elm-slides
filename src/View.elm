module View (all) where

import Html exposing (div, section)
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
  div [] (slides data)
