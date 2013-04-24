note
	description	: "SPI constants for SystemParametersInfo."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SPI_CONSTANTS

feature -- SystemParameter (All Windows)

	Spi_getsnaptodefbutton: INTEGER = 95
			-- Declared in Windows as SPI_GETSNAPTODEFBUTTON

	Spi_setsnaptodefbutton: INTEGER = 96
			-- Declared in Windows as SPI_SETSNAPTODEFBUTTON

	Spi_getserialkeys: INTEGER = 62
			-- Declared in Windows as SPI_GETSERIALKEYS

	Spi_setserialkeys: INTEGER = 63
			-- Declared in Windows as SPI_SETSERIALKEYS

	Spi_setdragfullwindows: INTEGER = 37
			-- Declared in Windows as SPI_SETDRAGFULLWINDOWS

	Spi_getdragfullwindows: INTEGER = 38
			-- Declared in Windows as SPI_GETDRAGFULLWINDOWS

	Spi_getnonclientmetrics: INTEGER = 41
			-- Declared in Windows as SPI_GETNONCLIENTMETRICS

	Spi_setnonclientmetrics: INTEGER = 42
			-- Declared in Windows as SPI_SETNONCLIENTMETRICS

	Spi_getminimizedmetrics: INTEGER = 43
			-- Declared in Windows as SPI_GETMINIMIZEDMETRICS

	Spi_setminimizedmetrics: INTEGER = 44
			-- Declared in Windows as SPI_SETMINIMIZEDMETRICS

	Spi_geticonmetrics: INTEGER = 45
			-- Declared in Windows as SPI_GETICONMETRICS

	Spi_seticonmetrics: INTEGER = 46
			-- Declared in Windows as SPI_SETICONMETRICS

	Spi_setworkarea: INTEGER = 47
			-- Declared in Windows as SPI_SETWORKAREA

	Spi_getworkarea: INTEGER = 48
			-- Declared in Windows as SPI_GETWORKAREA

	Spi_setpenwindows: INTEGER = 49
			-- Declared in Windows as SPI_SETPENWINDOWS

	Spi_gethighcontrast: INTEGER = 66
			-- Declared in Windows as SPI_GETHIGHCONTRAST

	Spi_sethighcontrast: INTEGER = 67
			-- Declared in Windows as SPI_SETHIGHCONTRAST

	Spi_getkeyboardpref: INTEGER = 68
			-- Declared in Windows as SPI_GETKEYBOARDPREF

	Spi_setkeyboardpref: INTEGER = 69
			-- Declared in Windows as SPI_SETKEYBOARDPREF

	Spi_getscreenreader: INTEGER = 70
			-- Declared in Windows as SPI_GETSCREENREADER

	Spi_setscreenreader: INTEGER = 71
			-- Declared in Windows as SPI_SETSCREENREADER

	Spi_getanimation: INTEGER = 72
			-- Declared in Windows as SPI_GETANIMATION

	Spi_setanimation: INTEGER = 73
			-- Declared in Windows as SPI_SETANIMATION

	Spi_getfontsmoothing: INTEGER = 74
			-- Declared in Windows as SPI_GETFONTSMOOTHING

	Spi_setfontsmoothing: INTEGER = 75
			-- Declared in Windows as SPI_SETFONTSMOOTHING

	Spi_setdragwidth: INTEGER = 76
			-- Declared in Windows as SPI_SETDRAGWIDTH

	Spi_setdragheight: INTEGER = 77
			-- Declared in Windows as SPI_SETDRAGHEIGHT

	Spi_sethandheld: INTEGER = 78
			-- Declared in Windows as SPI_SETHANDHELD

	Spi_getlowpowertimeout: INTEGER = 79
			-- Declared in Windows as SPI_GETLOWPOWERTIMEOUT

	Spi_getpowerofftimeout: INTEGER = 80
			-- Declared in Windows as SPI_GETPOWEROFFTIMEOUT

	Spi_setlowpowertimeout: INTEGER = 81
			-- Declared in Windows as SPI_SETLOWPOWERTIMEOUT

	Spi_setpowerofftimeout: INTEGER = 82
			-- Declared in Windows as SPI_SETPOWEROFFTIMEOUT

	Spi_getlowpoweractive: INTEGER = 83
			-- Declared in Windows as SPI_GETLOWPOWERACTIVE

	Spi_getpoweroffactive: INTEGER = 84
			-- Declared in Windows as SPI_GETPOWEROFFACTIVE

	Spi_setlowpoweractive: INTEGER = 85
			-- Declared in Windows as SPI_SETLOWPOWERACTIVE

	Spi_setpoweroffactive: INTEGER = 86
			-- Declared in Windows as SPI_SETPOWEROFFACTIVE

	Spi_setcursors: INTEGER = 87
			-- Declared in Windows as SPI_SETCURSORS

	Spi_seticons: INTEGER = 88
			-- Declared in Windows as SPI_SETICONS

	Spi_getdefaultinputlang: INTEGER = 89
			-- Declared in Windows as SPI_GETDEFAULTINPUTLANG

	Spi_setdefaultinputlang: INTEGER = 90
			-- Declared in Windows as SPI_SETDEFAULTINPUTLANG

	Spi_setlangtoggle: INTEGER = 91
			-- Declared in Windows as SPI_SETLANGTOGGLE

	Spi_getwindowsextension: INTEGER = 92
			-- Declared in Windows as SPI_GETWINDOWSEXTENSION

	Spi_setmousetrails: INTEGER = 93
			-- Declared in Windows as SPI_SETMOUSETRAILS

	Spi_getmousetrails: INTEGER = 94
			-- Declared in Windows as SPI_GETMOUSETRAILS

	Spi_setscreensaverrunning: INTEGER = 97
			-- Declared in Windows as SPI_SETSCREENSAVERRUNNING

	Spi_screensaverrunning: INTEGER = 97
			-- Declared in Windows as SPI_SCREENSAVERRUNNING

	Spi_getbeep: INTEGER = 1
			-- Declared in Windows as SPI_GETBEEP

	Spi_setbeep: INTEGER = 2
			-- Declared in Windows as SPI_SETBEEP

	Spi_getmouse: INTEGER = 3
			-- Declared in Windows as SPI_GETMOUSE

	Spi_setmouse: INTEGER = 4
			-- Declared in Windows as SPI_SETMOUSE

	Spi_getborder: INTEGER = 5
			-- Declared in Windows as SPI_GETBORDER

	Spi_setborder: INTEGER = 6
			-- Declared in Windows as SPI_SETBORDER

	Spi_getkeyboardspeed: INTEGER = 10
			-- Declared in Windows as SPI_GETKEYBOARDSPEED

	Spi_setkeyboardspeed: INTEGER = 11
			-- Declared in Windows as SPI_SETKEYBOARDSPEED

	Spi_langdriver: INTEGER = 12
			-- Declared in Windows as SPI_LANGDRIVER

	Spi_iconhorizontalspacing: INTEGER = 13
			-- Declared in Windows as SPI_ICONHORIZONTALSPACING

	Spi_getscreensavetimeout: INTEGER = 14
			-- Declared in Windows as SPI_GETSCREENSAVETIMEOUT

	Spi_setscreensavetimeout: INTEGER = 15
			-- Declared in Windows as SPI_SETSCREENSAVETIMEOUT

	Spi_getscreensaveactive: INTEGER = 16
			-- Declared in Windows as SPI_GETSCREENSAVEACTIVE

	Spi_setscreensaveactive: INTEGER = 17
			-- Declared in Windows as SPI_SETSCREENSAVEACTIVE

	Spi_getgridgranularity: INTEGER = 18
			-- Declared in Windows as SPI_GETGRIDGRANULARITY

	Spi_setgridgranularity: INTEGER = 19
			-- Declared in Windows as SPI_SETGRIDGRANULARITY

	Spi_setdeskwallpaper: INTEGER = 20
			-- Declared in Windows as SPI_SETDESKWALLPAPER

	Spi_setdeskpattern: INTEGER = 21
			-- Declared in Windows as SPI_SETDESKPATTERN

	Spi_getkeyboarddelay: INTEGER = 22
			-- Declared in Windows as SPI_GETKEYBOARDDELAY

	Spi_setkeyboarddelay: INTEGER = 23
			-- Declared in Windows as SPI_SETKEYBOARDDELAY

	Spi_iconverticalspacing: INTEGER = 24
			-- Declared in Windows as SPI_ICONVERTICALSPACING

	Spi_geticontitlewrap: INTEGER = 25
			-- Declared in Windows as SPI_GETICONTITLEWRAP

	Spi_seticontitlewrap: INTEGER = 26
			-- Declared in Windows as SPI_SETICONTITLEWRAP

	Spi_getmenudropalignment: INTEGER = 27
			-- Declared in Windows as SPI_GETMENUDROPALIGNMENT

	Spi_setmenudropalignment: INTEGER = 28
			-- Declared in Windows as SPI_SETMENUDROPALIGNMENT

	Spi_setdoubleclkwidth: INTEGER = 29
			-- Declared in Windows as SPI_SETDOUBLECLKWIDTH

	Spi_setdoubleclkheight: INTEGER = 30
			-- Declared in Windows as SPI_SETDOUBLECLKHEIGHT

	Spi_geticontitlelogfont: INTEGER = 31
			-- Declared in Windows as SPI_GETICONTITLELOGFONT

	Spi_setdoubleclicktime: INTEGER = 32
			-- Declared in Windows as SPI_SETDOUBLECLICKTIME

	Spi_setmousebuttonswap: INTEGER = 33
			-- Declared in Windows as SPI_SETMOUSEBUTTONSWAP

	Spi_seticontitlelogfont: INTEGER = 34
			-- Declared in Windows as SPI_SETICONTITLELOGFONT

	Spi_getfasttaskswitch: INTEGER = 35
			-- Declared in Windows as SPI_GETFASTTASKSWITCH

	Spi_setfasttaskswitch: INTEGER = 36
			-- Declared in Windows as SPI_SETFASTTASKSWITCH

	Spi_getfilterkeys: INTEGER = 50
			-- Declared in Windows as SPI_GETFILTERKEYS

	Spi_setfilterkeys: INTEGER = 51
			-- Declared in Windows as SPI_SETFILTERKEYS

	Spi_gettogglekeys: INTEGER = 52
			-- Declared in Windows as SPI_GETTOGGLEKEYS

	Spi_settogglekeys: INTEGER = 53
			-- Declared in Windows as SPI_SETTOGGLEKEYS

	Spi_getmousekeys: INTEGER = 54
			-- Declared in Windows as SPI_GETMOUSEKEYS

	Spi_setmousekeys: INTEGER = 55
			-- Declared in Windows as SPI_SETMOUSEKEYS

	Spi_getshowsounds: INTEGER = 56
			-- Declared in Windows as SPI_GETSHOWSOUNDS

	Spi_setshowsounds: INTEGER = 57
			-- Declared in Windows as SPI_SETSHOWSOUNDS

	Spi_getstickykeys: INTEGER = 58
			-- Declared in Windows as SPI_GETSTICKYKEYS

	Spi_setstickykeys: INTEGER = 59
			-- Declared in Windows as SPI_SETSTICKYKEYS

	Spi_getaccesstimeout: INTEGER = 60
			-- Declared in Windows as SPI_GETACCESSTIMEOUT

	Spi_setaccesstimeout: INTEGER = 61
			-- Declared in Windows as SPI_SETACCESSTIMEOUT

	Spi_getsoundsentry: INTEGER = 64
			-- Declared in Windows as SPI_GETSOUNDSENTRY

	Spi_setsoundsentry: INTEGER = 65
			-- Declared in Windows as SPI_SETSOUNDSENTRY

