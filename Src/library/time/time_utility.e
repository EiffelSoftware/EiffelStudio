indexing
	description: "Functions useful in time calculations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TIME_UTILITY

feature -- Basic operations

	mod (i, j: INTEGER): INTEGER is
			-- (i \\ j) if `i' positive
			-- (i \\ j + j) if `i' negative
		do
			Result := i \\ j
			if Result < 0 then
				Result := Result + j
			end
		ensure
			positive_result: Result >= 0
			Result_definition: i = j * div (i, j) + Result
		end
	
	div (i, j: INTEGER): INTEGER is
			-- (i \\ j) if `i' positive
			-- (i \\ j + 1) if `i' negative
		do
			Result := i // j
			if Result > i / j then
				Result := Result - 1
			end
		ensure
			Result_definition: i = j * Result + mod (i, j)
		end

feature -- Access

	date_time_tools: DATE_TIME_TOOLS is
			-- Tools for outputting dates and times in different formats
		once
			create Result
		end


	default_format_string: STRING is
			-- Default output format string
		do
			Result := date_time_tools.default_format_string
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




end -- class TIME_UTILITY



