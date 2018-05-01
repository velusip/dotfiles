Config { font = "xft:Gohu Gohufont:pixelsize=14:style=bold"
       , bgColor = "#fef9ec"
       , fgColor = "#566"
       , textOffset = 14
       , borderColor = "#fef9ec"
       , border = NoBorder
       , hideOnStart = False
       , persistent = False
       , position = TopW L 95
       , lowerOnStart = True
       , pickBroadest = False
       , allDesktops = True
       , overrideRedirect = False
       , commands = [ Run Cpu [ "-t", "<icon=/home/velusip/.xmonad/icon/amd.xbm/><total>"
                              , "-p", "2", "-m", "2", "-c", "0"
                              , "-L", "10", "-H", "60"
                              , "-l", "#0ac", "-n", "#a90", "-h", "#d6c"
                              ] 5
                    , Run Memory [ "-t", "<icon=/home/velusip/.xmonad/icon/mem.xbm/><usedratio>"
                                 , "-p", "2", "-m", "2", "-c", "0"
                                 , "-L", "20", "-H", "70"
                                 , "-l", "#0ac", "-n", "#a90", "-h", "#d6c"
                                 ] 20
                    , Run DynNetwork [ "-t", "<icon=/home/velusip/.xmonad/icon/down.xbm/><rx><icon=/home/velusip/.xmonad/icon/up.xbm/><tx>"
                                     , "-m", "4", "-c", "0"
                                     , "-L", "2000", "-H", "20000"
                                     , "-l", "#0ac", "-n", "#a90", "-h", "#d6c"
                                     ] 8
                    , Run Com "date" [ "+%a %b %d %H%Mh" ] "date" 600
                    , Run Com "/home/velusip/bin/temps" [] "temps" 100
                    , Run Com "/home/velusip/bin/npcmus" ["-s", "*"] "npcmus" 8
                    , Run Com "/home/velusip/bin/wallpaper" [] "wallpaper" 7200
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader%}{%wallpaper%%npcmus% <icon=/home/velusip/.xmonad/icon/temp.xbm/>%temps% %cpu%%memory%%dynnetwork%<icon=/home/velusip/.xmonad/icon/time.xbm/>%date%"
       }
