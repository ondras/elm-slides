module Title exposing (title)

modelToTitle model =
  case List.head model.slides of
    Nothing ->
      ""

    Just slide ->
      "(" ++ toString (model.index+1) ++ ") " ++ slide.title

title model =
  Signal.map modelToTitle model
