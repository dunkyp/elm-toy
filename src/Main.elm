import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Random
import Time exposing (Time, millisecond)

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

-- MODEL
type alias Model = Fish.Model

init : ( Model, Cmd Msg )
init =
    ( Fish.model, Cmd.none )

-- UPDATE
type Msg = 
         Tick Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time ->
      ( Fish.heights model, Cmd.none )
      


view : Model -> Html Msg
view model =
  div
    [ class "mt-palette-accent", style styles.wrapper ]
      [Fish.view model]

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every millisecond Tick


styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
