indexing
	description: "functions usefull in time calculations"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	TIME_UTILITY

feature -- Basic operations

	mod (i, j: INTEGER): INTEGER is
			-- (i \\ j) if `i' positive
			-- (i \\ j + j) if `i' negative
		do
			Result := i \\ j;
			if Result < 0 then
				Result := Result + j
			end
		ensure
			positive_result: Result >= 0;
			Result_definition: i = j * div (i, j) + Result
		end;

	div (i, j: INTEGER): INTEGER is
			-- (i \\ j) if `i' positive
			-- (i \\ j + 1) if `i' negative
		do
			Result := i // j;
			if Result > i / j then
				Result := Result - 1
			end
		ensure
			Result_definition: i = j * Result + mod (i,j)
		end;

end -- class TIME_UTILITY


--|---------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|---------------------------------------------------------------
