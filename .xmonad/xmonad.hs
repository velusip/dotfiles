import XMonad
import XMonad.Config.Desktop -- default struts management, adds mod+b
import XMonad.Layout.NoBorders -- for smartBorders (no border when lonely or floating)
import XMonad.Layout.Spacing -- window gaps, for smartSpacing
import XMonad.Hooks.DynamicLog -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-DynamicLog.html
import XMonad.Util.Run(spawnPipe)
import Control.Monad
import Graphics.X11.ExtraTypes.XF86 -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-ExtraTypes-XF86.html
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = do
    dyninput <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad desktopConfig
        { terminal = "st"
        , modMask = mod4Mask -- Super_L key
        , focusFollowsMouse = True
        , borderWidth = 0
        , normalBorderColor = "#fef9ec"
        , focusedBorderColor = "#a90"
        , layoutHook = smartBorders $ layoutHook desktopConfig
        , keys = myKeys <+> keys desktopConfig
        , manageHook = manageHook desktopConfig
        , logHook = dynamicLogWithPP $ myPP dyninput
        }

-- see https://hackage.haskell.org/package/xmonad-contrib-0.13/docs/src/XMonad-Hooks-DynamicLog.html
myPP h = defaultPP
    { ppCurrent = xmobarColor "#566" "#6ef"
    , ppUrgent = xmobarColor "red" "black"
    , ppSep = " * "
    , ppWsSep = "" -- no spacing between workspace numbers
    , ppTitle = xmobarRainbow . shorten 64
    , ppLayout = const "" -- no layout info
    , ppOutput = hPutStrLn h
    }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask, xK_x), spawn "slock")
    , ((modMask, xK_p), spawn "dmenu_run -i -nb '#fef9ec' -nf '#566' -sb '#6ef' -sf '#566' -fn 'Gohu Gohufont:pixelsize=14'")
    , ((0, xK_Print), spawn "/home/velusip/bin/ssur")
    , ((0, xF86XK_AudioNext), spawn "cmus-remote --next")
    , ((0, xF86XK_AudioPlay), spawn "cmus-remote --pause")
    , ((0, xF86XK_AudioPrev), spawn "cmus-remote --prev")
    , ((0, xF86XK_AudioStop), spawn "cmus-remote --stop")
    , ((0, xF86XK_AudioRaiseVolume), spawn "cmus-remote --volume +4%")
    , ((0, xF86XK_AudioLowerVolume), spawn "cmus-remote --volume -4%")
    , ((0, xF86XK_Reload), spawn "cmus-remote --shuffle")
    , ((0, xK_Cancel), spawn "/home/velusip/bin/trackskip -r 1")
    , ((0, xF86XK_Back), spawn "/home/velusip/bin/trackskip -r 2")
    , ((0, xF86XK_HomePage), spawn "/home/velusip/bin/trackskip -r 3")
    , ((0, xF86XK_Forward), spawn "/home/velusip/bin/trackskip -r 4")
    , ((0, xF86XK_Favorites), spawn "/home/velusip/bin/trackskip -r 5")
    ]
-- example of running multiple commands per keybind
--    ++
--    [ ((m .|. modMask, k), sequence_ [spawn $ "workspacer " ++ show k, windows $ f i]) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
--    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
--    ]

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

