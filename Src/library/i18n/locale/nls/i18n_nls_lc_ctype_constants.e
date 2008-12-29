note
	description: "Constants for NLS locale information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_LC_CTYPE_CONSTANTS

feature -- LC_CTYPE constants from winnnls.h

	-- Note: maximum lengths of strings can be found under
	-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/intl/nls_0m43.asp
	-- LC_CTYPE constants here do not have the maximum length specified if we don't use them
	-- (When things calm down I shall prune the list)

	LOCALE_ILANGUAGE: INTEGER =               0x00000001   -- language id
	LOCALE_SLANGUAGE: INTEGER =               0x00000002   -- localized name of language
	LOCALE_SENGLANGUAGE: INTEGER =            0x00001001   -- English name of language
	LOCALE_SABBREVLANGNAME: INTEGER =         0x00000003   -- abbreviated language name
	LOCALE_SNATIVELANGNAME: INTEGER =         0x00000004   -- native name of language

	LOCALE_ICOUNTRY: INTEGER =                0x00000005   -- country code
	LOCALE_SCOUNTRY: INTEGER =                0x00000006   -- localized name of country
	LOCALE_SENGCOUNTRY: INTEGER =             0x00001002   -- English name of country
	LOCALE_SABBREVCTRYNAME: INTEGER =         0x00000007   -- abbreviated country name
	LOCALE_SNATIVECTRYNAME: INTEGER =         0x00000008   -- native name of country

	LOCALE_IDEFAULTLANGUAGE: INTEGER =        0x00000009   -- default language id
	LOCALE_IDEFAULTCOUNTRY: INTEGER =         0x0000000A   -- default country code
	LOCALE_IDEFAULTCODEPAGE: INTEGER =        0x0000000B   -- default oem code page
	locale_idefaultcodepage_maxlen: INTEGER = 6
	LOCALE_IDEFAULTANSICODEPAGE: INTEGER =    0x00001004   -- default ansi code page
	locale_idefaultansicodepage_maxlen: INTEGER = 6
	LOCALE_IDEFAULTMACCODEPAGE: INTEGER =     0x00001011   -- default mac code page
	locale_idefaultmaccodepage_maxlen: INTEGER = 6

	LOCALE_SLIST: INTEGER =                   0x0000000C   -- list item separator
	locale_slist_maxlen:INTEGER = 4

	LOCALE_IMEASURE: INTEGER =                0x0000000D   -- 0 = metric, 1 = US

	LOCALE_SDECIMAL: INTEGER =                0x0000000E   -- decimal separator
	locale_sdecimal_maxlen: INTEGER = 4
	LOCALE_STHOUSAND: INTEGER =               0x0000000F   -- thousand separator
	locale_sthousand_maxlen: INTEGER = 4
	LOCALE_SGROUPING : INTEGER =              0x00000010   -- digit grouping
	locale_sgrouping_maxlen: INTEGER = 10
	LOCALE_IDIGITS: INTEGER =                0x00000011   -- number of fractional digits
	locale_idigits_maxlen: INTEGER = 2 -- not needed really, this can be retrieved as an integer
	LOCALE_ILZERO: INTEGER =                  0x00000012   -- leading zeros for decimal
	LOCALE_INEGNUMBER: INTEGER =              0x00001010   -- negative number mode
	LOCALE_SNATIVEDIGITS: INTEGER =           0x00000013   -- native ascii 0-9

	LOCALE_SCURRENCY: INTEGER =               0x00000014   -- local monetary symbol
	locale_scurrency_maxlen: INTEGER = 4
	LOCALE_SINTLSYMBOL: INTEGER =             0x00000015   -- intl monetary symbol
	locale_sintlsymbol_maxlen: INTEGER = 9
	LOCALE_SMONDECIMALSEP: INTEGER =          0x00000016   -- monetary decimal separator
	locale_smondecimalsep_maxlen: INTEGER = 4
	LOCALE_SMONTHOUSANDSEP: INTEGER =        0x00000017   -- monetary thousand separator
	locale_smonthousandsep_maxlen: INTEGER = 4
	LOCALE_SMONGROUPING: INTEGER =           0x00000018   -- monetary grouping
	locale_smongroupinglen:INTEGER = 10
	LOCALE_ICURRDIGITS: INTEGER =            0x00000019   -- # local monetary digits
	LOCALE_IINTLCURRDIGITS: INTEGER =        0x0000001A   -- # intl monetary digits
	LOCALE_ICURRENCY: INTEGER =              0x0000001B   -- positive currency mode
	LOCALE_INEGCURR: INTEGER =               0x0000001C   -- negative currency mode

	LOCALE_SDATE: INTEGER =                  0x0000001D   -- date separator
	LOCALE_STIME: INTEGER =                  0x0000001E   -- time separator

	LOCALE_SSHORTDATE: INTEGER =             0x0000001F   -- short date format string
	locale_sshortdate_maxlen: INTEGER = 80
	LOCALE_SLONGDATE: INTEGER =              0x00000020   -- long date format string
	locale_slongdate_maxlen: INTEGER = 80

	LOCALE_STIMEFORMAT: INTEGER =            0x00001003   -- time format string
	locale_stimeformat_maxlen: INTEGER = 80
	LOCALE_IDATE: INTEGER =                  0x00000021   -- short date format ordering
	LOCALE_ILDATE : INTEGER =                0x00000022   -- long date format ordering
	LOCALE_ITIME: INTEGER =                  0x00000023   -- time format specifier
	LOCALE_ITIMEMARKPOSN: INTEGER =          0x00001005   -- time marker position
	LOCALE_ICENTURY: INTEGER =               0x00000024   -- century format specifier (short date)
	LOCALE_ITLZERO: INTEGER =                0x00000025   -- leading zeros in time field
	LOCALE_IDAYLZERO: INTEGER =              0x00000026   -- leading zeros in day field (short date)
	LOCALE_IMONLZERO: INTEGER =              0x00000027   -- leading zeros in month field (short date)

	LOCALE_S1159: INTEGER =                  0x00000028   -- AM designator
	locale_s1159_maxlen:INTEGER = 15
	LOCALE_S2359: INTEGER =                  0x00000029   -- PM designator
	locale_s2359_maxlen:INTEGER = 15

	LOCALE_ICALENDARTYPE: INTEGER =          0x00001009   -- type of calendar specifier
	LOCALE_IOPTIONALCALENDAR: INTEGER =      0x0000100B   -- additional calendar types specifier
	LOCALE_IFIRSTDAYOFWEEK: INTEGER =        0x0000100C   -- first day of week specifier
	LOCALE_IFIRSTWEEKOFYEAR: INTEGER =       0x0000100D   -- first week of year specifier

	LOCALE_SDAYNAME1: INTEGER =              0x0000002A   -- long name for Monday
	LOCALE_SDAYNAME2: INTEGER =              0x0000002B   -- long name for Tuesday
	LOCALE_SDAYNAME3: INTEGER =              0x0000002C   -- long name for Wednesday
	LOCALE_SDAYNAME4: INTEGER =              0x0000002D   -- long name for Thursday
	LOCALE_SDAYNAME5: INTEGER =             0x0000002E   -- long name for Friday
	LOCALE_SDAYNAME6: INTEGER =              0x0000002F   -- long name for Saturday
	LOCALE_SDAYNAME7: INTEGER =              0x00000030   -- long name for Sunday
	locale_sdayname_maxlen: INTEGER = 80


	LOCALE_SABBREVDAYNAME1: INTEGER =        0x00000031   -- abbreviated name for Monday
	LOCALE_SABBREVDAYNAME2: INTEGER =        0x00000032   -- abbreviated name for Tuesday
	LOCALE_SABBREVDAYNAME3: INTEGER =        0x00000033   -- abbreviated name for Wednesday
	LOCALE_SABBREVDAYNAME4: INTEGER =        0x00000034   -- abbreviated name for Thursday
	LOCALE_SABBREVDAYNAME5: INTEGER =        0x00000035   -- abbreviated name for Friday
	LOCALE_SABBREVDAYNAME6: INTEGER =        0x00000036   -- abbreviated name for Saturday
	LOCALE_SABBREVDAYNAME7: INTEGER =        0x00000037   -- abbreviated name for Sunday
	locale_sabbrevdayname_maxlen: INTEGER = 80

	LOCALE_SMONTHNAME1: INTEGER =            0x00000038   -- long name for January
	LOCALE_SMONTHNAME2: INTEGER =            0x00000039   -- long name for February
	LOCALE_SMONTHNAME3: INTEGER =            0x0000003A   -- long name for March
	LOCALE_SMONTHNAME4: INTEGER =            0x0000003B   -- long name for April
	LOCALE_SMONTHNAME5: INTEGER =            0x0000003C   -- long name for May
	LOCALE_SMONTHNAME6: INTEGER =            0x0000003D   -- long name for June
	LOCALE_SMONTHNAME7: INTEGER =            0x0000003E   -- long name for July
	LOCALE_SMONTHNAME8: INTEGER =            0x0000003F   -- long name for August
	LOCALE_SMONTHNAME9: INTEGER =           0x00000040   -- long name for September
	LOCALE_SMONTHNAME10: INTEGER =           0x00000041   -- long name for October
	LOCALE_SMONTHNAME11: INTEGER =          0x00000042   -- long name for November
	LOCALE_SMONTHNAME12: INTEGER =           0x00000043   -- long name for December
	LOCALE_SMONTHNAME13: INTEGER =           0x0000100E   -- long name for 13th month (if exists)
	locale_smonthname_maxlen: INTEGER = 80

	LOCALE_SABBREVMONTHNAME1: INTEGER =      0x00000044   -- abbreviated name for January
	LOCALE_SABBREVMONTHNAME2: INTEGER =      0x00000045   -- abbreviated name for February
	LOCALE_SABBREVMONTHNAME3: INTEGER =      0x00000046   -- abbreviated name for March
	LOCALE_SABBREVMONTHNAME4: INTEGER =      0x00000047   -- abbreviated name for April
	LOCALE_SABBREVMONTHNAME5: INTEGER =      0x00000048   -- abbreviated name for May
	LOCALE_SABBREVMONTHNAME6: INTEGER =      0x00000049   -- abbreviated name for June
	LOCALE_SABBREVMONTHNAME7: INTEGER =      0x0000004A   -- abbreviated name for July
	LOCALE_SABBREVMONTHNAME8: INTEGER =      0x0000004B   -- abbreviated name for August
	LOCALE_SABBREVMONTHNAME9: INTEGER =      0x0000004C   -- abbreviated name for September
	LOCALE_SABBREVMONTHNAME10: INTEGER =     0x0000004D   -- abbreviated name for October
	LOCALE_SABBREVMONTHNAME11: INTEGER =     0x0000004E   -- abbreviated name for November
	LOCALE_SABBREVMONTHNAME12: INTEGER =     0x0000004F   -- abbreviated name for December
	LOCALE_SABBREVMONTHNAME13: INTEGER =     0x0000100F   -- abbreviated name for 13th month (if exists)
	locale_sabbrevmonthname_maxlen: INTEGER = 80

	LOCALE_SPOSITIVESIGN: INTEGER =          0x00000050   -- positive sign
	locale_spositivesign_maxlen: INTEGER = 5
	LOCALE_SNEGATIVESIGN: INTEGER =          0x00000051   -- negative sign
	locale_snegativesign_maxlen: INTEGER = 5
	LOCALE_IPOSSIGNPOSN: INTEGER =           0x00000052   -- positive sign position
	LOCALE_INEGSIGNPOSN: INTEGER =           0x00000053   -- negative sign position
	LOCALE_IPOSSYMPRECEDES: INTEGER =        0x00000054   -- mon sym precedes pos amt
	LOCALE_IPOSSEPBYSPACE: INTEGER =         0x00000055   -- mon sym sep by space from pos amt
	LOCALE_INEGSYMPRECEDES: INTEGER =        0x00000056   -- mon sym precedes neg amt
	LOCALE_INEGSEPBYSPACE: INTEGER =         0x00000057   -- mon sym sep by space from neg amt

	LOCALE_SISO639LANGNAME: INTEGER =        0x00000059   -- ISO abbreviated language name
	locale_siso639langname_maxlen: INTEGER = 9
	LOCALE_SISO3166CTRYNAME: INTEGER =       0x0000005A   -- ISO abbreviated country name
	locale_siso3166ctryname_maxlen: INTEGER = 9;

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
