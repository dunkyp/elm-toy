import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html

import Random
-- component import example
import Components.Fish exposing ( fish )



-- APP
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = List Int
model =  Random.step (Random.list 200 (Random.int 1 100)) (Random.initialSeed 10) 
      |> fst


-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model
    Increment -> model


view : Model -> Html Msg
view model =
  div
    [ class "mt-palette-accent", style styles.wrapper ]
      [fish model]


styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
