indexing
	description	: "SPI constants for SystemParametersInfo."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SPI_CONSTANTS

feature -- SystemParameter (All Windows)

	Spi_getsnaptodefbutton: INTEGER is 95
			-- Declared in Windows as SPI_GETSNAPTODEFBUTTON

	Spi_setsnaptodefbutton: INTEGER is 96
			-- Declared in Windows as SPI_SETSNAPTODEFBUTTON

	Spi_getserialkeys: INTEGER is 62
			-- Declared in Windows as SPI_GETSERIALKEYS

	Spi_setserialkeys: INTEGER is 63
			-- Declared in Windows as SPI_SETSERIALKEYS

	Spi_setdragfullwindows: INTEGER is 37
			-- Declared in Windows as SPI_SETDRAGFULLWINDOWS

	Spi_getdragfullwindows: INTEGER is 38
			-- Declared in Windows as SPI_GETDRAGFULLWINDOWS

	Spi_getnonclientmetrics: INTEGER is 41
			-- Declared in Windows as SPI_GETNONCLIENTMETRICS

	Spi_setnonclientmetrics: INTEGER is 42
			-- Declared in Windows as SPI_SETNONCLIENTMETRICS

	Spi_getminimizedmetrics: INTEGER is 43
			-- Declared in Windows as SPI_GETMINIMIZEDMETRICS

	Spi_setminimizedmetrics: INTEGER is 44
			-- Declared in Windows as SPI_SETMINIMIZEDMETRICS

	Spi_geticonmetrics: INTEGER is 45
			-- Declared in Windows as SPI_GETICONMETRICS

	Spi_seticonmetrics: INTEGER is 46
			-- Declared in Windows as SPI_SETICONMETRICS

	Spi_setworkarea: INTEGER is 47
			-- Declared in Windows as SPI_SETWORKAREA

	Spi_getworkarea: INTEGER is 48
			-- Declared in Windows as SPI_GETWORKAREA

	Spi_setpenwindows: INTEGER is 49
			-- Declared in Windows as SPI_SETPENWINDOWS

	Spi_gethighcontrast: INTEGER is 66
			-- Declared in Windows as SPI_GETHIGHCONTRAST

	Spi_sethighcontrast: INTEGER is 67
			-- Declared in Windows as SPI_SETHIGHCONTRAST

	Spi_getkeyboardpref: INTEGER is 68
			-- Declared in Windows as SPI_GETKEYBOARDPREF

	Spi_setkeyboardpref: INTEGER is 69
			-- Declared in Windows as SPI_SETKEYBOARDPREF

	Spi_getscreenreader: INTEGER is 70
			-- Declared in Windows as SPI_GETSCREENREADER

	Spi_setscreenreader: INTEGER is 71
			-- Declared in Windows as SPI_SETSCREENREADER

	Spi_getanimation: INTEGER is 72
			-- Declared in Windows as SPI_GETANIMATION

	Spi_setanimation: INTEGER is 73
			-- Declared in Windows as SPI_SETANIMATION

	Spi_getfontsmoothing: INTEGER is 74
			-- Declared in Windows as SPI_GETFONTSMOOTHING

	Spi_setfontsmoothing: INTEGER is 75
			-- Declared in Windows as SPI_SETFONTSMOOTHING

	Spi_setdragwidth: INTEGER is 76
			-- Declared in Windows as SPI_SETDRAGWIDTH

	Spi_setdragheight: INTEGER is 77
			-- Declared in Windows as SPI_SETDRAGHEIGHT

	Spi_sethandheld: INTEGER is 78
			-- Declared in Windows as SPI_SETHANDHELD

	Spi_getlowpowertimeout: INTEGER is 79
			-- Declared in Windows as SPI_GETLOWPOWERTIMEOUT

	Spi_getpowerofftimeout: INTEGER is 80
			-- Declared in Windows as SPI_GETPOWEROFFTIMEOUT

	Spi_setlowpowertimeout: INTEGER is 81
			-- Declared in Windows as SPI_SETLOWPOWERTIMEOUT

	Spi_setpowerofftimeout: INTEGER is 82
			-- Declared in Windows as SPI_SETPOWEROFFTIMEOUT

	Spi_getlowpoweractive: INTEGER is 83
			-- Declared in Windows as SPI_GETLOWPOWERACTIVE

	Spi_getpoweroffactive: INTEGER is 84
			-- Declared in Windows as SPI_GETPOWEROFFACTIVE

	Spi_setlowpoweractive: INTEGER is 85
			-- Declared in Windows as SPI_SETLOWPOWERACTIVE

	Spi_setpoweroffactive: INTEGER is 86
			-- Declared in Windows as SPI_SETPOWEROFFACTIVE

	Spi_setcursors: INTEGER is 87
			-- Declared in Windows as SPI_SETCURSORS

	Spi_seticons: INTEGER is 88
			-- Declared in Windows as SPI_SETICONS

	Spi_getdefaultinputlang: INTEGER is 89
			-- Declared in Windows as SPI_GETDEFAULTINPUTLANG

	Spi_setdefaultinputlang: INTEGER is 90
			-- Declared in Windows as SPI_SETDEFAULTINPUTLANG

	Spi_setlangtoggle: INTEGER is 91
			-- Declared in Windows as SPI_SETLANGTOGGLE

	Spi_getwindowsextension: INTEGER is 92
			-- Declared in Windows as SPI_GETWINDOWSEXTENSION

	Spi_setmousetrails: INTEGER is 93
			-- Declared in Windows as SPI_SETMOUSETRAILS

	Spi_getmousetrails: INTEGER is 94
			-- Declared in Windows as SPI_GETMOUSETRAILS

	Spi_setscreensaverrunning: INTEGER is 97
			-- Declared in Windows as SPI_SETSCREENSAVERRUNNING

	Spi_screensaverrunning: INTEGER is 97
			-- Declared in Windows as SPI_SCREENSAVERRUNNING

	Spi_getbeep: INTEGER is 1
			-- Declared in Windows as SPI_GETBEEP

	Spi_setbeep: INTEGER is 2
			-- Declared in Windows as SPI_SETBEEP

	Spi_getmouse: INTEGER is 3
			-- Declared in Windows as SPI_GETMOUSE

	Spi_setmouse: INTEGER is 4
			-- Declared in Windows as SPI_SETMOUSE

	Spi_getborder: INTEGER is 5
			-- Declared in Windows as SPI_GETBORDER

	Spi_setborder: INTEGER is 6
			-- Declared in Windows as SPI_SETBORDER

	Spi_getkeyboardspeed: INTEGER is 10
			-- Declared in Windows as SPI_GETKEYBOARDSPEED

	Spi_setkeyboardspeed: INTEGER is 11
			-- Declared in Windows as SPI_SETKEYBOARDSPEED

	Spi_langdriver: INTEGER is 12
			-- Declared in Windows as SPI_LANGDRIVER

	Spi_iconhorizontalspacing: INTEGER is 13
			-- Declared in Windows as SPI_ICONHORIZONTALSPACING

	Spi_getscreensavetimeout: INTEGER is 14
			-- Declared in Windows as SPI_GETSCREENSAVETIMEOUT

	Spi_setscreensavetimeout: INTEGER is 15
			-- Declared in Windows as SPI_SETSCREENSAVETIMEOUT

	Spi_getscreensaveactive: INTEGER is 16
			-- Declared in Windows as SPI_GETSCREENSAVEACTIVE

	Spi_setscreensaveactive: INTEGER is 17
			-- Declared in Windows as SPI_SETSCREENSAVEACTIVE

	Spi_getgridgranularity: INTEGER is 18
			-- Declared in Windows as SPI_GETGRIDGRANULARITY

	Spi_setgridgranularity: INTEGER is 19
			-- Declared in Windows as SPI_SETGRIDGRANULARITY

	Spi_setdeskwallpaper: INTEGER is 20
			-- Declared in Windows as SPI_SETDESKWALLPAPER

	Spi_setdeskpattern: INTEGER is 21
			-- Declared in Windows as SPI_SETDESKPATTERN

	Spi_getkeyboarddelay: INTEGER is 22
			-- Declared in Windows as SPI_GETKEYBOARDDELAY

	Spi_setkeyboarddelay: INTEGER is 23
			-- Declared in Windows as SPI_SETKEYBOARDDELAY

	Spi_iconverticalspacing: INTEGER is 24
			-- Declared in Windows as SPI_ICONVERTICALSPACING

	Spi_geticontitlewrap: INTEGER is 25
			-- Declared in Windows as SPI_GETICONTITLEWRAP

	Spi_seticontitlewrap: INTEGER is 26
			-- Declared in Windows as SPI_SETICONTITLEWRAP

	Spi_getmenudropalignment: INTEGER is 27
			-- Declared in Windows as SPI_GETMENUDROPALIGNMENT

	Spi_setmenudropalignment: INTEGER is 28
			-- Declared in Windows as SPI_SETMENUDROPALIGNMENT

	Spi_setdoubleclkwidth: INTEGER is 29
			-- Declared in Windows as SPI_SETDOUBLECLKWIDTH

	Spi_setdoubleclkheight: INTEGER is 30
			-- Declared in Windows as SPI_SETDOUBLECLKHEIGHT

	Spi_geticontitlelogfont: INTEGER is 31
			-- Declared in Windows as SPI_GETICONTITLELOGFONT

	Spi_setdoubleclicktime: INTEGER is 32
			-- Declared in Windows as SPI_SETDOUBLECLICKTIME

	Spi_setmousebuttonswap: INTEGER is 33
			-- Declared in Windows as SPI_SETMOUSEBUTTONSWAP

	Spi_seticontitlelogfont: INTEGER is 34
			-- Declared in Windows as SPI_SETICONTITLELOGFONT

	Spi_getfasttaskswitch: INTEGER is 35
			-- Declared in Windows as SPI_GETFASTTASKSWITCH

	Spi_setfasttaskswitch: INTEGER is 36
			-- Declared in Windows as SPI_SETFASTTASKSWITCH

	Spi_getfilterkeys: INTEGER is 50
			-- Declared in Windows as SPI_GETFILTERKEYS

	Spi_setfilterkeys: INTEGER is 51
			-- Declared in Windows as SPI_SETFILTERKEYS

	Spi_gettogglekeys: INTEGER is 52
			-- Declared in Windows as SPI_GETTOGGLEKEYS

	Spi_settogglekeys: INTEGER is 53
			-- Declared in Windows as SPI_SETTOGGLEKEYS

	Spi_getmousekeys: INTEGER is 54
			-- Declared in Windows as SPI_GETMOUSEKEYS

	Spi_setmousekeys: INTEGER is 55
			-- Declared in Windows as SPI_SETMOUSEKEYS

	Spi_getshowsounds: INTEGER is 56
			-- Declared in Windows as SPI_GETSHOWSOUNDS

	Spi_setshowsounds: INTEGER is 57
			-- Declared in Windows as SPI_SETSHOWSOUNDS

	Spi_getstickykeys: INTEGER is 58
			-- Declared in Windows as SPI_GETSTICKYKEYS

	Spi_setstickykeys: INTEGER is 59
			-- Declared in Windows as SPI_SETSTICKYKEYS

	Spi_getaccesstimeout: INTEGER is 60
			-- Declared in Windows as SPI_GETACCESSTIMEOUT

	Spi_setaccesstimeout: INTEGER is 61
			-- Declared in Windows as SPI_SETACCESSTIMEOUT

	Spi_getsoundsentry: INTEGER is 64
			-- Declared in Windows as SPI_GETSOUNDSENTRY

	Spi_setsoundsentry: INTEGER is 65
			-- Declared in Windows as SPI_SETSOUNDSENTRY