feature -- SystemParameter (Windows NT 4.0, Windows 98, Windows 2000 and above)

	Spi_getmousehoverwidth: INTEGER = 98
			-- Declared in Windows as SPI_GETMOUSEHOVERWIDTH

	Spi_setmousehoverwidth: INTEGER = 99
			-- Declared in Windows as SPI_SETMOUSEHOVERWIDTH

	Spi_getmousehoverheight: INTEGER = 100
			-- Declared in Windows as SPI_GETMOUSEHOVERHEIGHT

	Spi_setmousehoverheight: INTEGER = 101
			-- Declared in Windows as SPI_SETMOUSEHOVERHEIGHT

	Spi_getmousehovertime: INTEGER = 102
			-- Declared in Windows as SPI_GETMOUSEHOVERTIME

	Spi_setmousehovertime: INTEGER = 103
			-- Declared in Windows as SPI_SETMOUSEHOVERTIME

	Spi_getwheelscrolllines: INTEGER = 104
			-- Declared in Windows as SPI_GETWHEELSCROLLLINES

	Spi_setwheelscrolllines: INTEGER = 105
			-- Declared in Windows as SPI_SETWHEELSCROLLLINES

	Spi_getmenushowdelay: INTEGER = 106
			-- Declared in Windows as SPI_GETMENUSHOWDELAY

	Spi_setmenushowdelay: INTEGER = 107
			-- Declared in Windows as SPI_SETMENUSHOWDELAY

	Spi_getshowimeui: INTEGER = 110
			-- Declared in Windows as SPI_GETSHOWIMEUI

	Spi_setshowimeui: INTEGER = 111
			-- Declared in Windows as SPI_SETSHOWIMEUI

