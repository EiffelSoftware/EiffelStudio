indexing
	
	description: "Item that can be stacked on the screen"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	STACKABLE

feature -- Access

	screen_object: POINTER is
			-- implementation of current widget
		require
			exists: not destroyed;
		do
			Result := implementation.screen_object;
		end;

	parent: COMPOSITE is
		require
			exists: not destroyed;
		deferred
		end;

feature -- Status report

	is_stackable: BOOLEAN is
		require
			exists: not destroyed;
		do
			Result := implementation.is_stackable;
		end

	destroyed: BOOLEAN is
		deferred
		end;

	realized: BOOLEAN is
		require
			exists: not destroyed;
		deferred
		end;

feature {NONE}

	implementation: STACKABLE_I;

end -- STACKABLE

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

