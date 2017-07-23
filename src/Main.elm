module Main exposing (..)

import Html exposing (Html, text, button)
import Html.Events exposing (onClick)
import Navigation exposing (Location)


---- MODEL ----


type alias Model =
    { n : Int
    }


init : Location -> ( Model, Cmd Msg )
init location =
    ( { n = 1 }, Cmd.none )



---- UPDATE ----


type Msg
    = IncrementURL
    | LocationChange Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementURL ->
            { model
                | n = model.n + 1
            }
                ! [ Navigation.newUrl ("#" ++ toString model.n) ]

        _ ->
            model ! []



---- VIEW ----


view : Model -> Html Msg
view model =
    button
        [ onClick IncrementURL
        ]
        [ text <| "Put " ++ toString model.n ++ " into URL" ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program
        LocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
