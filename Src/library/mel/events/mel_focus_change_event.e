indexing

	description: 
		"Implementation of XFocusChangeEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FOCUS_CHANGE_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	mode: INTEGER is
			-- Crossing mode
		do
			Result := c_event_mode (handle)
		ensure
			valid_result: is_notify_normal or else is_notify_grab or else
					is_notify_ungrab
		end;

	is_notify_normal: BOOLEAN is
			-- Is `mode' set to notify_normal?
		do
			Result := mode = NotifyNormal
		end;

	is_notify_grab: BOOLEAN is
			-- Is `mode' set to notify_grab?
		do
			Result := mode = NotifyGrab
		end;

	is_notify_ungrab: BOOLEAN is
			-- Is `mode' set to notify_ungrab?
		do
			Result := mode = NotifyUngrab
		end;

	detail: INTEGER is
			-- Focus detail
		do
			Result := c_event_detail (handle)
		ensure
			valid_result: is_notify_ancestor or else is_notify_virtual or else
					is_notify_inferior or else is_notify_non_linear or else
					is_notify_non_linear_virtual
		end;

	is_notify_ancestor: BOOLEAN is
			-- Is the `detail' notify_ancestor?
		do
			Result := detail = NotifyAncestor
		end;

	is_notify_virtual: BOOLEAN is
			-- Is the `detail' notify_virtual?
		do
			Result := detail = NotifyVirtual
		end;

	is_notify_inferior: BOOLEAN is
			-- Is the `detail' notify_inferior?
		do
			Result := detail = NotifyInferior
		end;

	is_notify_non_linear: BOOLEAN is
			-- Is the `detail' notify_non_linear?
		do
			Result := detail = NotifyNonlinear
		end;

	is_notify_non_linear_virtual: BOOLEAN is
			-- Is the `detail' notify_non_linear_virtual?
		do
			Result := detail = NotifyNonlinearVirtual
		end;

feature {NONE} -- Implementation

	c_event_mode (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XFocusChangeEvent *): EIF_INTEGER"
		end;

	c_event_detail (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XFocusChangeEvent *): EIF_INTEGER"
		end;

end -- class MEL_FOCUS_CHANGE_EVENT


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

