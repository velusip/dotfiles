import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders(noBorders, smartBorders)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/velusip/.xmobarrc"
    xmonad $ defaultConfig {
        terminal = "urxvt"
        , borderWidth = 1
        , normalBorderColor = "#000000"
        , focusedBorderColor = "#c050f0" -- magenta
        , modMask = mod4Mask             -- Finland key
        , focusFollowsMouse = True
        , manageHook = composeAll
            [ className =? "Gimp" --> doFloat
            , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
            , manageDocks
            ]
        -- logHook = takeTopFocus >> dynamicLogWithPP xmobarPP
        , logHook = do
            dynamicLogWithPP $ xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "#c050f0" "" . shorten 20
                }
            setWMName "LG3D"
            takeTopFocus
        , startupHook = ewmhDesktopsStartup
                        >> setWMName "LG3D"
                        >> takeTopFocus
        , layoutHook = avoidStruts $ smartBorders (Tall 1 0.03 0.5)
                                   ||| smartBorders (Mirror (Tall 1 0.03 0.5))
                                   ||| noBorders Full
        } `additionalKeysP`
            [ ("M-S-x", spawn "slock")
            , ("M-b", sendMessage ToggleStruts)
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

