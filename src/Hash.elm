port module Hash exposing (setHash, listen, hashToIndex)
import Msg
import String

port hash : String -> Cmd msg
port hashchange : (String -> msg) -> Sub msg

setHash model =
  hash (toString (model.index+1))

toMessage str =
  Msg.Go (hashToIndex str)

hashToIndex str =
  String.toInt str
    |> Result.withDefault 1
    |> (\x -> x-1)

listen =
  hashchange toMessage
