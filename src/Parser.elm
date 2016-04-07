module Parser (parse) where

import Actions
import Types
import Regex
import Markdown

pattern =
  Regex.regex "[\\n^]\\s*-+8<-+"

title str =
  ""

slide str =
  Types.Slide (title str) (Markdown.toHtml str)

parse str =
  Regex.split (Regex.All) pattern str
    |> List.map slide
    |> Actions.Response 
