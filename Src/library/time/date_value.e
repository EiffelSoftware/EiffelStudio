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
		-- printable representation of `Current' with "standard"
		-- Form: "dd/mm/yyyy"
		do
			Result := day.out;
			if day < 10 then 
				Result.prepend("0")
			end
			Result.extend('/');
			if month < 10 then
				Result.append("0")
			end
			Result.append(month.out);
			Result.extend('/');
			if year < 10 then
				Result.append("000")
			elseif year < 100 then
				Result.append("00")
			elseif year < 1000 then
				Result.append("0")
			end		
			Result.append(year.out);

		end;

end -- class DATE_VALUE


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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


