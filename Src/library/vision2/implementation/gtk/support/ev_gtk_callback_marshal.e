-- FIXME review this!!
indexing
	description:
		"Marshaler for GTK callbacks."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_CALLBACK_MARSHAL

inherit
	ANY
		undefine
			default_create
		end

	INTERNAL
		undefine
			default_create
		end

	GTK_ENUMS
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Pass the address of Current and `marshal' to the C externals.
		do
			c_ev_gtk_callback_marshal_init (Current, $marshal)
			action_sequence_type_id := dynamic_type (create {ACTION_SEQUENCE [TUPLE]}.make ("dummy", <<>>))
			f_of_tuple_type_id :=  dynamic_type (create {PROCEDURE [ANY, TUPLE [TUPLE]]})
			create C
		end

	c_ev_gtk_callback_marshal_init (object: EV_GTK_CALLBACK_MARSHAL; a_marshal: POINTER) is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end
	
feature {NONE} -- Basic operation

	marshal (agent: PROCEDURE [ANY, TUPLE]; n_args: INTEGER; args: POINTER) is
			-- Call `agent' with data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
		require
			agent_not_void: agent /= Void
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= Default_pointer
			two_args_max: n_args <= 2
				-- At present we only know how to deal with
				-- no arguments or one agrument. (a GdkEvent*)
				-- (Or two arguments which are ignored)
				-- FIXME improve this comment. sam
		local
			tuple: TUPLE
		do
			if n_args = 1 then
				tuple := gdk_event_to_tuple (gtk_value_pointer (args))
					-- The GtkEvent* is the first argument
					-- so args[0] == args.
				if tuple /= Void then
					if
						--type_conforms_to (dynamic_type (agent.target), action_sequence_type_id) 
						type_conforms_to (dynamic_type (agent), f_of_tuple_type_id)
					then
						agent.call ([tuple])
					else
						agent.call (tuple)
					end
				end
			else
				agent.call ([[]])
			end
		end

	gtk_value_pointer (arg: POINTER): POINTER is
			-- Pointer to the value of a GtkArg.
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

feature {NONE} -- Conversion

	gdk_event_to_tuple (gdk_event: POINTER): TUPLE is
			-- A TUPLE containing data from a GdkEvent.
		local
			p: POINTER
		do
			inspect
				C.gdk_event_any_struct_type (gdk_event)
			when
				Gdk_nothing_enum,
				Gdk_delete_enum,
				Gdk_destroy_enum,
				Gdk_focus_change_enum,
				Gdk_map_enum,
				Gdk_unmap_enum
			then
					-- gdk_event type GdkEventAny
				Result := []

			when
				Gdk_expose_enum
			then
					-- gdk_event type GdkEventExpose
				p := C.gdk_event_expose_struct_area (gdk_event)
				Result := [
					C.gdk_rectangle_struct_x (p),
					C.gdk_rectangle_struct_y (p),
					C.gdk_rectangle_struct_width (p),
					C.gdk_rectangle_struct_height (p)
				]

			when
				Gdk_motion_notify_enum
			then
					-- gdk_event type GdkEventMotion
				Result := [
					C.gdk_event_motion_struct_x (gdk_event).truncated_to_integer,
					C.gdk_event_motion_struct_y (gdk_event).truncated_to_integer,
					C.gdk_event_motion_struct_xtilt (gdk_event),
					C.gdk_event_motion_struct_ytilt (gdk_event),
					C.gdk_event_motion_struct_pressure (gdk_event),
					C.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
					C.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
				]

			when
				Gdk_button_press_enum,
				Gdk_2button_press_enum
			then
					-- gdk_event type GdkEventButton
				Result := [
					C.gdk_event_button_struct_type (gdk_event),
					C.gdk_event_button_struct_x (gdk_event).truncated_to_integer,
					C.gdk_event_button_struct_y (gdk_event).truncated_to_integer,
					C.gdk_event_button_struct_button (gdk_event),
					C.gdk_event_button_struct_xtilt (gdk_event),
					C.gdk_event_button_struct_ytilt (gdk_event),
					C.gdk_event_button_struct_pressure (gdk_event),
					C.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
					C.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
				]

			when
				Gdk_button_release_enum
			then
					-- gdk_event type GdkEventButton
				Result := [
					C.gdk_event_button_struct_x (gdk_event).truncated_to_integer,
					C.gdk_event_button_struct_y (gdk_event).truncated_to_integer,
					C.gdk_event_button_struct_button (gdk_event),
					C.gdk_event_button_struct_xtilt (gdk_event),
					C.gdk_event_button_struct_ytilt (gdk_event),
					C.gdk_event_button_struct_pressure (gdk_event),
					C.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
					C.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
				]

			when
				Gdk_3button_press_enum
			then
					-- gdk_event type GdkEventButton
					-- Ignored

			when
				Gdk_key_press_enum,
				Gdk_key_release_enum
			then
					-- gdk_event type GdkEventKey
				check
					Gdk_key_event_not_handled: False
				end

			when
				Gdk_enter_notify_enum,
				Gdk_leave_notify_enum
			then
					-- gdk_event type GdkEventCrossing
				Result := []

			when
				Gdk_configure_enum
			then
					-- gdk_event type GdkEventConfigure
				check
					gdk_configure_event_not_handled: False
				end

			when
				Gdk_property_notify_enum
			then
					-- gdk_event type GdkEventProperty
				check
					gdk_property_event_not_handled: False
				end

			when
				Gdk_selection_clear_enum,
				Gdk_selection_request_enum,
				Gdk_selection_notify_enum
			then
					-- gdk_event type GdkEventSelection
				check
					gdk_selection_event_not_handled: False
				end

			when
				Gdk_proximity_in_enum,
				Gdk_proximity_out_enum
			then
					-- gdk_event type GdkEventProximity
				Result := []
					
			when
				Gdk_drag_enter_enum,
				Gdk_drag_leave_enum,
				Gdk_drag_motion_enum,
				Gdk_drag_status_enum,
				Gdk_drop_start_enum,
				Gdk_drop_finished_enum
			then
				check
					gdk_drag_and_drop_event_not_handled: False
				end

			when
				Gdk_client_event_enum
			then
					-- gdk_event type GdkEventSelection
				check	
					gdk_client_event_not_handled: False
				end
			when	
				Gdk_visibility_notify_enum
			then
					-- gdk_event type GdkEventAny
				check
					gdk_visibility_event_not_handled: False
				end

			when
				Gdk_no_expose_enum
			then
					-- gdk_event type GdkEventNoExpose
				check
					gdk_no_expose_event_not_handled: False
				end

			end
		end

