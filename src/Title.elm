module Title (title) where

modelToTitle model =
  case List.head model.slides of
    Nothing -> ""
    Just slide -> slide.title

title model =
  Signal.map modelToTitle model
