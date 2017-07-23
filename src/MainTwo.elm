module MainTwo exposing (..)

import Html exposing (Html, text, button)
import Navigation exposing (Location)
import UrlParser exposing (parseHash, int)


---- MODEL ----


type alias Model =
    { n : Maybe Int
    }


init : Location -> ( Model, Cmd Msg )
init location =
    ( { n = parseHash int location }, Cmd.none )



---- UPDATE ----


type Msg
    = LocationChange Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LocationChange location ->
            let
                n =
                    parseHash int location
            in
                { model | n = n } ! []



---- VIEW ----


view : Model -> Html Msg
view model =
    model.n
        |> Maybe.map (\n -> "I know, that " ++ toString n ++ " is in URL")
        |> Maybe.withDefault "I don't know what is in URL"
        |> text



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
