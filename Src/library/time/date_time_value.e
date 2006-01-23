indexing
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class DATE_TIME_VALUE inherit 

	DATE_TIME_MEASUREMENT
	
feature -- Access

	date: DATE_VALUE
			-- Date of the current object

	time: TIME_VALUE
			-- Time of the current object
			 
	fractional_second: DOUBLE is 
			-- Decimal part of second 
		do 
			Result := time.fractional_second
		ensure
			same_fractional: Result = time.fractional_second
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATE_TIME_VALUE