feature -- SystemParameter (Windows 98, Windows 2000 and above)

	Spi_getmousespeed: INTEGER = 112
			-- Declared in Windows as SPI_GETMOUSESPEED

	Spi_setmousespeed: INTEGER = 113
			-- Declared in Windows as SPI_SETMOUSESPEED

	Spi_getscreensaverrunning: INTEGER = 114
			-- Declared in Windows as SPI_GETSCREENSAVERRUNNING

	Spi_getdeskwallpaper: INTEGER = 115
			-- Declared in Windows as SPI_GETDESKWALLPAPER

	Spi_getactivewindowtracking: INTEGER = 4096
			-- Declared in Windows as SPI_GETACTIVEWINDOWTRACKING

	Spi_setactivewindowtracking: INTEGER = 4097
			-- Declared in Windows as SPI_SETACTIVEWINDOWTRACKING

	Spi_getmenuanimation: INTEGER = 4098
			-- Declared in Windows as SPI_GETMENUANIMATION

	Spi_setmenuanimation: INTEGER = 4099
			-- Declared in Windows as SPI_SETMENUANIMATION

	Spi_getcomboboxanimation: INTEGER = 4100
			-- Declared in Windows as SPI_GETCOMBOBOXANIMATION

	Spi_setcomboboxanimation: INTEGER = 4101
			-- Declared in Windows as SPI_SETCOMBOBOXANIMATION

	Spi_getlistboxsmoothscrolling: INTEGER = 4102
			-- Declared in Windows as SPI_GETLISTBOXSMOOTHSCROLLING

	Spi_setlistboxsmoothscrolling: INTEGER = 4103
			-- Declared in Windows as SPI_SETLISTBOXSMOOTHSCROLLING

	Spi_getgradientcaptions: INTEGER = 4104
			-- Declared in Windows as SPI_GETGRADIENTCAPTIONS

	Spi_setgradientcaptions: INTEGER = 4105
			-- Declared in Windows as SPI_SETGRADIENTCAPTIONS

	Spi_getkeyboardcues: INTEGER = 4106
			-- Declared in Windows as SPI_GETKEYBOARDCUES

	Spi_setkeyboardcues: INTEGER = 4107
			-- Declared in Windows as SPI_SETKEYBOARDCUES

	Spi_getmenuunderlines: INTEGER = 4106
			-- Declared in Windows as SPI_GETMENUUNDERLINES

	Spi_setmenuunderlines: INTEGER = 4107
			-- Declared in Windows as SPI_SETMENUUNDERLINES

	Spi_getactivewndtrkzorder: INTEGER = 4108
			-- Declared in Windows as SPI_GETACTIVEWNDTRKZORDER

	Spi_setactivewndtrkzorder: INTEGER = 4109
			-- Declared in Windows as SPI_SETACTIVEWNDTRKZORDER

	Spi_gethottracking: INTEGER = 4110
			-- Declared in Windows as SPI_GETHOTTRACKING

	Spi_sethottracking: INTEGER = 4111
			-- Declared in Windows as SPI_SETHOTTRACKING

	Spi_getmenufade: INTEGER = 4114
			-- Declared in Windows as SPI_GETMENUFADE

	Spi_setmenufade: INTEGER = 4115
			-- Declared in Windows as SPI_SETMENUFADE

	Spi_getselectionfade: INTEGER = 4116
			-- Declared in Windows as SPI_GETSELECTIONFADE

	Spi_setselectionfade: INTEGER = 4117
			-- Declared in Windows as SPI_SETSELECTIONFADE

	Spi_gettooltipanimation: INTEGER = 4118
			-- Declared in Windows as SPI_GETTOOLTIPANIMATION

	Spi_settooltipanimation: INTEGER = 4119
			-- Declared in Windows as SPI_SETTOOLTIPANIMATION

	Spi_gettooltipfade: INTEGER = 4120
			-- Declared in Windows as SPI_GETTOOLTIPFADE

	Spi_settooltipfade: INTEGER = 4121
			-- Declared in Windows as SPI_SETTOOLTIPFADE

	Spi_getcursorshadow: INTEGER = 4122
			-- Declared in Windows as SPI_GETCURSORSHADOW

	Spi_setcursorshadow: INTEGER = 4123
			-- Declared in Windows as SPI_SETCURSORSHADOW

	Spi_getuieffects: INTEGER = 4158
			-- Declared in Windows as SPI_GETUIEFFECTS

	Spi_setuieffects: INTEGER = 4159
			-- Declared in Windows as SPI_SETUIEFFECTS

	Spi_getforegroundlocktimeout: INTEGER = 8192
			-- Declared in Windows as SPI_GETFOREGROUNDLOCKTIMEOUT

	Spi_setforegroundlocktimeout: INTEGER = 8193
			-- Declared in Windows as SPI_SETFOREGROUNDLOCKTIMEOUT

	Spi_getactivewndtrktimeout: INTEGER = 8194
			-- Declared in Windows as SPI_GETACTIVEWNDTRKTIMEOUT

	Spi_setactivewndtrktimeout: INTEGER = 8195
			-- Declared in Windows as SPI_SETACTIVEWNDTRKTIMEOUT

	Spi_getforegroundflashcount: INTEGER = 8196
			-- Declared in Windows as SPI_GETFOREGROUNDFLASHCOUNT

	Spi_setforegroundflashcount: INTEGER = 8197
			-- Declared in Windows as SPI_SETFOREGROUNDFLASHCOUNT

	Spi_getcaretwidth: INTEGER = 8198
			-- Declared in Windows as SPI_GETCARETWIDTH

	Spi_setcaretwidth: INTEGER = 8199
			-- Declared in Windows as SPI_SETCARETWIDTH

