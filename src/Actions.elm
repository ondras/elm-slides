module Actions where

import Html exposing (Html)
import Types

type Action = NoOp
       | Response (List Types.Slide) Int
       | Go Int
       | Prev
       | Next
       | First
       | Last
