indexing
	description: 
		"Implementation of XVisibilityEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_VISIBILITY_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	state: INTEGER is
			-- Visibility state
		do
			Result := c_event_state (handle)
		ensure
			valid_result: is_visibility_unobscured or else
				is_visibility_partially_obscured or else
				is_visibility_full_obscured
		end;

	is_visibility_unobscured: BOOLEAN is
			-- Is visibility unobscured?
		do
			Result := state = VisibilityUnobscured
		end;

	is_visibility_partially_obscured: BOOLEAN is
			-- Is visibility partially obscured?
		do
			Result := state = VisibilityPartiallyObscured
		end;

	is_visibility_full_obscured: BOOLEAN is
			-- Is visibility fully obscured?
		do
			Result := state = VisibilityFullyObscured
		end;

feature {NONE} -- Implementation

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XVisibilityEvent *): EIF_INTEGER"
		end;

end -- class MEL_VISIBILITY_EVENT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
