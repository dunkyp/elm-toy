module Components.Fish exposing (fish)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Array

waveEquation cells =
  let
    inCells = Array.fromList cells
  in
    List.indexedMap(\i h ->
                      h) cells

fish model =
  let
    aspectWidth = 1000
    aspectHeight = 100
    aspectHeightString = toString aspectHeight
    aspectWidthString = toString aspectWidth
    length = 
      List.length model
    barWidth =
      aspectWidth / (toFloat length)
    xOffset position =
      barWidth * (toFloat position)
    test = waveEquation model
    bars =
      List.indexedMap (\i h->
                         rect [y << toString <| (aspectHeight - h),
                               x <| toString <| xOffset i, width <| toString barWidth, 
                               height (toString h), 
                               fill "blue"][]) test
  in
  svg
    [ version "1.1",  
      viewBox ("0 0 " ++ aspectWidthString ++ " " ++ aspectHeightString), 
      width  aspectWidthString,
      height aspectHeightString
    ]
    bars
