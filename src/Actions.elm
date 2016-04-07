module Actions where

import Html exposing (Html)

type Action = NoOp | Response (List Html) | GoAbs Int | GoRel Int
