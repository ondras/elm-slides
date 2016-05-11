module Msg exposing (..)

import Types exposing (Slide)

type Msg = NoOp
       | Response (List Slide)
       | Go Int
       | Prev
       | Next
       | First
       | Last
