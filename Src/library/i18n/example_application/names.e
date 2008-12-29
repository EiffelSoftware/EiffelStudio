note
	description: "Strings used in the interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NAMES

inherit

	I18N_TOOLS

feature -- Application

	application: STRING_32
			-- Example with the simplest translation functio
		do
			Result := locale.translation ("Application")
		end

feature -- Menu Bar

	file: STRING_32
		do
			Result := locale.translation ("File")
		end

	about: STRING_32
		do
			Result := locale.translation ("About")
		end

		language : STRING_32
		do
			Result := locale.translation ("Select language")
		end

	italian : STRING_32
		do
			Result := locale.translation("italian")
		end

	arabic : STRING_32
		do
			Result := locale.translation ("arabic")
		end

	greek : STRING_32
		do
			Result := locale.translation ("greek")
		end

	unknown : STRING_32
		do
			Result := locale.translation ("Unknown")
		end

	japanese : STRING_32
		do
			Result := locale.translation ("japanese")
		end

	russian : STRING_32
		do
			Result := locale.translation ("russian")
		end

	chinese : STRING_32
		do
			Result := locale.translation ("chinese")
		end

	english : STRING_32
		do
			Result := locale.translation ("english")
		end

	french : STRING_32
		do
			Result := locale.translation ("french")
		end

	hungarian: STRING_32
		do
			Result := locale.translation ("hungarian")
		end

feature -- Buttons

	buy: STRING_32
		do
			Result := locale.translation ("Buy a hovercraft")
		end
	sell: STRING_32
		do
			Result := locale.translation ("sell hovercraft")
		end

	update_date_time: STRING_32
		do
			Result := locale.translation ("Update date and time")
		end

feature -- Labels

	number_of_hovercraft (n: INTEGER): STRING_32
			-- Example with a plural form and a string formatter.
		do
			Result := locale.plural_translation ("My hovercraft is full of eels","My $1 hovercraft are full of eels",n)
			Result := locale.formatted_string (Result, [n])
		end

	explanation: STRING_32
		do
			create Result.make_from_string ("Locale name: "+locale.info.id.name+"%NInformations:%N")
			Result := locale.translation ("This string is written in the application's sourcecode")
		end

feature -- Time Information

	time: STRING_32
			-- Example where a time formatter is needed
		do
			Result := locale.translation ("Time: $1")
			Result := locale.formatted_string (Result, [locale.date_formatter.format_time (create {TIME}.make_now)])
		end

	date: STRING_32
			-- Example where a Date formatter is needed
		do
			Result := locale.translation ("Date: $1")
			Result := locale.formatted_string (Result, [locale.date_formatter.format_date (create {DATE}.make_now)])
		end

	date_time: STRING_32
			-- Example where a date-time formatter is needed
		do
			Result := locale.translation ("Full date-time: $1")
			Result := locale.formatted_string (Result, [locale.date_formatter.format_date_time (create {DATE_TIME}.make_now)])
		end

feature -- Currency/value formatter

	hovercraft_cost (n: REAL_32): STRING_32
			-- Example where a currency formatter is needed
		do
			Result := locale.translation ("A hovercraft costs you: $1")
			Result := locale.formatted_string (Result, [locale.currency_formatter.format_currency (n)])
		end

	hovercraft_sell_cost (n: REAL_32): STRING_32
		do
			Result := locale.translation ("You can sell a hovercraft for $1")
			Result := locale.formatted_string (Result, [locale.currency_formatter.format_currency (n)])
		end

	amount_of_money (n: REAL_32): STRING_32
		do
			Result := locale.translation ("Your have $1 on your bank conto")
			Result := locale.formatted_string (Result, [locale.currency_formatter.format_currency (n)])
		end

	mortage_rate (n: REAL_32): STRING_32
			-- Example where a value formatter is needed
		do
			Result := locale.translation ("The mortage rate is $1%%")
			Result := locale.formatted_string (Result, [locale.value_formatter.format_real_32 (n)])
		end

feature -- about dialog

	button_ok_item : STRING_32
		do
			Result := locale.translation ("OK")
		end

	message : STRING_32
		do
			Result := locale.translation ("Demo application made by i18n Team ETHZ%N%N%
										%For bugs, suggestions or other,%
										% please write a mail to: es-i18n@origo.ethz.ch%N%N")
		end

	team : STRING_32
		do
			Result := locale.translation ("Members of the team:%N%
										%   - Leo Fellmann%N%
										%   - Etienne Reichenbach%N%
										%   - Bernd Schoeller%N%
										%   - Martino Trosi%N%
										%   - Hong Zhang")
		end

	default_title: STRING_32
			-- Default title for the dialog window.
		do
			Result := locale.translation ("About Dialog")
		end

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
