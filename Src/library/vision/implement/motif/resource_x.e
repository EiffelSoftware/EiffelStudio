
-- RESOURCE_X: A resource X.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE_X 

inherit

	MEMORY
		undefine
			dispose
		end

feature 

	make (a_screen: SCREEN_I; an_identifier: POINTER; is_allocated_r: BOOLEAN) is
			-- Create a resource on `a_screen'
			-- with `an_identifier' as X identifier
		do
			screen := a_screen;
			identifier := an_identifier;
			is_allocated := is_allocated_r
		ensure
			screen = a_screen;
			identifier = an_identifier;
			is_allocated = is_allocated_r
		end; 

	screen: SCREEN_I;
			-- Pointer on the display used

	is_allocated: BOOLEAN;
			-- Is resource allocated by the program ?

	identifier: POINTER
			-- X identifier of the resource


	set_allocated (b: BOOLEAN) is
		do
			is_allocated := b;
		end;

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
