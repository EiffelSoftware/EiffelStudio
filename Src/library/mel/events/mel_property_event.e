indexing

	description: 
		"Implementation of XPropertyEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PROPERTY_EVENT

inherit

	MEL_EVENT

creation
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
			!! Result.make_from_existing (c_event_atom (handle));
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

end -- class MEL_PROPERTY_EVENT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

