indexing
	description: "value dealing with year, month and day"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	DATE_VALUE

inherit
	DATE_CONSTANTS
		redefine
			out
		end

creation

feature -- Access

	day: INTEGER;
			-- Day of the current object

	month: INTEGER;
			-- Month of the current object

	year: INTEGER;
			-- Year of the current object 

feature -- Conversion
		
	out : STRING is
		-- printable representation of `Current' 
		do
			Result := year.out;
			Result.extend('/');
			Result.append(month.out);
			Result.extend('/');
			Result.append(day.out);
		end;

end -- class DATE_VALUE


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
