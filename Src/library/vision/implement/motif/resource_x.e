
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
			is_allocated := is_allocated_r;
			screen_object := screen.screen_object;
		ensure
			screen = a_screen;
			identifier = an_identifier;
			is_allocated = is_allocated_r
		end; 

	screen: SCREEN_I;
			-- Pointer on the display used

	screen_object: POINTER;
			-- Screen's screen object.
			--| The reason for a separate attribute (instead of 
			--| using screen.screen_object) so that the Current objects
			--| does not reference the `screen' in the dispose
			--| routine. It is very important that no references
			--| are used in the dispose routine because they maybe
			--| garbage collected first. However, we can use expanded types
			--| in the dispose routine.

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
