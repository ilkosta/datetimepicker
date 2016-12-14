module DatePicker.Css exposing (css)

{-| DatePicker.Css

Using [rtfeldman/elm-css](http://package.elm-lang.org/packages/rtfeldman/elm-css/latest)
Include this in your elm-css port module to be included in your project's css file.

# Css
@docs css
-}

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import DatePicker.SharedStyles exposing (CssClasses(..), datepickerNamespace)


{-| DatePicker's Css Stylesheet
-}
css : Css.Stylesheet
css =
    (Css.stylesheet << namespace datepickerNamespace.name)
        [ (.) DatePicker
            [ position relative ]
        , (.) Dialog
            [ fontFamilies [ "Arial", "Helvetica", "sans-serif" ]
            , fontSize (px 14)
            , borderBoxMixin
            , position absolute
            , border3 (px 1) solid (darkGray)
            , boxShadow4 (px 0) (px 5) (px 10) (rgba 0 0 0 0.2)
            , children dialogCss
            , property "z-index" "1"
            ]
        ]


dialogCss : List Css.Snippet
dialogCss =
    [ (.) DatePickerDialog
        [ float left
        , height calendarHeight
        , children datePickerDialogCss
        ]
    , (.) TimePickerDialog
        [ float left
        , width (px 120)
        , height calendarHeight
        , textAlign center
        , borderLeft3 (px 1) solid (darkGray)
        , children timePickerDialogCss
        ]
    ]


timePickerDialogCss : List Css.Snippet
timePickerDialogCss =
    [ (.) Header
        [ headerMixin
        ]
    , (.) Body
        [ descendants
            [ table
                [ tableMixin
                , width (pct 100)
                , descendants
                    [ tr
                        [ verticalAlign top
                        , withClass ArrowUp
                            [ backgroundColor lightGray
                            , children
                                [ td [ borderBottom3 (px 1) solid darkGray ]
                                ]
                            ]
                        , withClass ArrowDown
                            [ backgroundColor lightGray
                            , children [ td [ borderTop3 (px 1) solid darkGray ] ]
                            ]
                        ]
                    , td
                        [ width (pct 33)
                        , cellMixin
                        ]
                    ]
                ]
            ]
        ]
    ]


datePickerDialogCss : List Css.Snippet
datePickerDialogCss =
    [ (.) Header
        [ borderBoxMixin
        , headerMixin
        , position relative
        , children
            [ (.) ArrowLeft
                [ arrowMixin
                , left (px 0)
                ]
            , (.) ArrowRight
                [ arrowMixin
                , right (px 0)
                ]
            , (.) Title
                [ borderBoxMixin
                , display inlineBlock
                , width (pct 100)
                , textAlign center
                ]
            ]
        ]
    , (.) Calendar
        [ backgroundColor (hex "#ffffff")
        , tableMixin
        , width auto
        , margin (px 0)
        , descendants
            [ thead
                []
            , td
                [ dayMixin
                , hover
                    [ backgroundColor highlightedDay
                    , highlightMixin
                    ]
                ]
            , th
                [ dayMixin
                , backgroundColor (lightGray)
                , fontWeight normal
                , borderBottom3 (px 1) solid (darkGray)
                ]
            , (.) PreviousMonth
                [ color fadeText ]
            , (.) NextMonth
                [ color fadeText
                ]
            , (.) SelectedDate
                [ property "box-shadow" "inset 0 0 10px 3px #3276b1"
                , backgroundColor selectedDate
                , color (hex "#fff")
                , highlightMixin
                ]
            , (.) Today
                [ property "box-shadow" "inset 0 0 7px 0 #76abd9"
                , highlightMixin
                , hover
                    [ backgroundColor highlightSelectedDay ]
                ]
            ]
        ]
    , (.) Footer
        [ textAlign center
        , backgroundColor lightGray
        , padding2 (px 7) (px 7)
        , borderTop3 (px 1) solid darkGray
        , height (px 16)
        ]
    ]


highlightSelectedDay : Css.Color
highlightSelectedDay =
    hex "#d5e5f3"


selectedDate : Css.Color
selectedDate =
    hex "#428bca"


fadeText : Css.Color
fadeText =
    hex "#a1a1a1"


lightGray : Css.Color
lightGray =
    hex "#f5f5f5"


darkGray : Css.Color
darkGray =
    hex "#ccc"


highlightedDay : Css.Color
highlightedDay =
    hex "#ebebeb"


dayMixin : Css.Mixin
dayMixin =
    mixin
        [ cellMixin
        , textAlign right
        ]


cellMixin : Css.Mixin
cellMixin =
    mixin
        [ padding4 (px 7) (px 7) (px 7) (px 9)
        , border (px 0)
        , cursor pointer
        ]


arrowMixin : Css.Mixin
arrowMixin =
    mixin
        [ borderBoxMixin
        , textAlign center
        , transform (scale 0.8)
        , position absolute
        , padding2 (px 0) (px 8)
        , cursor pointer
        ]


borderBoxMixin : Css.Mixin
borderBoxMixin =
    mixin [ boxSizing borderBox ]


highlightMixin : Css.Mixin
highlightMixin =
    mixin [ borderRadius (px 4) ]


headerMixin : Css.Mixin
headerMixin =
    mixin
        [ padding2 (px 10) (px 7)
        , backgroundColor (lightGray)
        ]


calendarHeight : Css.Px
calendarHeight =
    px 277


tableMixin : Css.Mixin
tableMixin =
    mixin
        [ property "border-spacing" "0"
        , property "border-width" "0"
        , property "table-layout" "fixed"
        ]
