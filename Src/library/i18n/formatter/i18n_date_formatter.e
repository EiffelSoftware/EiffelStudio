note
	description: "Class that allows formatting of a DATE, TIME, or DATE_TIME according to the information in a I18N_DATE_TIME_INFO"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_DATE_FORMATTER

create
	make

feature	-- Creation

	make (locale_info: I18N_LOCALE_INFO)
			-- Initialize with informations  in `locale_info'
		require
			locale_info_exists: locale_info /= Void
		do
			create long_date_format.make (locale_info.long_date_format, locale_info)
			create long_time_format.make (locale_info.long_time_format, locale_info)
			create date_time_format.make (locale_info.date_time_format, locale_info)
		end

feature	-- Access

	format_date (date: DATE): STRING_32
			-- formats an EiffelTime date according to the long date format
		require
			date_not_void: date /= Void
		do
			Result := long_date_format.filled (date, create {TIME}.make_now)
		end

	format_time (time: TIME): STRING_32
		-- formats an EiffelTime time according to the long time format
		require
			time_not_void: time /= Void
		do
			Result := long_time_format.filled (create {DATE}.make_now, time)
		end

	format_date_time (date_time: DATE_TIME): STRING_32
			--formats an EiffelTime time according to the date time format
		require
			date_time_not_void: date_time /= Void
		do
			Result := date_time_format.filled (date_time.date, date_time.time)
		end

feature {NONE} -- Implementation

	long_date_format: I18N_FORMAT_STRING
	long_time_format: I18N_FORMAT_STRING
	date_time_format: I18N_FORMAT_STRING

invariant
	long_date_format_exists: long_date_format /= Void
	long_time_format_exists: long_time_format /= Void
	date_time_format_exists: date_time_format /= Void

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
