module Main exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Navigation exposing (Location)
import UrlParser exposing (parseHash, int)


---- MODEL ----


type alias Model =
    { n : Int
    , knownN : Maybe Int
    }


init : Location -> ( Model, Cmd Msg )
init location =
    ( { n = 1, knownN = Nothing }, Cmd.none )



---- UPDATE ----


type Msg
    = IncrementURL
    | LocationChange Location
    | Replace


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementURL ->
            { model
                | n = model.n + 1
            }
                ! [ Navigation.newUrl ("#" ++ toString model.n) ]

        LocationChange location ->
            let
                n =
                    parseHash int location
            in
                { model | knownN = n } ! []

        Replace ->
            model ! [ Navigation.newUrl "#42" ]



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick IncrementURL
            ]
            [ text <| "Put " ++ toString model.n ++ " into URL" ]
        , div []
            [ model.knownN
                |> Maybe.map (\n -> "I know, that " ++ toString n ++ " is in URL")
                |> Maybe.withDefault "I don't know what is in URL"
                |> text
            ]
        , button
            [ onClick Replace ]
            [ text "Replace with 42!" ]
        ]



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