feature {NONE} -- Implementation

	action_sequence_type_id: INTEGER
			-- Type id of ACTION_SEQUENCE_TUPLE [TUPLE]

	f_of_tuple_type_id: INTEGER
			-- Type id of PROCEDURE [ANY [TUPLE [TUPLE]]

	C: EV_C_EXTERNALS

invariant
	c_externals_object_not_void: C /= Void

end -- class EV_GTK_CALLBACK_MARSHAL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:08  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.14  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.1.4.13  2000/01/27 19:29:34  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.12  2000/01/13 20:55:48  oconnor
--| allow two arg signals for notebook switch
--|
--| Revision 1.1.4.11  1999/12/14 16:49:36  oconnor
--| incorrectly tuncated perssure to integer
--|
--| Revision 1.1.4.10  1999/12/13 20:00:26  oconnor
--| added auto detection of call target (action seq or agent)
--|
--| Revision 1.1.4.9  1999/12/09 18:16:48  oconnor
--| added x_root and y_root to screen pointer data
--|
--| Revision 1.1.4.8  1999/12/09 00:43:29  oconnor
--| added crossing event support
--|
--| Revision 1.1.4.7  1999/12/08 01:48:33  oconnor
--| only require args /= NULL when n_args > 0
--|
--| Revision 1.1.4.6  1999/12/07 20:47:25  oconnor
--| more comments
--|
--| Revision 1.1.4.5  1999/12/07 04:08:09  oconnor
--| use new externals object
--|
--| Revision 1.1.4.4  1999/12/06 21:24:50  brendel
--| Changed small errors.
--|
--| Revision 1.1.4.3  1999/12/06 19:54:41  oconnor
--| added tuple conversions for more event types
--|
--| Revision 1.1.4.2  1999/12/05 00:36:49  oconnor
--| fixed agent call with empty tuple
--|
--| Revision 1.1.4.1  1999/11/23 23:33:51  oconnor
--| merged from REVIEW branch
--|
--| Revision 1.1.2.2  1999/11/23 02:08:22  oconnor
--| Removed manualy created struct accessors in favour of new GEL ones
--| added _enum suffix to enums
--| fixed marshal to correctly extract GtkEventData from GtkArg[]
--|
--| Revision 1.1.2.1  1999/11/18 03:39:35  oconnor
--| initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
