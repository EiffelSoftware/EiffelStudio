note
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

deferred class
	DATE_TIME_VALUE

inherit
	DATE_TIME_MEASUREMENT

feature -- Access

	date: DATE_VALUE
			-- Date of the current object

	time: TIME_VALUE
			-- Time of the current object

	fractional_second: DOUBLE
			-- Decimal part of second
		do
			Result := time.fractional_second
		ensure
			same_fractional: Result = time.fractional_second
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATE_TIME_VALUE