feature -- SystemParameter (Windows NT 4.0, Windows 98, Windows 2000 and above)

	Spi_getmousehoverwidth: INTEGER is 98
			-- Declared in Windows as SPI_GETMOUSEHOVERWIDTH

	Spi_setmousehoverwidth: INTEGER is 99
			-- Declared in Windows as SPI_SETMOUSEHOVERWIDTH

	Spi_getmousehoverheight: INTEGER is 100
			-- Declared in Windows as SPI_GETMOUSEHOVERHEIGHT

	Spi_setmousehoverheight: INTEGER is 101
			-- Declared in Windows as SPI_SETMOUSEHOVERHEIGHT

	Spi_getmousehovertime: INTEGER is 102
			-- Declared in Windows as SPI_GETMOUSEHOVERTIME

	Spi_setmousehovertime: INTEGER is 103
			-- Declared in Windows as SPI_SETMOUSEHOVERTIME

	Spi_getwheelscrolllines: INTEGER is 104
			-- Declared in Windows as SPI_GETWHEELSCROLLLINES

	Spi_setwheelscrolllines: INTEGER is 105
			-- Declared in Windows as SPI_SETWHEELSCROLLLINES

	Spi_getmenushowdelay: INTEGER is 106
			-- Declared in Windows as SPI_GETMENUSHOWDELAY

	Spi_setmenushowdelay: INTEGER is 107
			-- Declared in Windows as SPI_SETMENUSHOWDELAY

	Spi_getshowimeui: INTEGER is 110
			-- Declared in Windows as SPI_GETSHOWIMEUI

	Spi_setshowimeui: INTEGER is 111
			-- Declared in Windows as SPI_SETSHOWIMEUI

