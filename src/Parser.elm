module Parser (parse) where

import Actions
import Regex
import Markdown

pattern =
  Regex.regex "-+8<-+"

parse str =
  Regex.split (Regex.All) pattern str
    |> List.map Markdown.toHtml
    |> Actions.Response 
