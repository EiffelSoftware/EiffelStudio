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
--| EiffelVision: library of reusable components for ISE Eiffel.
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