feature -- SystemParameter (Windows 98, Windows 2000 and above)

	Spi_getmousespeed: INTEGER is 112
			-- Declared in Windows as SPI_GETMOUSESPEED

	Spi_setmousespeed: INTEGER is 113
			-- Declared in Windows as SPI_SETMOUSESPEED

	Spi_getscreensaverrunning: INTEGER is 114
			-- Declared in Windows as SPI_GETSCREENSAVERRUNNING

	Spi_getdeskwallpaper: INTEGER is 115
			-- Declared in Windows as SPI_GETDESKWALLPAPER

	Spi_getactivewindowtracking: INTEGER is 4096
			-- Declared in Windows as SPI_GETACTIVEWINDOWTRACKING

	Spi_setactivewindowtracking: INTEGER is 4097
			-- Declared in Windows as SPI_SETACTIVEWINDOWTRACKING

	Spi_getmenuanimation: INTEGER is 4098
			-- Declared in Windows as SPI_GETMENUANIMATION

	Spi_setmenuanimation: INTEGER is 4099
			-- Declared in Windows as SPI_SETMENUANIMATION

	Spi_getcomboboxanimation: INTEGER is 4100
			-- Declared in Windows as SPI_GETCOMBOBOXANIMATION

	Spi_setcomboboxanimation: INTEGER is 4101
			-- Declared in Windows as SPI_SETCOMBOBOXANIMATION

	Spi_getlistboxsmoothscrolling: INTEGER is 4102
			-- Declared in Windows as SPI_GETLISTBOXSMOOTHSCROLLING

	Spi_setlistboxsmoothscrolling: INTEGER is 4103
			-- Declared in Windows as SPI_SETLISTBOXSMOOTHSCROLLING

	Spi_getgradientcaptions: INTEGER is 4104
			-- Declared in Windows as SPI_GETGRADIENTCAPTIONS

	Spi_setgradientcaptions: INTEGER is 4105
			-- Declared in Windows as SPI_SETGRADIENTCAPTIONS

	Spi_getkeyboardcues: INTEGER is 4106
			-- Declared in Windows as SPI_GETKEYBOARDCUES

	Spi_setkeyboardcues: INTEGER is 4107
			-- Declared in Windows as SPI_SETKEYBOARDCUES

	Spi_getmenuunderlines: INTEGER is 4106
			-- Declared in Windows as SPI_GETMENUUNDERLINES

	Spi_setmenuunderlines: INTEGER is 4107
			-- Declared in Windows as SPI_SETMENUUNDERLINES

	Spi_getactivewndtrkzorder: INTEGER is 4108
			-- Declared in Windows as SPI_GETACTIVEWNDTRKZORDER

	Spi_setactivewndtrkzorder: INTEGER is 4109
			-- Declared in Windows as SPI_SETACTIVEWNDTRKZORDER

	Spi_gethottracking: INTEGER is 4110
			-- Declared in Windows as SPI_GETHOTTRACKING

	Spi_sethottracking: INTEGER is 4111
			-- Declared in Windows as SPI_SETHOTTRACKING

	Spi_getmenufade: INTEGER is 4114
			-- Declared in Windows as SPI_GETMENUFADE

	Spi_setmenufade: INTEGER is 4115
			-- Declared in Windows as SPI_SETMENUFADE

	Spi_getselectionfade: INTEGER is 4116
			-- Declared in Windows as SPI_GETSELECTIONFADE

	Spi_setselectionfade: INTEGER is 4117
			-- Declared in Windows as SPI_SETSELECTIONFADE

	Spi_gettooltipanimation: INTEGER is 4118
			-- Declared in Windows as SPI_GETTOOLTIPANIMATION

	Spi_settooltipanimation: INTEGER is 4119
			-- Declared in Windows as SPI_SETTOOLTIPANIMATION

	Spi_gettooltipfade: INTEGER is 4120
			-- Declared in Windows as SPI_GETTOOLTIPFADE

	Spi_settooltipfade: INTEGER is 4121
			-- Declared in Windows as SPI_SETTOOLTIPFADE

	Spi_getcursorshadow: INTEGER is 4122
			-- Declared in Windows as SPI_GETCURSORSHADOW

	Spi_setcursorshadow: INTEGER is 4123
			-- Declared in Windows as SPI_SETCURSORSHADOW

	Spi_getuieffects: INTEGER is 4158
			-- Declared in Windows as SPI_GETUIEFFECTS

	Spi_setuieffects: INTEGER is 4159
			-- Declared in Windows as SPI_SETUIEFFECTS

	Spi_getforegroundlocktimeout: INTEGER is 8192
			-- Declared in Windows as SPI_GETFOREGROUNDLOCKTIMEOUT

	Spi_setforegroundlocktimeout: INTEGER is 8193
			-- Declared in Windows as SPI_SETFOREGROUNDLOCKTIMEOUT

	Spi_getactivewndtrktimeout: INTEGER is 8194
			-- Declared in Windows as SPI_GETACTIVEWNDTRKTIMEOUT

	Spi_setactivewndtrktimeout: INTEGER is 8195
			-- Declared in Windows as SPI_SETACTIVEWNDTRKTIMEOUT

	Spi_getforegroundflashcount: INTEGER is 8196
			-- Declared in Windows as SPI_GETFOREGROUNDFLASHCOUNT

	Spi_setforegroundflashcount: INTEGER is 8197
			-- Declared in Windows as SPI_SETFOREGROUNDFLASHCOUNT

	Spi_getcaretwidth: INTEGER is 8198
			-- Declared in Windows as SPI_GETCARETWIDTH

	Spi_setcaretwidth: INTEGER is 8199
			-- Declared in Windows as SPI_SETCARETWIDTH

feature -- SystemParameterInfo Flags (all Windows)

	Spif_updateinifile: INTEGER is 1
			-- Declared in Windows as SPIF_UPDATEINIFILE

	Spif_sendwininichange: INTEGER is 2
			-- Declared in Windows as SPIF_SENDWININICHANGE

	Spif_sendchange: INTEGER is 2
			-- Declared in Windows as SPIF_SENDCHANGE

end -- class WEL_SPI_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

