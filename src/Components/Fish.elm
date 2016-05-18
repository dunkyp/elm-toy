module Components.Fish exposing (fish)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Array

getCell cells cell =
  let 
    cellValue = Array.get cell cells
  in
    case cellValue of
      Just x -> x
      Nothing -> if cell < 0 
                 then getCell cells (cell + 1)
                 else getCell cells (cell - 1)

waveEquation' : Array.Array Float -> Int -> Float -> Float
waveEquation' cells cell barWidth =
  let
    c = 1.2
    thisCell = getCell cells cell
    previousCell = getCell cells (cell - 1)
    nextCell = getCell cells (cell + 1)
    bSq = barWidth * barWidth
    cSq = c * c
  in
    thisCell + (cSq * (previousCell + nextCell - 2*thisCell) / bSq) * 6.0


waveEquation: List Float -> Float -> List Float
waveEquation cells barWidth =
  let
    c = 1.2
    inCells = Array.fromList cells
  in
    List.indexedMap(\i h ->
                      waveEquation' inCells i barWidth) cells

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
    test = waveEquation model barWidth
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
