indexing
	description: "Callback Marshal to deal with gtk signal emissions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_CALLBACK_MARSHAL

inherit

	IDENTIFIED
		undefine
			default_create,
			copy,
			is_equal
		end

	EV_C_UTIL
		undefine
			default_create
		end

	INTERNAL
		undefine
			default_create,
			is_equal
		end
		
	EV_GTK_KEY_CONVERSION
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
			-- Create the dispatcher, one object per system.
		once
			c_ev_gtk_callback_marshal_init (Current, $marshal)
		end

feature {EV_ANY_IMP} -- Access

	translate_and_call (
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
		n_args: INTEGER;
		args: POINTER
	) is
			-- Call `an_agent' using `translate' to convert `args' and `n_args'
			-- from raw GTK+ event data to a TUPLE.
		require
			an_agent_not_void: an_agent /= Void
			translate_not_void: translate /= Void
		local
			t: TUPLE
			gdk_event: POINTER
		do
			-- integer_pointer_tuple has been already correctly set by `marshal'.
			--integer_pointer_tuple.put (n_args, 1)
			--integer_pointer_tuple.put (args, 2)

			t := translate.item (integer_pointer_tuple)

			if t /= Void then
				if
					--| FIXME IEK This needs to be optimized.
					type_conforms_to (
						dynamic_type (an_agent),
						f_of_tuple_type_id
					)
				then
					-- This is a call to {ACTION_SEQUENCE}.call ([])
					tuple_tuple.put (t, 1)
					an_agent.call (tuple_tuple)
				else	
					an_agent.call (t)
				end
			else
				gdk_event := gtk_value_pointer (args)
				if 
					gdk_event = NULL or else
					C.gdk_event_any_struct_type (gdk_event) /= C.GDK_3BUTTON_PRESS_ENUM
				then
					print ("FIXME " + an_agent.generating_type + " in " + generating_type + " not called%N")
				end
			end
		end
		
	motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER] is
			-- 
		once
			Result := [0, 0, 0.0, 0.0, 0.0, 0, 0]
		end
		
	set_motion_tuple (a_1, a_2: INTEGER; a_3, a_4, a_5: DOUBLE; a_6, a_7: INTEGER) is
		do
			motion_tuple.put (a_1, 1)
			motion_tuple.put (a_2, 2)
			motion_tuple.put (a_3, 3)
			motion_tuple.put (a_4, 4)
			motion_tuple.put (a_5, 5)
			motion_tuple.put (a_6, 6)
			motion_tuple.put (a_7, 7)
		end
		
	dimension_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- 
		once
			Result := [0, 0, 0, 0]
		end
		
	set_dimension_tuple (a_1, a_2, a_3, a_4: INTEGER) is
		do
			dimension_tuple.put (a_1, 1)
			dimension_tuple.put (a_2, 2)
			dimension_tuple.put (a_3, 3)
			dimension_tuple.put (a_4, 4)			
		end

	gdk_event_to_tuple (n_args: INTEGER; args: POINTER): TUPLE is
			-- A TUPLE containing `args' data from a GdkEvent.
			-- `n_args' is ignored.
		require
			--FIXME n_args_is_one: n_args = 1
		local
			gdk_event: POINTER
			p: POINTER
			keyval: INTEGER
			key: EV_KEY
			local_c: EV_C_EXTERNALS
		do
			local_c := C
			gdk_event := gtk_value_pointer (args)
			
			if local_C.gdk_event_any_struct_type (gdk_event) < 100000 then
			inspect
				local_C.gdk_event_any_struct_type (gdk_event)
			when
				Gdk_motion_notify_enum
			then
				set_motion_tuple (
					local_C.gdk_event_motion_struct_x (gdk_event).truncated_to_integer,
					local_C.gdk_event_motion_struct_y (gdk_event).truncated_to_integer,
					local_C.gdk_event_motion_struct_xtilt (gdk_event),
					local_C.gdk_event_motion_struct_ytilt (gdk_event),
					local_C.gdk_event_motion_struct_pressure (gdk_event),
					local_C.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
					local_C.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
				)
				Result := motion_tuple
			when
				Gdk_nothing_enum,
				Gdk_delete_enum,
				Gdk_destroy_enum,
				Gdk_focus_change_enum,
				Gdk_map_enum,
				Gdk_unmap_enum,
				Gdk_enter_notify_enum,
				Gdk_leave_notify_enum,
				Gdk_proximity_in_enum,
				Gdk_proximity_out_enum
			then
				Result := empty_tuple

			when
				Gdk_expose_enum
			then
				p := local_C.gdk_event_expose_struct_area (gdk_event)
				set_dimension_tuple (
					local_C.gdk_rectangle_struct_x (p),
					local_C.gdk_rectangle_struct_y (p),
					local_C.gdk_rectangle_struct_width (p),
					local_C.gdk_rectangle_struct_height (p)
				)
				Result := dimension_tuple
			when
				Gdk_button_press_enum,
				Gdk_2button_press_enum
			then
				Result := [
					local_C.gdk_event_button_struct_type (gdk_event),
					local_C.gdk_event_button_struct_x (gdk_event).truncated_to_integer,
					local_C.gdk_event_button_struct_y (gdk_event).truncated_to_integer,
					local_C.gdk_event_button_struct_button (gdk_event),
					local_C.gdk_event_button_struct_xtilt (gdk_event),
					local_C.gdk_event_button_struct_ytilt (gdk_event),
					local_C.gdk_event_button_struct_pressure (gdk_event),
					local_C.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
					local_C.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
				]

			when
				Gdk_button_release_enum
			then
					-- gdk_event type GdkEventButton
				Result := [
					local_C.gdk_event_button_struct_x (gdk_event).truncated_to_integer,
					local_C.gdk_event_button_struct_y (gdk_event).truncated_to_integer,
					local_C.gdk_event_button_struct_button (gdk_event),
					local_C.gdk_event_button_struct_xtilt (gdk_event),
					local_C.gdk_event_button_struct_ytilt (gdk_event),
					local_C.gdk_event_button_struct_pressure (gdk_event),
					local_C.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
					local_C.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
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
				keyval := local_C.gdk_event_key_struct_keyval (gdk_event)
				if valid_gtk_code (keyval) then
					create key.make_with_code (key_code_from_gtk (keyval))
				end
				Result := [key]
			when
				Gdk_configure_enum
			then
				set_dimension_tuple (
					local_C.gdk_event_configure_struct_x (gdk_event),
					local_C.gdk_event_configure_struct_y (gdk_event),
					local_C.gdk_event_configure_struct_width (gdk_event),
					local_C.gdk_event_configure_struct_height (gdk_event)
				)
				Result := dimension_tuple
			end
			end
		end
		
	key_event_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GdkEventKey to tuple.
		local
			keyval: INTEGER
			gdkeventkey: POINTER
			a_key_string: STRING
			key: EV_KEY
			a_key_press: BOOLEAN
		do
			gdkeventkey := gtk_value_pointer (p)
			if C.gdk_event_key_struct_type (gdkeventkey) = C.gdk_key_press_enum then
				a_key_press := True
				create a_key_string.make (0)
				a_key_string.from_c (C.gdk_event_key_struct_string (gdkeventkey))
			end
			keyval := C.gdk_event_key_struct_keyval (gdkeventkey)
			if valid_gtk_code (keyval) then
				create key.make_with_code (key_code_from_gtk (keyval))
			end
			
			Result := [key, a_key_string, a_key_press]
		end

	size_allocate_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GtkAllocation to tuple.
		local
			gtk_alloc: POINTER
			local_C: EV_C_EXTERNALS
		do
			gtk_alloc := gtk_value_pointer (p)
			local_C := C
			set_dimension_tuple (
				local_C.gtk_allocation_struct_x (gtk_alloc),
				local_C.gtk_allocation_struct_y (gtk_alloc),
				local_C.gtk_allocation_struct_width (gtk_alloc),
				local_C.gtk_allocation_struct_height (gtk_alloc)
			)
			Result := dimension_tuple
		end

feature {EV_ANY_IMP} -- Agent implementation routines

	signal_disconnect_agent_routine (a_c_object: POINTER; a_connection_id: INTEGER; signal_ids_list: ARRAYED_LIST [INTEGER]) is
			-- Disconnect signal connection with `a_connection_id'.
			-- Used to avoid reference on widget implementation object.
		require
			a_connection_id_positive: a_connection_id > 0
		do
			C.gtk_signal_disconnect (a_c_object, a_connection_id)
			signal_ids_list.prune_all (a_connection_id)
		end
		
	on_key_event_intermediary (a_c_object: POINTER; a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Intermediate agent to prevent reference on implementation object from agent.
		do
			c_get_eif_reference_from_object_id (a_c_object).on_key_event (a_key, a_key_string, a_key_press)
		end

	connect_button_press_switch_intermediary (a_c_object: POINTER) is
			-- 
		do
			c_get_eif_reference_from_object_id (a_c_object).connect_button_press_switch
		end
		
	button_press_switch_intermediary (
			a_c_object: POINTER;
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER
		) is
				-- 
		do
			c_get_eif_reference_from_object_id (a_c_object).button_press_switch (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end
			
	on_size_allocate_intermediate (a_c_object: POINTER; a_x, a_y, a_width, a_height: INTEGER) is
			--
		do
			c_get_eif_reference_from_object_id (a_c_object).on_size_allocate (a_x, a_y, a_width, a_height)
		end
		
	kamikaze_agent (an_action_sequence: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]];
		target: PROCEDURE [ANY, TUPLE]):
		PROCEDURE [ANY, TUPLE []] is
			-- Agent to remove `target' and itself form `an_action_sequence'.
		local
			kamikaze_cell: CELL [PROCEDURE [ANY, TUPLE[]]]
		do
			create kamikaze_cell.put (Void)
			Result := agent do_kamikaze (
				an_action_sequence,
				target,
				kamikaze_cell
			)
			kamikaze_cell.put (Result)
		end
	
	do_kamikaze (an_action_sequence: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]];
		target: PROCEDURE [ANY, TUPLE];
		kamikaze_cell: CELL [PROCEDURE [ANY, TUPLE]]) is
			-- Remove `target' and agent for self (from `kamikaze_cell') from
			-- `an_action_sequence'.
		do
			an_action_sequence.prune_all (target)
			an_action_sequence.prune_all (kamikaze_cell.item)
		end
		
	is_destroyed: BOOLEAN

feature {EV_APPLICATION_IMP} -- Destruction

	destroy is
			-- Disconnect the 
		do
			--c_ev_gtk_callback_marshal_destroy
			is_destroyed := True
		end

feature {NONE} -- Implementation

	marshal (action: PROCEDURE [ANY, TUPLE]; n_args: INTEGER; args: POINTER) is
			-- Call `action' with GTK+ event data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
			-- Called by C function `c_ev_gtk_callback_marshal'.
		require
			action_not_void: action /= Void
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= NULL
		do
			if type_conforms_to (dynamic_type (action), f_of_tuple_type_id) then
				-- `action' isn't a translation agent and the open operands are TUPLE [TUPLE]
				-- Direct call of ACTION_SEQUENCE.call (?).
				action.call (empty_tuple_tuple)
			else
				-- `action' is a translation agent, call with TUPLE [INTEGER, POINTER].
				-- In most cases, translate_and_call (an_agent, translate, ?, ?)
				check
					not_for_empty_tuple: not type_conforms_to (dynamic_type (action), f_of_tuple_type_id)
				end
				integer_pointer_tuple.put (n_args, 1)
				integer_pointer_tuple.put (args, 2)
				action.call (integer_pointer_tuple)
			end
		end

	f_of_tuple_type_id: INTEGER is
		once
			Result := dynamic_type (create {PROCEDURE [ANY, TUPLE [TUPLE]]})
		end
	
feature {EV_ANY_IMP} -- Tuple optimizations.
		
	empty_tuple: TUPLE is
		once
			Result := []
		end
		
	empty_tuple_tuple: TUPLE is
		once
			Result := [[]]
		end
		
	tuple_tuple: TUPLE [TUPLE] is
		once
			Result := [[]]
		end
		
	tuple: TUPLE is
		once
			Result := []
		end
		
	pointer_tuple: TUPLE [POINTER] is
			-- 
		once
			Result := [Default_pointer]
		end
	
	integer_tuple: TUPLE [INTEGER] is
		once
			Result := [0]
		end

	integer_pointer_tuple: TUPLE [INTEGER, POINTER] is
		once
			Result := [0, default_pointer]
		end

feature {NONE} -- Externals

	c_ev_gtk_callback_marshal_init (
		object: EV_GTK_CALLBACK_MARSHAL; a_marshal: POINTER
		) is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

	c_ev_gtk_callback_marshal_destroy
		is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end
		
	c_get_eif_reference_from_object_id (a_c_object: POINTER): EV_WIDGET_IMP is
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		end

feature {EV_ANY_IMP} -- Externals

	gtk_value_pointer (arg: POINTER): POINTER is
			-- Pointer to the value of a GtkArg.
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

	gtk_value_int (arg: POINTER): INTEGER is
			-- Integer value from a GtkArg.
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end
		
feature {EV_APPLICATION_IMP} -- Externals
		
	c_ev_gtk_callback_marshal_delayed_agent_call
				(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT) | %"gtk_eiffel.h%""
		end

	c_ev_gtk_callback_marshal_idle_connect
				(an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Call `an_agent' when idle.
		external
			"C (EIF_OBJECT): guint | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_CALLBACK_MARSHAL

