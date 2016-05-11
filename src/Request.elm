module Request exposing (command)

import Msg
import Parser
import Task exposing (andThen)
import Http

responseOk data =
  Msg.Response (Parser.parse data)

responseFail err =
  Msg.Response []

command url =
  Task.perform responseFail responseOk (Http.getString url)
