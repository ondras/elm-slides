module Actions where

import Html exposing (Html)
import Types

type Action = NoOp | Response (List Types.Slide) | GoAbs Int | GoRel Int