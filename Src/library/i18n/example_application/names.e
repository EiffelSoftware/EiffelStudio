indexing
	description: "Strings used in the interface"
	author		: "i18n-team (es-i18n@origo.ethz.ch)"
	date: "$Date$"
	revision: "$Revision$"

class
	NAMES
inherit
		I18N_TOOLS


feature -- Application

	application: STRING_32 is
			-- Example with the simplest translation functio
		do
			Result := locale.translate("Application")
		end

feature -- Menu Bar

	file: STRING_32 is
		do
			Result := locale.translate("File")
		end

	about: STRING_32 is
		do
			Result := locale.translate("About")
		end

		language : STRING_32 is
		do
			Result := locale.translate("Select language")
		end

	italian : STRING_32 is
		do
			Result := locale.translate("italian")
		end


	arabic : STRING_32 is
		do
			Result := locale.translate("arabic")
		end

	greek : STRING_32 is
		do
			Result := locale.translate("greek")
		end

	unknown : STRING_32 is
		do
			Result := locale.translate("Unknown")
		end

	japanese : STRING_32 is
		do
			Result := locale.translate("japanese")
		end

	russian : STRING_32 is
		do
			Result := locale.translate("russian")
		end

	chinese : STRING_32 is
		do
			Result := locale.translate("chinese")
		end

	english : STRING_32 is
		do
			Result := locale.translate("english")
		end

	french : STRING_32 is
		do
			Result := locale.translate("french")
		end

	hungarian: STRING_32 is
		do
			Result := locale.translate ("hungarian")
		end


feature -- Buttons


	buy: STRING_32 is
		do
			Result := locale.translate("Buy a hovercraft")
		end
	sell: STRING_32 is
		do
			Result := locale.translate("sell hovercraft")
		end

	update_date_time: STRING_32 is
		do
			Result := locale.translate ("Update date and time")
		end


feature -- Labels

	number_of_hovercraft (n: INTEGER): STRING_32 is
			-- Example with a plural form and a string formatter.
		do
			Result := locale.translate_plural ("My hovercraft is full of eels","My $1 hovercraft are full of eels",n)
			Result := locale.format_string (Result, [n])
		end

	explanation: STRING_32 is
		do
			create Result.make_from_string ("Locale name: "+locale.info.id.name+"%NInformations:%N")
			Result := locale.translate ("This string is written in the application's sourcecode")
		end


feature -- Time Information

	time: STRING_32 is
			-- Example where a time formatter is needed
		do
			Result := locale.translate ("Time: $1")
			Result := locale.format_string (Result, [locale.date_formatter.format_time (create {TIME}.make_now)])
		end

	date: STRING_32 is
			-- Example where a Date formatter is needed
		do
			Result := locale.translate ("Date: $1")
			Result := locale.format_string (Result, [locale.date_formatter.format_date (create {DATE}.make_now)])
		end

	date_time: STRING_32 is
			-- Example where a date-time formatter is needed
		do
			Result := locale.translate ("Full date-time: $1")
			Result := locale.format_string (Result, [locale.date_formatter.format_date_time (create {DATE_TIME}.make_now)])
		end

feature -- Currency/value formatter

	hovercraft_cost (n: REAL_32): STRING_32 is
			-- Example where a currency formatter is needed
		do
			Result := locale.translate ("A hovercraft costs you: $1")
			Result := locale.format_string (Result, [locale.currency_formatter.format_currency (n)])
		end

	hovercraft_sell_cost (n: REAL_32): STRING_32 is
		do
			Result := locale.translate ("You can sell a hovercraft for $1")
			Result := locale.format_string (Result, [locale.currency_formatter.format_currency (n)])
		end

	amount_of_money (n: REAL_32): STRING_32 is
		do
			Result := locale.translate ("Your have $1 on your bank conto")
			Result := locale.format_string (Result, [locale.currency_formatter.format_currency (n)])
		end

	mortage_rate (n: REAL_32): STRING_32 is
			-- Example where a value formatter is needed
		do
			Result := locale.translate ("The mortage rate is $1%%")
			Result := locale.format_string (Result, [locale.value_formatter.format_real_32 (n)])
		end


feature -- about dialog

	button_ok_item : STRING_32 is
		do
			Result := locale.translate("OK")
		end

	message : STRING_32 is
		do
			Result := locale.translate("Demo application made by i18n Team ETHZ%N%N%
										%For bugs, suggestions or other,%
										% please write a mail to: es-i18n@origo.ethz.ch%N%N")
		end

	team : STRING_32 is
		do
			Result := locale.translate("Members of the team:%N%
										%   - Leo Fellmann%N%
										%   - Etienne Reichenbach%N%
										%   - Bernd Schoeller%N%
										%   - Martino Trosi%N%
										%   - Hong Zhang")
		end


	default_title: STRING_32 is
			-- Default title for the dialog window.
		do
			Result := locale.translate("About Dialog")
		end

end
