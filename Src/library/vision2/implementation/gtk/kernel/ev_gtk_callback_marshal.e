indexing
	description: "Callback Marshal to deal with gtk signal emissions"
	status: "See notice at end of class"
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
		
	EV_GTK_KEY_CONVERSION
		undefine
			default_create
		end

	EV_INTERMEDIARY_ROUTINES
		undefine
			default_create
		end

	EXCEPTIONS
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create
	

feature {NONE} -- Initialization

	default_create is
			-- Create the dispatcher, one object per system.
		do
			initialize
		end

	initialize is
			-- Initialize callbacks
		once
			c_ev_gtk_callback_marshal_init (Current, $marshal)
		end

feature {EV_ANY_IMP} -- Access

	enable_exception_handling is
			-- Enable event exception handling
		do
			exception_handling_enabled := True
		end

	disable_exception_handling is
			-- Enable event exception handling
		do
			last_callback_had_exception := False
			last_exception_message := Void
			exception_handling_enabled := False
		end
		
	exception_handling_enabled: BOOLEAN
			-- Is main loop exception handling enabled?

	last_callback_had_exception: BOOLEAN
		-- Did the last call to `marshal' raise an exception?
		
	last_exception_message: STRING
		-- Message of last exception encountered by `marshal'

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
		do
			an_agent.call (translate.item (integer_pointer_tuple))
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
		
