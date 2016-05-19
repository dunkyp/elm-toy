module Components.Fish exposing (view, model, Model, waveEquation)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Random
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


waveEquation : Model -> Float -> Model
waveEquation cells barWidth =
  let
    c = 1.2
    inCells = Array.fromList cells.u
  in
    {cells | 
       u = List.indexedMap(\i h ->
                                   waveEquation' inCells i barWidth) cells.u,
       v = cells.v}
       

type alias Model = {u : List Float, v : List Int, 
                    aspectWidth: Int, barWidth: Float,
                    aspectHeight: Int }
model =
  let
    aspectWidth = 1000
    length = 200
  in
  { u = Random.step (Random.list length (Random.float 1 100)) (Random.initialSeed 10) 
  |> fst,
    v = List.repeat length 0,

    aspectWidth = aspectWidth,
    aspectHeight = 100,
    barWidth = aspectWidth / (toFloat length) }

view model =
  let
    aspectHeightString = toString model.aspectHeight
    aspectWidthString = toString model.aspectWidth
    length = 
      List.length model.u
    xOffset position =
      model.barWidth * (toFloat position)
    bars =
      List.indexedMap (\i h->
                         rect [y << toString <| ((toFloat model.aspectHeight) - h),
                               x <| toString <| xOffset i, width <| toString model.barWidth, 
                               height (toString h), 
                               fill "blue"][]) model.u
  in
  svg
    [ version "1.1",  
      viewBox ("0 0 " ++ aspectWidthString ++ " " ++ aspectHeightString), 
      width  aspectWidthString,
      height aspectHeightString
    ]
    bars
