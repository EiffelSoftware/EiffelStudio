indexing

	description:
		"Constants used by memory management. %
		%This class may be used as ancestor by classes needing its facilities.";

	copyright: "See notice at end of class";
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
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
