import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html

import Random
-- component import example
import Components.Fish as Fish



-- APP
main =
  Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
  --Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = Fish.Model

init : ( Model, Cmd Msg )
init =
    ( Fish.model, Cmd.none )

-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    Increment -> (model, Cmd.none)


view : Model -> Html Msg
view model =
  div
    [ class "mt-palette-accent", style styles.wrapper ]
      [Fish.view model]

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []


styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
