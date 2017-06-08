import XMonad
import XMonad.Config.Desktop -- default struts management, adds mod+b
import XMonad.Hooks.DynamicLog -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-DynamicLog.html
import XMonad.Hooks.SetWMName -- for Java
import XMonad.Hooks.EwmhDesktops -- for Java
import XMonad.Util.Run(spawnPipe)
import Control.Monad
import Graphics.X11.ExtraTypes.XF86 -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-ExtraTypes-XF86.html
import System.IO
import qualified Data.Map as M

main = do
    dyninput <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ desktopConfig
        { terminal = "st"
        , modMask = mod4Mask -- Finland key
        , focusFollowsMouse = True
        , borderWidth = 0
--        , normalBorderColor = "#000001"
--        , focusedBorderColor = "#ffa90a" -- orange
        , keys = myKeys <+> keys desktopConfig
--        , handleEventHook = handleEventHook desktopConfig <+> fullscreenEventHook
        , manageHook = manageHook desktopConfig
        , logHook = dynamicLogWithPP $ myPP dyninput
        , startupHook = ewmhDesktopsStartup >> setWMName "LG3D" -- for some window creation issues
        }

myPP h = defaultPP
    { ppCurrent = xmobarColor "#545" "#c7e0e5"
    , ppVisible = wrap "(" ")"
    , ppHidden = id
    , ppHiddenNoWindows = const ""
    , ppUrgent = xmobarColor "red" "black"
    , ppSep = " ★ " -- requires UTF-8 type installed
    , ppWsSep = ""
    , ppTitle = xmobarRainbow . shorten 64
    , ppLayout = const "" -- suppress layout info
    , ppOrder = id
    , ppOutput = hPutStrLn h
    , ppExtras = []
    }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask, xK_x), spawn "slock")
    , ((modMask, xK_p), spawn "dmenu_run -i -fn gohufont-14:bold -nb '#fff' -nf '#555' -sb '#ec826a' -sf '#555'")
--    , ((modMask, xK_Print), spawn "ssur -u")
    , ((0, xK_Print), spawn "ssur")
    , ((0, xF86XK_AudioNext), spawn "cmus-remote --next")
    , ((0, xF86XK_AudioPlay), spawn "cmus-remote --pause")
    , ((0, xF86XK_AudioPrev), spawn "cmus-remote --prev")
    , ((0, xF86XK_AudioStop), spawn "cmus-remote --stop")
    , ((0, xF86XK_AudioRaiseVolume), spawn "cmus-remote --volume +10%")
    , ((0, xF86XK_AudioLowerVolume), spawn "cmus-remote --volume -10%")
    , ((0, xF86XK_Reload), spawn "cmus-remote --shuffle")
    , ((0, xF86XK_Stop), spawn "songrating.sh 1")
    , ((0, xF86XK_Back), spawn "songrating.sh 2")
    , ((0, xF86XK_HomePage), spawn "songrating.sh 3")
    , ((0, xF86XK_Forward), spawn "songrating.sh 4")
    , ((0, xF86XK_Favorites), spawn "songrating.sh 5")
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

