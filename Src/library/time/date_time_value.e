indexing
	status: "See notice at end of class"
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

end -- class DATE_TIME_VALUE



--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

