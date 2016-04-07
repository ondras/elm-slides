module Keys (signal) where

import Set
import Keyboard
import Actions

prev = Set.fromList [33, 37, 38]  
next = Set.fromList [32, 34, 39, 40]

keysToAction keys =
  if Set.size (Set.intersect keys prev) > 0 then
    Actions.GoRel -1
  else if Set.size (Set.intersect keys next) > 0 then
    Actions.GoRel 1
  else
    Actions.NoOp

signal = 
  Signal.map keysToAction Keyboard.keysDown
