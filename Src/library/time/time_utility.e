indexing
	description: "Functions useful in time calculations"
	status: "See notice at end of class"
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

end -- class TIME_UTILITY


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


