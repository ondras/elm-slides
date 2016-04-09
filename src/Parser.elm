module Parser (parse) where

import Actions
import Types
import Regex
import Markdown exposing (defaultOptions)

pattern =
  {
    break = Regex.regex "\\n\\s*-+8<-+",
    title = Regex.regex "(\\n|^)\\s*#\\s+([^\\n]+)"
  }

options = 
    { defaultOptions | smartypants = True }
    
lastSubmatch match =
  List.reverse match.submatches
    |> List.head
    |> Maybe.withDefault (Just "")

title str =
  let
    matches =
      Regex.find (Regex.AtMost 1) pattern.title str
  in
    case List.head matches of
      Nothing -> ""
      Just match -> Maybe.withDefault "" (lastSubmatch match)

slide str =
  Types.Slide (title str) (Markdown.toHtmlWith options str)

parse str =
  Regex.split Regex.All pattern.break str
    |> List.map slide
    |> Actions.Response 
