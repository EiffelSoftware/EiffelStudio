note

	description:

		"Date values consistent with XPath 2.0"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2007-2013, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ST_XPATH_DATE_VALUE

inherit

	ST_XPATH_CALENDAR_VALUE
		redefine
			is_xpath_date,
			as_xpath_date
		end

create

	make,
	make_from_date,
	make_from_zoned_date

feature {NONE} -- Initialization

	make (a_lexical_date: STRING)
			-- Create from lexical date.
		require
			lexical_date: a_lexical_date /= Void and then is_date (a_lexical_date)
		local
			l_date_time_parser: ST_XSD_DATE_TIME_PARSER
		do
			create l_date_time_parser.make_1_1
			if l_date_time_parser.is_zoned_date (a_lexical_date) then
				zoned := True
				zoned_date := l_date_time_parser.string_to_zoned_date (a_lexical_date)
			else
				local_date := l_date_time_parser.string_to_date (a_lexical_date)
			end
		end

	make_from_date (a_date: DT_DATE)
			-- Create from date object.
		require
			date_not_void: a_date /= Void
		do
			local_date := a_date.twin
		end

	make_from_zoned_date (a_date: DT_FIXED_OFFSET_ZONED_DATE)
			-- Create from date object.
		require
			date_not_void: a_date /= Void
		do
			zoned_date := a_date.twin
			zoned := True
		end

feature -- Access

	zoned_date: detachable DT_FIXED_OFFSET_ZONED_DATE
			-- Zoned date value

	local_date: detachable DT_DATE
			-- Date value without zone

	date: DT_DATE
			-- Date component
		local
			l_date: detachable DT_DATE
			l_zoned_date: like zoned_date
		do
			if zoned then
				l_zoned_date := zoned_date
				check
						-- condition `zoned'
					zoned: l_zoned_date /= Void
				then
					l_date := l_zoned_date.date
					Result := l_date
				end
			else
				l_date := local_date
				check
						-- condition `not zoned'
					not_zoned: l_date /= Void
				then
					Result := l_date
				end
			end
		end

feature -- Status report

	is_xpath_date: BOOLEAN
			-- Does `Current' have a date component and no time component?
		do
			Result := True
		end

	is_date (a_lexical_date: STRING): BOOLEAN
			-- Is `a_lexical_date' a valid date?
		require
			lexical_date_not_void: a_lexical_date /= Void
		local
			l_date_time_parser: ST_XSD_DATE_TIME_PARSER
		do
			create l_date_time_parser.make_1_1
			Result := l_date_time_parser.is_zoned_date (a_lexical_date) or l_date_time_parser.is_date (a_lexical_date)
		end

feature -- Conversion

	as_xpath_date: ST_XPATH_DATE_VALUE
			-- `Current' seen as a date value
		do
			Result := Current
		end

end

