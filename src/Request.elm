module Request (signal, task) where

import Actions
import Parser
import Task exposing (andThen)
import Http
import Hash

box =
  Signal.mailbox []

merge slides action =
  case action of
    Actions.Go index -> Actions.Response slides index
    _ -> action

hashOnResponse =
  Signal.sampleOn box.signal Hash.signal

signal =
  Signal.map2 merge box.signal hashOnResponse 


task url =
  Http.getString url `andThen` (Parser.parse >> Signal.send box.address)
