indexing

	description: 
		"Implementation of XFocusChangeEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FOCUS_CHANGE_EVENT

inherit

	MEL_EVENT

create
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




end -- class MEL_FOCUS_CHANGE_EVENT


