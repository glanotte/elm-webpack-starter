module Routes exposing (Route(..), match, routeToUrl, visit)

import Navigation
import UrlParser as Url exposing ((</>))


type Route
    = Home


routes : Url.Parser (Route -> a) a
routes =
    Url.oneOf
        [ Url.map Home Url.top
        ]


match : Navigation.Location -> Maybe Route
match location =
    Url.parsePath routes location


routeToUrl : Route -> String
routeToUrl route =
    case route of
        Home ->
            "/"


visit : Route -> Cmd msg
visit route =
    routeToUrl route
        |> Navigation.newUrl
