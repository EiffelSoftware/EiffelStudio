indexing
	description: "Date/Time Measurement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class DATE_TIME_MEASUREMENT inherit
	
	DATE_CONSTANTS
		
	TIME_CONSTANTS
		
feature -- Access

	date: DATE_MEASUREMENT is
		-- Date corresponding to current object
		deferred
		end

	time: TIME_MEASUREMENT is 
		-- Time corresponding to current object
		deferred
		end

	year: INTEGER is
			-- Year of the current object
		do
			Result := date.year
		ensure
			same_year: Result = date.year
		end

	month: INTEGER is
			-- Month of the current object
		do
			Result := date.month
		ensure
			same_month: Result = date.month
		end

	day: INTEGER is 
			-- Day of the current object 
		do 
			Result := date.day 
		ensure 
			same_day: Result = date.day
		end 
 
	hour: INTEGER is 
			-- Hour of the current object
		do
			Result := time.hour
		ensure
			same_hour: Result = time.hour
		end
			 
	minute: INTEGER is
			-- Minute of the current object 
		do
			Result := time.minute
		ensure
			same_minute: Result = time.minute
		end

	second: INTEGER is
			-- Second of the current object
		do
			Result := time.second
		ensure
			same_second: Result = time.second
		end

	fine_second: DOUBLE is 
			-- Representation of second with decimals
		do 
			Result := time.fine_second 
		ensure
			same_fine_second: Result = time.fine_second
		end
		
invariant

	date_exists: date /= Void
	time_exists: time /= Void

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




end -- class DATE_TIME_MEASUREMENT

