indexing

	description: 
		"Implementation of XPropertyEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PROPERTY_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

    time: INTEGER is
            -- Time when property was changed?
        do
            Result := c_event_time (handle)
        end;

	atom: MEL_ATOM is
			-- Name of property involved
        do
			create Result.make_from_existing (c_event_atom (handle));
		ensure
			result_not_void: Result /= Void
        end;

	state: INTEGER is
			-- State of Event
		do
            Result := c_event_state (handle)
		ensure
			valid_result: is_property_new_value or else
				is_property_delete
		end;

	is_property_new_value: BOOLEAN is
			-- Is `state' value set to PropertyNewValue?
		do
			Result := state = PropertyNewValue
		end;	

	is_property_delete: BOOLEAN is
			-- Is `state' value set to PropertyDelete?
		do
			Result := state = PropertyDelete
		end;	

feature {NONE} -- Implementation

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XPropertyEvent *): EIF_INTEGER"
		end;

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XPropertyEvent *): EIF_INTEGER"
		end;

	c_event_atom (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XPropertyEvent *): EIF_POINTER"
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




end -- class MEL_PROPERTY_EVENT


