import XMonad
import Control.Monad
import XMonad.Hooks.DynamicLog -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-DynamicLog.html
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName -- for Java
-- import XMonad.Hooks.ICCCMFocus -- takeTopFocus
import XMonad.Hooks.EwmhDesktops -- for Java
import XMonad.Layout.NoBorders(noBorders)
import XMonad.Layout.Spacing
import XMonad.Util.WorkspaceCompare
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.GroupNavigation -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-GroupNavigation.html
import Graphics.X11.ExtraTypes.XF86 -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-ExtraTypes-XF86.html
import System.IO
import qualified Data.Map as M

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ myConfig xmproc

myConfig xmprocHandle = defaultConfig
    { startupHook = myStartupHook
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , logHook = myLogHook xmprocHandle <+> historyHook
    , modMask = mod4Mask -- Finland key
    , keys = myKeys <+> keys defaultConfig
    , terminal = "urxvt"
    , borderWidth = 0
--    , normalBorderColor = "#000001"
--    , focusedBorderColor = "#ffa90a" -- orange
    , focusFollowsMouse = True
    }

myStartupHook = ewmhDesktopsStartup >> setWMName "LG3D" -- for some window creation issues

myLayoutHook = avoidStruts(tiled ||| Mirror tiled ||| noBorders Full)

tiled = noBorders $ smartSpacing 8 $ Tall 1 0.03 0.5

myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
    , className =? "Steam" --> doFloat
    , manageDocks
    ]

myLogHook :: Handle -> X ()
-- myLogHook xmproc = takeTopFocus >> dynamicLogWithPP defaultPP
myLogHook xmproc = dynamicLogWithPP defaultPP
    { ppCurrent         = xmobarColor "#545" "#c7e0e5"
    , ppVisible         = wrap "(" ")"
    , ppHidden          = id
    , ppHiddenNoWindows = const ""
    , ppUrgent          = xmobarColor "red" "black"
    , ppSep             = " ★ " -- requires UTF-8 type installed
    , ppWsSep           = ""
    , ppTitle           = xmobarRainbow . shorten 64
    , ppLayout          = const "" -- suppress layout info
    , ppOrder           = id
    , ppOutput          = hPutStrLn xmproc
    , ppSort            = getSortByIndex
    , ppExtras          = []
    }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, xK_b), sendMessage ToggleStruts)
    , ((modMask .|. shiftMask, xK_m), nextMatch History (return True))
    , ((modMask .|. shiftMask, xK_x), spawn "slock")
    , ((modMask, xK_p), spawn "dmenu_run -i -fn 'xft:gohufont:pixelsize=14:Bold' -nb '#fff' -nf '#555' -sb '#ec826a' -sf '#555'")
    , ((modMask, xK_Print), spawn "ssur -u")
    , ((0, xK_Print), spawn "ssur")
    , ((0, xF86XK_AudioNext), spawn "cmus-remote --next")
    , ((0, xF86XK_AudioPlay), spawn "cmus-remote --pause")
    , ((0, xF86XK_AudioPrev), spawn "cmus-remote --prev")
    , ((0, xF86XK_AudioStop), spawn "cmus-remote --stop")
    , ((0, xF86XK_AudioRaiseVolume), spawn "cmus-remote --volume +10%")
    , ((0, xF86XK_AudioLowerVolume), spawn "cmus-remote --volume -10%")
    , ((0, xF86XK_Reload), spawn "cmus-remote --shuffle")
    , ((0, xF86XK_Forward), spawn "cmus-remote --seek +5")
    , ((0, xF86XK_Back), spawn "cmus-remote --seek -5")
    ]

-- | for colourizing xmobar ppTitle
xmobarRainbow :: String -> String
xmobarRainbow = rainbow $ flip xmobarColor ""

-- | Hardcoded rainbow colours
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

