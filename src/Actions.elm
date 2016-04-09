module Actions where

import Html exposing (Html)
import Types

type Action = NoOp
       | Response (List Types.Slide) Int
       | GoAbs Int
       | GoRel Int
       | First
       | Last
