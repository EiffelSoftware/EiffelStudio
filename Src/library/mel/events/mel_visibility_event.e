indexing
	description: 
		"Implementation of XVisibilityEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_VISIBILITY_EVENT

inherit

	MEL_EVENT

create
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_VISIBILITY_EVENT


