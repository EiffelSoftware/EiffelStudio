note
	description: "Constants for NLS locale information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_LC_CTYPE_CONSTANTS

feature -- LC_CTYPE constants (see winnnls.h as reference)

	-- Note: Constants information can be found under
	-- http://msdn.microsoft.com/en-us/library/dd319079(VS.85).aspx

	LOCALE_ILANGUAGE: INTEGER
			-- language id
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ILANGUAGE;"
		end

	LOCALE_SLANGUAGE: INTEGER
			-- localized name of language
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SLANGUAGE;"
		end

	LOCALE_SENGLANGUAGE: INTEGER
			-- English name of language
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SENGLANGUAGE;"
		end

	LOCALE_SABBREVLANGNAME: INTEGER
			-- abbreviated language name
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVLANGNAME;"
		end

	LOCALE_SNATIVELANGNAME: INTEGER
			-- native name of language
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SNATIVELANGNAME;"
		end

	LOCALE_ICOUNTRY: INTEGER
			-- country code
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ICOUNTRY;"
		end

	LOCALE_SCOUNTRY: INTEGER
			-- localized name of country
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SCOUNTRY;"
		end

	LOCALE_SENGCOUNTRY: INTEGER
			-- English name of country
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SENGCOUNTRY;"
		end

	LOCALE_SABBREVCTRYNAME: INTEGER
			-- abbreviated country name
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVCTRYNAME;"
		end

	LOCALE_SNATIVECTRYNAME: INTEGER
			-- native name of country
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SNATIVECTRYNAME;"
		end

	LOCALE_IDEFAULTLANGUAGE: INTEGER
			-- default language id
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDEFAULTLANGUAGE;"
		end

	LOCALE_IDEFAULTCOUNTRY: INTEGER
			-- default country code
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDEFAULTCOUNTRY;"
		end

	LOCALE_IDEFAULTCODEPAGE: INTEGER
			-- default oem code page
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDEFAULTCODEPAGE;"
		end

	LOCALE_IDEFAULTANSICODEPAGE: INTEGER
			-- default ansi code page
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDEFAULTANSICODEPAGE;"
		end

	LOCALE_IDEFAULTMACCODEPAGE: INTEGER
			-- default mac code page
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDEFAULTMACCODEPAGE;"
		end

	LOCALE_SLIST: INTEGER
			-- list item separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SLIST;"
		end

	LOCALE_IMEASURE: INTEGER
			-- 0 = metric, 1 = US
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IMEASURE;"
		end

	LOCALE_SDECIMAL: INTEGER
			-- decimal separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDECIMAL;"
		end

	LOCALE_STHOUSAND: INTEGER
			-- thousand separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_STHOUSAND;"
		end

	LOCALE_SGROUPING : INTEGER
			-- digit grouping
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SGROUPING ;"
		end

	LOCALE_IDIGITS: INTEGER
			-- number of fractional digits
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDIGITS;"
		end

	LOCALE_ILZERO: INTEGER
			-- leading zeros for decimal
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ILZERO;"
		end

	LOCALE_INEGNUMBER: INTEGER
			-- negative number mode
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_INEGNUMBER;"
		end

	LOCALE_SNATIVEDIGITS: INTEGER
			-- native ascii 0-9
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SNATIVEDIGITS;"
		end

	LOCALE_SCURRENCY: INTEGER
			-- local monetary symbol
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SCURRENCY;"
		end

	LOCALE_SINTLSYMBOL: INTEGER
			-- intl monetary symbol
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SINTLSYMBOL;"
		end

	LOCALE_SMONDECIMALSEP: INTEGER
			-- monetary decimal separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONDECIMALSEP;"
		end

	LOCALE_SMONTHOUSANDSEP: INTEGER
			-- monetary thousand separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHOUSANDSEP;"
		end

	LOCALE_SMONGROUPING: INTEGER
			-- monetary grouping
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONGROUPING;"
		end

	LOCALE_ICURRDIGITS: INTEGER
			-- # local monetary digits
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ICURRDIGITS;"
		end

	LOCALE_IINTLCURRDIGITS: INTEGER
			-- # intl monetary digits
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IINTLCURRDIGITS;"
		end

	LOCALE_ICURRENCY: INTEGER
			-- positive currency mode
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ICURRENCY;"
		end

	LOCALE_INEGCURR: INTEGER
			-- negative currency mode
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_INEGCURR;"
		end

	LOCALE_SDATE: INTEGER
			-- date separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDATE;"
		end

	LOCALE_STIME: INTEGER
			-- time separator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_STIME;"
		end

	LOCALE_SSHORTDATE: INTEGER
			-- short date format string
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SSHORTDATE;"
		end

	LOCALE_SLONGDATE: INTEGER
			-- long date format string
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SLONGDATE;"
		end

	LOCALE_STIMEFORMAT: INTEGER
			-- time format string
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_STIMEFORMAT;"
		end

	LOCALE_IDATE: INTEGER
			-- short date format ordering
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDATE;"
		end

	LOCALE_ILDATE : INTEGER
			-- long date format ordering
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ILDATE ;"
		end

	LOCALE_ITIME: INTEGER
			-- time format specifier
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ITIME;"
		end

	LOCALE_ITIMEMARKPOSN: INTEGER
			-- time marker position
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ITIMEMARKPOSN;"
		end

	LOCALE_ICENTURY: INTEGER
			-- century format specifier (short date)
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ICENTURY;"
		end

	LOCALE_ITLZERO: INTEGER
			-- leading zeros in time field
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ITLZERO;"
		end

	LOCALE_IDAYLZERO: INTEGER
			-- leading zeros in day field (short date)
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IDAYLZERO;"
		end

	LOCALE_IMONLZERO: INTEGER
			-- leading zeros in month field (short date)
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IMONLZERO;"
		end

	LOCALE_S1159: INTEGER
			-- AM designator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_S1159;"
		end

	LOCALE_S2359: INTEGER
			-- PM designator
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_S2359;"
		end

	LOCALE_ICALENDARTYPE: INTEGER
			-- type of calendar specifier
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_ICALENDARTYPE;"
		end

	LOCALE_IOPTIONALCALENDAR: INTEGER
			-- additional calendar types specifier
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IOPTIONALCALENDAR;"
		end

	LOCALE_IFIRSTDAYOFWEEK: INTEGER
			-- first day of week specifier
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IFIRSTDAYOFWEEK;"
		end

	LOCALE_IFIRSTWEEKOFYEAR: INTEGER
			-- first week of year specifier
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IFIRSTWEEKOFYEAR;"
		end

	LOCALE_SDAYNAME1: INTEGER
			-- long name for Monday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME1;"
		end

	LOCALE_SDAYNAME2: INTEGER
			-- long name for Tuesday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME2;"
		end

	LOCALE_SDAYNAME3: INTEGER
			-- long name for Wednesday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME3;"
		end

	LOCALE_SDAYNAME4: INTEGER
			-- long name for Thursday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME4;"
		end

	LOCALE_SDAYNAME5: INTEGER
			-- long name for Friday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME5;"
		end

	LOCALE_SDAYNAME6: INTEGER
			-- long name for Saturday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME6;"
		end

	LOCALE_SDAYNAME7: INTEGER
			-- long name for Sunday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SDAYNAME7;"
		end

	LOCALE_SABBREVDAYNAME1: INTEGER
			-- abbreviated name for Monday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME1;"
		end

	LOCALE_SABBREVDAYNAME2: INTEGER
			-- abbreviated name for Tuesday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME2;"
		end

	LOCALE_SABBREVDAYNAME3: INTEGER
			-- abbreviated name for Wednesday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME3;"
		end

	LOCALE_SABBREVDAYNAME4: INTEGER
			-- abbreviated name for Thursday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME4;"
		end

	LOCALE_SABBREVDAYNAME5: INTEGER
			-- abbreviated name for Friday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME5;"
		end

	LOCALE_SABBREVDAYNAME6: INTEGER
			-- abbreviated name for Saturday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME6;"
		end

	LOCALE_SABBREVDAYNAME7: INTEGER
			-- abbreviated name for Sunday
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVDAYNAME7;"
		end

	LOCALE_SMONTHNAME1: INTEGER
			-- long name for January
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME1;"
		end

	LOCALE_SMONTHNAME2: INTEGER
			-- long name for February
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME2;"
		end

	LOCALE_SMONTHNAME3: INTEGER
			-- long name for March
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME3;"
		end

	LOCALE_SMONTHNAME4: INTEGER
			-- long name for April
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME4;"
		end

	LOCALE_SMONTHNAME5: INTEGER
			-- long name for May
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME5;"
		end

	LOCALE_SMONTHNAME6: INTEGER
			-- long name for June
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME6;"
		end

	LOCALE_SMONTHNAME7: INTEGER
			-- long name for July
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME7;"
		end

	LOCALE_SMONTHNAME8: INTEGER
			-- long name for August
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME8;"
		end

	LOCALE_SMONTHNAME9: INTEGER
			-- long name for September
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME9;"
		end

	LOCALE_SMONTHNAME10: INTEGER
			-- long name for October
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME10;"
		end

	LOCALE_SMONTHNAME11: INTEGER
			-- long name for November
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME11;"
		end

	LOCALE_SMONTHNAME12: INTEGER
			-- long name for December
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME12;"
		end

	LOCALE_SMONTHNAME13: INTEGER
			-- long name for 13th month (if exists)
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SMONTHNAME13;"
		end

	LOCALE_SABBREVMONTHNAME1: INTEGER
			-- abbreviated name for January
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME1;"
		end

	LOCALE_SABBREVMONTHNAME2: INTEGER
			-- abbreviated name for February
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME2;"
		end

	LOCALE_SABBREVMONTHNAME3: INTEGER
			-- abbreviated name for March
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME3;"
		end

	LOCALE_SABBREVMONTHNAME4: INTEGER
			-- abbreviated name for April
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME4;"
		end

	LOCALE_SABBREVMONTHNAME5: INTEGER
			-- abbreviated name for May
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME5;"
		end

	LOCALE_SABBREVMONTHNAME6: INTEGER
			-- abbreviated name for June
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME6;"
		end

	LOCALE_SABBREVMONTHNAME7: INTEGER
			-- abbreviated name for July
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME7;"
		end

	LOCALE_SABBREVMONTHNAME8: INTEGER
			-- abbreviated name for August
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME8;"
		end

	LOCALE_SABBREVMONTHNAME9: INTEGER
			-- abbreviated name for September
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME9;"
		end

	LOCALE_SABBREVMONTHNAME10: INTEGER
			-- abbreviated name for October
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME10;"
		end

	LOCALE_SABBREVMONTHNAME11: INTEGER
			-- abbreviated name for November
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME11;"
		end

	LOCALE_SABBREVMONTHNAME12: INTEGER
			-- abbreviated name for December
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME12;"
		end

	LOCALE_SABBREVMONTHNAME13: INTEGER
			-- abbreviated name for 13th month (if exists)
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SABBREVMONTHNAME13;"
		end

	LOCALE_SPOSITIVESIGN: INTEGER
			-- positive sign
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SPOSITIVESIGN;"
		end

	LOCALE_SNEGATIVESIGN: INTEGER
			-- negative sign
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SNEGATIVESIGN;"
		end

	LOCALE_IPOSSIGNPOSN: INTEGER
			-- positive sign position
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IPOSSIGNPOSN;"
		end

	LOCALE_INEGSIGNPOSN: INTEGER
			-- negative sign position
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_INEGSIGNPOSN;"
		end

	LOCALE_IPOSSYMPRECEDES: INTEGER
			-- mon sym precedes pos amt
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IPOSSYMPRECEDES;"
		end

	LOCALE_IPOSSEPBYSPACE: INTEGER
			-- mon sym sep by space from pos amt
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_IPOSSEPBYSPACE;"
		end

	LOCALE_INEGSYMPRECEDES: INTEGER
			-- mon sym precedes neg amt
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_INEGSYMPRECEDES;"
		end

	LOCALE_INEGSEPBYSPACE: INTEGER
			-- mon sym sep by space from neg amt
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_INEGSEPBYSPACE;"
		end

	LOCALE_SISO639LANGNAME: INTEGER
			-- ISO abbreviated language name
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SISO639LANGNAME;"
		end

	LOCALE_SISO3166CTRYNAME: INTEGER
			-- ISO abbreviated country name
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_SISO3166CTRYNAME;"
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
