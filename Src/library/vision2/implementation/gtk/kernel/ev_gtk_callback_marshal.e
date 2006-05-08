indexing
	description: "Callback Marshal to deal with gtk signal emissions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	translate_and_call (
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
	) is
			-- Call `an_agent' using `translate' to convert `args' and `n_args'
		require
			an_agent_not_void: an_agent /= Void
			translate_not_void: translate /= Void
		do
			an_agent.call (translate.item (integer_pointer_tuple))
		end

	dimension_tuple (a_1, a_2, a_3, a_4: INTEGER): like internal_dimension_tuple is
			-- Return a dimension tuple from given arguments.
		do
			Result := internal_dimension_tuple
			Result.put_integer (a_1, 1)
			Result.put_integer (a_2, 2)
			Result.put_integer (a_3, 3)
			Result.put_integer (a_4, 4)
		end

	key_tuple (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN): like internal_key_tuple is
			-- Return a key tuple from given arguments.
		do
			Result := internal_key_tuple
			Result.put_reference (a_key, 1)
			Result.put_reference (a_key_string, 2)
			Result.put_boolean (a_key_press, 3)
		end

feature {EV_ANY_IMP, EV_APPLICATION_IMP}

	gdk_event_to_tuple (n_args: INTEGER; args: POINTER): TUPLE is
			-- A TUPLE containing `args' data from a GdkEvent.
			-- `n_args' is ignored.
		local
			gdk_event: POINTER
			p: POINTER
			event_type: INTEGER
			keyval: NATURAL_32
			key: EV_KEY
		do
			if n_args > 0 then
					-- If no arguments are available then a Void tuple is returned
				gdk_event := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
				event_type := {EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event)
				if event_type = {EV_GTK_ENUMS}.Gdk_configure_enum then
					Result := dimension_tuple	 (
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_x (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_y (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_width (gdk_event),
						{EV_GTK_EXTERNALS}.gdk_event_configure_struct_height (gdk_event)
					)
				elseif event_type = {EV_GTK_ENUMS}.Gdk_expose_enum
				then
					p := {EV_GTK_EXTERNALS}.gdk_event_expose_struct_area (gdk_event)
					Result := dimension_tuple (
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (p),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (p),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (p),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (p)
					)
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

	set_focus_event_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Converted GtkWidget* to tuple.
		do
			Result := [{EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)]
		end

	key_event_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GdkEventKey to tuple.
		local
			keyval: NATURAL_32
			gdkeventkey: POINTER
			a_key_string: STRING_32
			key: EV_KEY
			a_key_press: BOOLEAN
			a_cs: EV_GTK_C_STRING
		do
			gdkeventkey := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
			if {EV_GTK_EXTERNALS}.gdk_event_key_struct_type (gdkeventkey) = {EV_GTK_EXTERNALS}.gdk_key_press_enum then
				a_key_press := True
				create a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gdk_event_key_struct_string (gdkeventkey))
				a_key_string := a_cs.string
			end
			keyval := {EV_GTK_EXTERNALS}.gdk_event_key_struct_keyval (gdkeventkey)
			if valid_gtk_code (keyval) then
				create key.make_with_code (key_code_from_gtk (keyval))
			end
			Result := key_tuple (key, a_key_string, a_key_press)
		end

	size_allocate_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GtkAllocation to tuple.
		local
			gtk_alloc: POINTER
		do
			gtk_alloc := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
			Result := dimension_tuple (
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_x (gtk_alloc),
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_y (gtk_alloc),
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_width (gtk_alloc),
				{EV_GTK_EXTERNALS}.gtk_allocation_struct_height (gtk_alloc)
			)
		end

	configure_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Convert GtkAllocation to tuple.
		local
			gdk_configure: POINTER
		do
			gdk_configure := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
			Result := dimension_tuple (
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_x (gdk_configure),
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_y (gdk_configure),
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_width (gdk_configure),
				{EV_GTK_EXTERNALS}.gdk_event_configure_struct_height (gdk_configure)
			)
		end

feature {EV_ANY_IMP} -- Agent implementation routines

	gtk_value_int_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [INTEGER] is
			-- Tuple containing integer value from first of `args'.
		do
			Result := integer_tuple
			Result.put_integer ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_int (args), 1)
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
			l_exception: EXCEPTION
			l_integer_pointer_tuple: like integer_pointer_tuple
		do
			if not retried then
				l_integer_pointer_tuple := integer_pointer_tuple
				l_integer_pointer_tuple.put_integer (n_args, 1)
				l_integer_pointer_tuple.put_pointer (args, 2)
				action.call (l_integer_pointer_tuple)
			elseif not uncaught_exception_actions_called then
				create l_exception.make_with_tag_and_trace (tag_name, exception_trace)
				uncaught_exception_actions_called := True
				(create {EV_ENVIRONMENT}).application.uncaught_exception_actions.call ([l_exception])
				uncaught_exception_actions_called := False
			end
		rescue
			retried := True
			retry
		end

	uncaught_exception_actions_called: BOOLEAN
		-- Are the `uncaught_exceptions_actions' currently being called?
		-- This is used to prevent infinite looping should an exception be raised as part of calling `uncaught_exception_actions'.

feature {NONE} -- Tuple optimizations.

	internal_dimension_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- Once function used for global access of dimension tuple.
		once
			Result := [0, 0, 0, 0]
		end

	internal_key_tuple: TUPLE [EV_KEY, STRING_32, BOOLEAN] is
			-- Once function used for global access of key tuple.
		once
			Result := [Void, Void, False]
		end

feature {EV_ANY_IMP} -- Tuple optimizations

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
			pointer_tuple.put_pointer ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args), 1)
			Result := pointer_tuple
		end

feature {NONE} -- Externals

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




end -- class EV_GTK_CALLBACK_MARSHAL

