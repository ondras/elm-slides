module Keys (signal) where

import Set
import Keyboard
import Actions

prev = Set.fromList [8, 33, 37, 38]  
next = Set.fromList [32, 34, 39, 40]

keysToAction keys =
  if Set.member 36 keys then
    Actions.First
  else if Set.member 35 keys then
    Actions.Last
  else if Set.size (Set.intersect keys prev) > 0 then
    Actions.Prev
  else if Set.size (Set.intersect keys next) > 0 then
    Actions.Next
  else
    Actions.NoOp

signal = 
  Signal.map keysToAction Keyboard.keysDown
