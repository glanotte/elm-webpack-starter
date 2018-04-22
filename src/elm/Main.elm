module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Navigation
import Routes


-- MODEL


type Page
    = NotFound
    | Home


type alias Model =
    { page : Page }


initialModel : Model
initialModel =
    { page = NotFound }



-- UPDATE


type Msg
    = NewRoute (Maybe Routes.Route)
    | Visit Routes.Route


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( NewRoute maybeRoute, _ ) ->
            setNewPage maybeRoute model

        ( Visit route, _ ) ->
            ( model, Routes.visit route )


setNewPage : Maybe Routes.Route -> Model -> ( Model, Cmd Msg )
setNewPage maybeRoute model =
    case maybeRoute of
        Just Routes.Home ->
            ( { model | page = Home }, Cmd.none )

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ] []



-- PROGRAM


main : Program Never Model Msg
main =
    Navigation.program (Routes.match >> NewRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    setNewPage (Routes.match location) initialModel
