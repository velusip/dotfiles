import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.NoBorders ( noBorders, smartBorders )
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus

myTerminal = "urxvt"
myBorderWidth = 1
myNormalBorderColour = "#000000"
myFocusedBorderColour = "#c050f0" -- purplish
myModMask = mod4Mask -- Finland key
myFocusFollowsMouse = True
myManageHook = manageDocks <+> manageHook defaultConfig
myLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled) ||| noBorders Full
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2
-- myStartupHook = ewmhDesktopsStartup >> setWMName "LG3D" -- deek
myStartupHook = setWMName "LG3D" >> takeTopFocus -- deek


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/velusip/.xmobarrc"
    xmonad $ defaultConfig {
        terminal = myTerminal,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormalBorderColour,
        focusedBorderColor = myNormalBorderColour,
        modMask = mod4Mask,
        focusFollowsMouse = myFocusFollowsMouse,

        -- hooks
        manageHook = myManageHook,
        -- logHook = takeTopFocus >> dynamicLogWithPP xmobarPP
        logHook = do
            dynamicLogWithPP $ xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
            setWMName "LG3D" -- deek
            takeTopFocus
        , startupHook = myStartupHook
        , layoutHook = myLayout
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
            ]
        -- , ((controlMask, xK_Print), spawn "/home/velusip/bin/spai.sh")
        -- , ((mod4Mask, xK_Print), spawn "/home/velusip/bin/spai.sh")

-- The main function.
-- main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
-- Command to launch the bar.
-- myBar = "xmobar"
-- Custom PP, configure it as you like. It determines what is being written to the bar.
-- myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
-- Key binding to toggle the gap for the bar.
-- toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
-- Main configuration, override the defaults to your liking.
-- myConfig = defaultConfig { modMask = mod4Mask }

-- media keysyms
-- XF86AudioNext = 0x1008ff17
-- XF86AudioPlay = 0x1008ff14
-- XF86AudioPrev = 0x1008ff16
-- XF86AudioStop = 0x1008ff15
-- XF86AudioRaiseVolume = 0x1008ff13
-- XF86AudioLowerVolume = 0x1008ff11
-- XF86Reload = 0x1008ff73
-- XF86Forward = 0x1008ff27
-- XF86Back = 0x1008ff26

