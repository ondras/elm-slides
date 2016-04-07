module Types where

import Html exposing (Html)

type alias Slide = {
  title: String,
  node: Html
}

type alias Data = {
  slides: List Slide,
  index: Int
}
