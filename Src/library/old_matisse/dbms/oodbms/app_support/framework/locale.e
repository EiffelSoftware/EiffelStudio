indexing
	description: "Model of Locale"
	keywords:    "internationalisation locale"
	revision:    "%%A%%"
	source:      "%%P%%"
	author:      "Thomas Beale"
	copyright:   "See notice at end of class"

class LOCALE

creation
	make

feature -- Initialisation
	make is
			-- FIXME: just fake it for the moment
		local
			start_date, finish_date:DATE
		do
			!!country_name_in_english.make(0) country_name_in_english.append("Australia")
			!!country_name_in_own_language.make(0) country_name_in_own_language.append("Australia")

			!!locale_name_in_english.make(0) locale_name_in_english.append("New South Wales")
			!!locale_name_in_own_language.make(0) locale_name_in_own_language.append("New South Wales")

			!!language.make(0) language.append("English")
			!!character_set.make(0) character_set.append("xxx")

			!!international_phone_code.make(0) international_phone_code.append("61")
			!!internet_country_code.make(0) internet_country_code.append("au")
			internet_country_code_required := True

			!!currency_symbol.make(0) currency_symbol.append("$")
			!!currency_name.make(0) currency_name.append("dollar")

			time_zone_offset := 10
			!!time_zone_name.make(0) time_zone_name.append("AEST")
			!!short_date_format.make(0) short_date_format.append("dd/mmm/yy")
			!!long_date_format.make(0) long_date_format.append("dddd, MMMM YYYY")
			!!time_format.make(0) time_format.append("HH:MM:SS")
			uses_24_hour_time := False
			summertime_adjustment := 1

		-- FIXME: re-synchronise with Eiffel Time library
		--	!!start_date.set_from_std_string("1/11/00")
		--	!!finish_date.set_from_std_string("31/3/00")
			!!summertime_period.make(start_date, finish_date)

			!!units_system.make(0) units_system.append("SI")
			!!thousands_separator.make(0) thousands_separator.append(",")
		end

feature -- Region
	country_name_in_english:STRING
		-- e.g.: "Australia", "Sweden"

	country_name_in_own_language:STRING
		-- e.g. "Australia", "Sverige"

	locale_name_in_english:STRING
		-- for parts of a country, esp. large provinces, states etc
		-- e.g. "Tuscany", "New South Wales", "Ontario"

	locale_name_in_own_language:STRING
		-- e.g. "Toscane"

feature -- Language
	language:STRING
		-- language, including variant, in form: "English/US", 
		-- "French/Canada" etc
		-- FIXME: should have a language class

	character_set:STRING
		-- name of character set required for language
		-- FIXME: what are the possibilities here?

feature -- Communication
	international_phone_code:STRING
		-- e.g. Australia is "61"

	internet_country_code:STRING
		-- e.g. Australia is "au", US is "us"

	internet_country_code_required:BOOLEAN
		-- e.g. False for US, True for the rest of us

feature -- Money
	currency_symbol:STRING

	currency_name:STRING

feature -- Time
	time_zone_offset:INTEGER
		-- relative to GMT, e.g. +10, -8 etc
		-- FIXME: should be a DURATION

	time_zone_name:STRING
		-- e.g. "GMT", "US Central", "AEST" etc

	short_date_format:STRING
		-- e.g. "dd/mm/yy", "dd-MMM-yy"
		-- FIXME: should be a date_format class, with parsing routines

	long_date_format:STRING
		-- e.g. "dddd, MMMM YYYY"
		-- FIXME: should be a date_format class, with parsing routines

	time_format:STRING
		-- e.g. "HH:MM:SS", "HHhMM"

	uses_24_hour_time:BOOLEAN
		-- True for most of Europe, False for most anglo, asian 
		-- countries. If False, "am" or "pm" are appended to times

	summertime_adjustment:INTEGER
		-- normally +1 if used

	summertime_period:RANGE[DATE]
		-- period of Summer time; Void if summertime_adjustment = 0

feature -- Measurement
	units_system:STRING
		-- e.g. "SI", "US Imperial" etc

	thousands_separator:STRING
		-- e.g. "," for most places

invariant
	Country_name_in_english_required: country_name_in_english /= Void and then not country_name_in_english.empty
	Country_name_in_own_language_required: country_name_in_own_language /= Void and then not country_name_in_own_language.empty

	Language_required:language /= Void and then not language.empty
	Character_set_required:character_set /= Void and then not character_set.empty

	Phone_code_required:international_phone_code /= Void and then international_phone_code.is_integer
	Internet_country_code_required: internet_country_code /= Void and then not internet_country_code.empty

	Currency_symbol_required:currency_symbol /= Void and then not currency_symbol.empty
	Currency_name_required:currency_name /= Void and then not currency_name.empty

	Time_zone_offset_valid:time_zone_offset > -12 and time_zone_offset < 12
	Time_zone_name_required: time_zone_name /= Void and then not time_zone_name.empty
	Long_date_format_required: long_date_format /= Void and then not long_date_format.empty
	Short_date_format_required: short_date_format /= Void and then not short_date_format.empty
	Time_format_required: time_format /= Void and then not time_format.empty
	Summertime_adjustment: summertime_adjustment /= 0 implies summertime_period /= Void

	Units_system_required: units_system /= Void and then not units_system.empty
	Thousands_separator_required: thousands_separator /= Void and then not thousands_separator.empty

end


--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