feature -- SystemParameter (Windows XP and above)

	Spi_getmousesonar: INTEGER = 4124
			-- Declared in Windows as SPI_GETMOUSESONAR

	Spi_setmousesonar: INTEGER = 4125
			-- Declared in Windows as SPI_SETMOUSESONAR

	Spi_getmouseclicklock: INTEGER = 4126
			-- Declared in Windows as SPI_GETMOUSECLICKLOCK

	Spi_setmouseclicklock: INTEGER = 4127
			-- Declared in Windows as SPI_SETMOUSECLICKLOCK

	Spi_getmousevanish: INTEGER = 4128
			-- Declared in Windows as SPI_GETMOUSEVANISH

	Spi_setmousevanish: INTEGER = 4129
			-- Declared in Windows as SPI_SETMOUSEVANISH

	Spi_getflatmenu: INTEGER = 4130
			-- Declared in Windows as SPI_GETFLATMENU

	Spi_setflatmenu: INTEGER = 4131
			-- Declared in Windows as SPI_SETFLATMENU

	Spi_getdropshadow: INTEGER = 4132
			-- Declared in Windows as SPI_GETDROPSHADOW

	Spi_setdropshadow: INTEGER = 4133
			-- Declared in Windows as SPI_SETDROPSHADOW

	Spi_getmouseclicklocktime: INTEGER = 8200
			-- Declared in Windows as SPI_GETMOUSECLICKLOCKTIME

	Spi_setmouseclicklocktime: INTEGER = 8201
			-- Declared in Windows as SPI_SETMOUSECLICKLOCKTIME

	Spi_getfontsmoothingtype: INTEGER = 8202
			-- Declared in Windows as SPI_GETFONTSMOOTHINGTYPE

	Spi_setfontsmoothingtype: INTEGER = 8203
			-- Declared in Windows as SPI_SETFONTSMOOTHINGTYPE

	Spi_getfontsmoothingcontrast: INTEGER = 8204
			-- Declared in Windows as SPI_GETFONTSMOOTHINGCONTRAST

	Spi_setfontsmoothingcontrast: INTEGER = 8205
			-- Declared in Windows as SPI_SETFONTSMOOTHINGCONTRAST

	Spi_getfocusborderwidth: INTEGER = 8206
			-- Declared in Windows as SPI_GETFOCUSBORDERWIDTH

	Spi_setfocusborderwidth: INTEGER = 8207
			-- Declared in Windows as SPI_SETFOCUSBORDERWIDTH

	Spi_getfocusborderheight: INTEGER = 8208
			-- Declared in Windows as SPI_GETFOCUSBORDERHEIGHT

	Spi_setfocusborderheight: INTEGER = 8209
			-- Declared in Windows as SPI_SETFOCUSBORDERHEIGHT

feature -- SystemParameterInfo Flags (all Windows)

	Spif_updateinifile: INTEGER = 1
			-- Declared in Windows as SPIF_UPDATEINIFILE

	Spif_sendwininichange: INTEGER = 2
			-- Declared in Windows as SPIF_SENDWININICHANGE

	Spif_sendchange: INTEGER = 2;
			-- Declared in Windows as SPIF_SENDCHANGE

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SPI_CONSTANTS

