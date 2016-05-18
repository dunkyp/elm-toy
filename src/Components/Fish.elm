module Components.Fish exposing (model, update, fish)
import Svg exposing (..)
import Svg.Attributes exposing (..)

-- Model

model = 0

-- Update
update msg model = 
  model

fish model =
  let
    bars = List.indexedMap (\i h->rect [y "10", x (toString (i * 20)), width "20", height (toString h), fill "blue"][]) model
  in
  svg
    [ version "1.1",  viewBox "0 0 323.141 322.95"
    ]
    bars
