import XMonad
import Control.Monad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders(noBorders, smartBorders)
import XMonad.Layout.Spacing
import XMonad.Util.WorkspaceCompare
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/velusip/.xmobarrc"
    xmonad $ defaultConfig
        { terminal = "urxvt"
        , borderWidth = 0
        , normalBorderColor = "#000000"
        , focusedBorderColor = "#ffa90a" -- orange
        , modMask = mod4Mask             -- Finland key
        , focusFollowsMouse = True
        , manageHook = composeAll
            [ className =? "Gimp" --> doFloat
            , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
            , manageDocks
            ]
        , logHook = takeTopFocus >> dynamicLogWithPP defaultPP
            { ppCurrent         = xmobarColor "#545" "#c7e0e5"
            , ppVisible         = wrap "(" ")"
            , ppHidden          = id
            , ppHiddenNoWindows = const ""
            , ppUrgent          = xmobarColor "red" "black"
            , ppSep             = " ★ "
            , ppWsSep           = ""
            , ppTitle           = xmobarRainbow . shorten 64
            , ppLayout          = const "" -- suppress layout info
            , ppOrder           = id
            , ppOutput          = hPutStrLn xmproc
            , ppSort            = getSortByIndex
            , ppExtras          = []
            }
        , startupHook = ewmhDesktopsStartup
                        >> setWMName "LG3D"
                        >> takeTopFocus
        , layoutHook = tiled ||| Mirror tiled ||| noBorders Full
        } `additionalKeysP`
            [ ("M-S-x", spawn "slock")
            , ("M-b", sendMessage ToggleStruts)
            , ("M-p", spawn "dmenu_run -i -fn '-*-gohufont-bold-*-*-*-14-*-*-*-*-*-*-*' -nb '#fff' -nf '#555' -sb '#ec826a' -sf '#555'")
            , ("<XF86AudioNext>", spawn "cmus-remote --next")
            , ("<XF86AudioPlay>", spawn "cmus-remote --pause")
            , ("<XF86AudioPrev>", spawn "cmus-remote --prev")
            , ("<XF86AudioStop>", spawn "cmus-remote --stop")
            , ("<XF86AudioRaiseVolume>", spawn "cmus-remote --volume +10%")
            , ("<XF86AudioLowerVolume>", spawn "cmus-remote --volume -10%")
            , ("<XF86Reload>", spawn "cmus-remote --shuffle")
            , ("<XF86Forward>", spawn "cmus-remote --seek +5")
            , ("<XF86Back>", spawn "cmus-remote --seek -5")
            , ("M-xK_Print", spawn "/home/velusip/bin/spai.sh")
            ]
    where tiled = smartBorders $ smartSpacing 8 $ avoidStruts $ Tall 1 0.03 0.5

-- | xmobar string colourising instructions.
xmobarRainbow :: String -> String
xmobarRainbow = rainbow $ flip xmobarColor ""
-- | Rainbow-colours function.
-- first argument: a colouring function
-- function takes a colour descriptor string and a string to colourise.
rainbow :: (String -> String -> String) -> String -> String
rainbow f = join . zipWith colourise colours
    where colourise = (. return)
          colours = cycle $ map f
              [ "#C80046"
              , "#C8001B"
              , "#C81300"
              , "#C83B00"
              , "#C85F00"
              , "#C78200"
              , "#C8A900"
              , "#B8C800"
              , "#8CC700"
              , "#63C800"
              , "#38C800"
              , "#06C800"
              , "#00C82D"
              , "#00C759"
              , "#00C883"
              , "#00C8AD"
              , "#00B3C8"
              , "#008BC7"
              , "#0067C8"
              , "#0043C7"
              , "#001CC8"
              , "#1100C8"
              , "#3C00C7"
              , "#6500C8"
              , "#9100C8"
              ]

