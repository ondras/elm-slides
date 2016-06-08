port module Title exposing (setTitle)

port title : String -> Cmd msg

modelToTitle model =
  case List.head model.slides of
    Nothing ->
      ""

    Just slide ->
      "(" ++ toString (model.index+1) ++ ") " ++ slide.title

setTitle model =
  title (modelToTitle model)
