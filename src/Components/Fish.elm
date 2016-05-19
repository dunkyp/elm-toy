module Components.Fish exposing (view, model, Model, heights)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Random
import Array

import Debug exposing (log)

getCell cells cell =
  let 
    cellValue = Array.get cell cells
  in
    case cellValue of
      Just x -> x
      Nothing -> if cell < 0 
                 then getCell cells (cell + 1)
                 else getCell cells (cell - 1)

force cells cell barWidth = 
  let 
    c = 0.08
    thisCell = getCell cells cell
    previousCell = getCell cells (cell - 1)
    nextCell = getCell cells (cell + 1)
    bSq = barWidth * barWidth
    cSq = c * c
  in
    (cSq * (previousCell + nextCell - 2*thisCell) / bSq)

velocity model =
  -- delta t = 1 for just now
  Array.indexedMap (\i v -> v + (force model.u i model.barWidth)) model.v

heights model =
  -- delta t = 1 for just now
  let
    model = 
      {model |
         v = velocity model}
  in
    {model |
       u = Array.indexedMap (\i u -> u + (getCell model.v i)) model.u}

type alias Model = {u : Array.Array Float, v : Array.Array Float, 
                      aspectWidth: Int, barWidth: Float,
                      aspectHeight: Int }
model =
  let
    aspectWidth = 1000
    length = 2000
  in
  { u = Array.fromList <| fst <| Random.step (Random.list length (Random.float 10 20)) (Random.initialSeed 10),
    v = Array.repeat length 0.0,

    aspectWidth = aspectWidth,
    aspectHeight = 100,
    barWidth = aspectWidth / (toFloat length) }

view model =
  let
    aspectHeightString = toString model.aspectHeight
    aspectWidthString = toString model.aspectWidth
    length = 
      Array.length model.u
    xOffset position =
      model.barWidth * (toFloat position)
    bars =
      Array.toList (Array.indexedMap (\i h->
                                        rect [y << toString <| ((toFloat model.aspectHeight) - h),
                                                x <| toString <| xOffset i, width <| toString model.barWidth, 
                                                height (toString h), 
                                                fill "blue"][]) (heights model).u)
  in
    svg
      [ version "1.1",  
          viewBox ("0 0 " ++ aspectWidthString ++ " " ++ aspectHeightString), 
          width  aspectWidthString,
          height aspectHeightString
      ]
      bars
