indexing 
	description: "duration of an interval of time" 
	status: "See notice at end of class"; 
	date: "$Date$" 
	revision: "$Revision$" 
	access: date, time 
 
deferred class

	DURATION

inherit
	PART_COMPARABLE

	GROUP_ELEMENT
		undefine
			is_equal
		end;

end -- class DURATION


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