feature {EV_ANY_IMP, EV_APPLICATION_IMP}

	time_delta: INTEGER

	gdk_event_to_tuple (n_args: INTEGER; args: POINTER): TUPLE is
			-- A TUPLE containing `args' data from a GdkEvent.
			-- `n_args' is ignored.
		require
			--FIXME n_args_is_one: n_args = 1
		local
			gdk_event: POINTER
			p: POINTER
			event_type, keyval: INTEGER
			key: EV_KEY
		do
			gdk_event := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
			if {EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event) < 100000 then
				event_type := {EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event)
	
				if event_type = {EV_GTK_ENUMS}.Gdk_motion_notify_enum
				then
					set_motion_tuple (
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_x (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_y (gdk_event).truncated_to_integer,
						0.5,--feature {EV_GTK_EXTERNALS}.gdk_event_motion_struct_xtilt (gdk_event),
						0.5,--feature {EV_GTK_EXTERNALS}.gdk_event_motion_struct_ytilt (gdk_event),
						0.5,--feature {EV_GTK_EXTERNALS}.gdk_event_motion_struct_pressure (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
					)
					Result := motion_tuple
				elseif event_type = {EV_GTK_ENUMS}.Gdk_configure_enum then
					set_dimension_tuple (
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_x (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_y (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_width (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_height (gdk_event)
					)
					Result := dimension_tuple	
	--			when
	--				Gdk_nothing_enum,
	--				Gdk_delete_enum,
	--				Gdk_destroy_enum,
	--				Gdk_focus_change_enum,
	--				Gdk_map_enum,
	--				Gdk_unmap_enum,
	--				Gdk_enter_notify_enum,
	--				Gdk_leave_notify_enum,
	--				Gdk_proximity_in_enum,
	--				Gdk_proximity_out_enum
	--			then
	--				Result := Void  -- This used to be empty_tuple but now 'call' can take Void values.
	
				elseif event_type = {EV_GTK_ENUMS}.Gdk_expose_enum
				then
					p := {EV_GTK_EXTERNALS}.gdk_event_expose_struct_area (gdk_event)
					set_dimension_tuple (
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (p),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (p),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (p),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (p)
					)
					Result := dimension_tuple
				elseif (event_type = {EV_GTK_ENUMS}.Gdk_button_press_enum or else event_type = {EV_GTK_ENUMS}.Gdk_2button_press_enum or else event_type = {EV_GTK_ENUMS}.Gdk_3button_press_enum)
				then
					Result := [
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_type (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event),
						0.5,
						0.5,
						0.5,
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
					]
	
				elseif event_type = {EV_GTK_ENUMS}.Gdk_button_release_enum
				then
						-- gdk_event type GdkEventButton
					Result := [
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event),
						0.5,
						0.5,
						0.5,
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
						{EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
					]
				elseif (event_type = {EV_GTK_ENUMS}.Gdk_key_press_enum or else event_type = {EV_GTK_ENUMS}.Gdk_key_release_enum)
				then
					keyval := {EV_GTK_EXTERNALS}.gdk_event_key_struct_keyval (gdk_event)
					if valid_gtk_code (keyval) then
						create key.make_with_code (key_code_from_gtk (keyval))
					end
					Result := [key]
				end
			end
		end

feature {EV_ANY_IMP}

	key_event_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GdkEventKey to tuple.
		local
			keyval: INTEGER
			gdkeventkey: POINTER
			a_key_string: STRING
			key: EV_KEY
			a_key_press: BOOLEAN
		do
			gdkeventkey := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
			if {EV_GTK_EXTERNALS}.gdk_event_key_struct_type (gdkeventkey) = {EV_GTK_EXTERNALS}.gdk_key_press_enum then
				a_key_press := True
				create a_key_string.make (0)
				a_key_string.from_c ({EV_GTK_EXTERNALS}.gdk_event_key_struct_string (gdkeventkey))
			end
			keyval := {EV_GTK_EXTERNALS}.gdk_event_key_struct_keyval (gdkeventkey)
			if valid_gtk_code (keyval) then
				create key.make_with_code (key_code_from_gtk (keyval))
			end
			
			Result := [key, a_key_string, a_key_press]
		end

	size_allocate_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GtkAllocation to tuple.
		local
			gtk_alloc: POINTER
		do
			gtk_alloc := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
			set_dimension_tuple (
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_x (gtk_alloc),
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_y (gtk_alloc),
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_width (gtk_alloc),
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_height (gtk_alloc)
			)
			Result := dimension_tuple
		end

	configure_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GtkAllocation to tuple.
		local
			gdk_configure: POINTER
		do
			gdk_configure := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
			set_dimension_tuple (
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_x (gdk_configure),
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_y (gdk_configure),
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_width (gdk_configure),
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_height (gdk_configure)
			)
			Result := dimension_tuple
		end

feature {EV_ANY_IMP} -- Agent implementation routines
		
	gtk_value_int_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [INTEGER] is
			-- Tuple containing integer value from first of `args'.
		do
			integer_tuple.put ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_int (args), 1)
			Result := integer_tuple
		end

	gtk_args_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [INTEGER, POINTER] is
			-- Tuple containing the data passed from our custom Gtk marshal
		do
			Result := [n_args, args]
		end

	column_resize_callback_translate (n: INTEGER; args: POINTER): TUPLE [INTEGER, INTEGER] is
			-- Translate function for MCL
		local
			gtkarg2: POINTER
		do
			gtkarg2 := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1)
			Result := [{EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_int (args) + 1, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_int (gtkarg2)]
			-- Column is zero based in gtk.
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
			args_not_null: n_args > 0 implies args /= default_pointer
		local
			retried: BOOLEAN
		do
			if not retried then
				if internal.type_conforms_to (internal.dynamic_type (action), f_of_tuple_type_id) then
					-- `action' isn't a translation agent and the open operands are TUPLE [TUPLE]
					-- Direct call of ACTION_SEQUENCE.call (?).
					action.call (Void)
				else
					-- `action' is a translation agent, call with TUPLE [INTEGER, POINTER].
					-- In most cases, translate_and_call (an_agent, translate, ?, ?)
					check
						not_for_empty_tuple: not internal.type_conforms_to (internal.dynamic_type (action), f_of_tuple_type_id)
					end
					integer_pointer_tuple.put (n_args, 1)
					integer_pointer_tuple.put (args, 2)
					action.call (integer_pointer_tuple)
				end
			end
		rescue
			if exception_handling_enabled then
				retried := True
				last_callback_had_exception := True
				last_exception_message := tag_name 
				if last_exception_message /= Void then
					last_exception_message := last_exception_message + " Code: " + exception.out
				end
				retry				
			end
		end

	f_of_tuple_type_id: INTEGER is
		once
			Result := internal.dynamic_type (create {PROCEDURE [ANY, TUPLE [TUPLE]]})
		end
	
feature {EV_ANY_IMP} -- Tuple optimizations.
		
	empty_tuple_tuple: TUPLE is
		once
			Result := [[]]
		end
		
	tuple_tuple: TUPLE [TUPLE] is
		once
			Result := [[]]
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
		
	gtk_value_pointer_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [POINTER] is
			-- Tuple containing integer value from first of `args'.
		do
			pointer_tuple.put ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args), 1)
			Result := pointer_tuple
		end

feature {NONE} -- Externals

	internal: INTERNAL is
			-- Internal feature access
		once
			create Result
		end

	frozen c_ev_gtk_callback_marshal_init (
		object: EV_GTK_CALLBACK_MARSHAL; a_marshal: POINTER
		) is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

	frozen c_ev_gtk_callback_marshal_destroy
		is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

feature {EV_ANY_IMP} -- Externals
		
	frozen set_eif_oid_in_c_object (a_c_object: POINTER; eif_oid: INTEGER;
		c_object_dispose_address: POINTER) is
				-- Store Eiffel object_id in `gtk_object'.
				-- Set up signal handlers.
		external
			"C (GtkWidget*, int, void*) | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_set_eif_oid_in_c_object"
		end

	frozen c_signal_connect (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: PROCEDURE [ANY, TUPLE]; invoke_after_handler: BOOLEAN): INTEGER is
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		external
			"C (GtkObject*, gchar*, EIF_OBJECT, gboolean): guint | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_signal_connect"
		end

	frozen c_signal_connect_true (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		external
			"C (GtkObject*, gchar*, EIF_OBJECT): guint | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_signal_connect_true"
		end
		
feature {EV_APPLICATION_IMP, EV_TIMEOUT_IMP} -- Externals

	frozen c_ev_gtk_callback_marshal_timeout_connect
		(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT): EIF_INTEGER | %"ev_gtk_callback_marshal.h%""
		end
		
	frozen c_ev_gtk_callback_marshal_delayed_agent_call
				(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT) | %"ev_gtk_callback_marshal.h%""
		end

end -- class EV_GTK_CALLBACK_MARSHAL

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

