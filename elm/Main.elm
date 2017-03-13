module Main exposing (..)

import Html
import App.Todo as Todo


main : Program Never Todo.Model Todo.Msg
main =
    Html.program
        { init = Todo.init
        , view = Todo.view
        , update = Todo.update
        , subscriptions = Todo.subscriptions
        }
