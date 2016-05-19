import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html

import Random
-- component import example
import Components.Fish as Fish



-- APP
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = Fish.Model
model =  Fish.model

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
      [Fish.view model]


styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
