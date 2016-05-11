module Types exposing (..)

import Html exposing (Html)

type alias Slide = {
  title: String,
  node: Html Never
}

type alias Data = {
  slides: List Slide,
  index: Int
}
