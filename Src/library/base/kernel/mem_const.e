indexing

	description:
		"Constants used by memory management. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	MEM_CONST

feature -- Access

	Total_memory: INTEGER is 0;
			-- Code for all the memory managed
			-- by the garbage collector

	Eiffel_memory: INTEGER is 1;
			-- Code for the Eiffel memory managed
			-- by the garbage collector

	C_memory: INTEGER is 2;
			-- Code for the C memory managed
			-- by the garbage collector

	Full_collector: INTEGER is 0;
			-- Statistics for full collections

	Incremental_collector: INTEGER is 1
			-- Statistics for incremental collections

end -- class MEM_CONST


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
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

