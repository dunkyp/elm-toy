import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing ( onClick )

-- component import example
import Components.Fish exposing ( fish )


-- APP
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = List Int
model = [10,20,30,30,30,25,40,10,3]


-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model
    Increment -> model


-- VIEW
-- Examples of:
-- 1)  an externally defined component ('hello', takes 'model' as arg)
-- 2a) styling through CSS classes (external stylesheet)
-- 2b) styling using inline style attribute (two variants)
view : Model -> Html Msg
view model =
  div
    [ class "mt-palette-accent", style styles.wrapper ]
      [fish model]


-- CSS STYLES
styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
