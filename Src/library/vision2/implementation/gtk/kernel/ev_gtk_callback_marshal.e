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
			c_ev_gtk_callback_marshal_set_is_enabled (True)
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

	dimension_tuple (a_x, a_y, a_width, a_height: INTEGER): like internal_dimension_tuple is
			-- Return a dimension tuple from given arguments.
		do
			Result := internal_dimension_tuple
			Result.x := a_x
			Result.y := a_y
			Result.width := a_width
			Result.height := a_height
		end

	key_tuple (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN): like internal_key_tuple is
			-- Return a key tuple from given arguments.
		do
			Result := internal_key_tuple
			Result.key := a_key
			Result.string := a_key_string
			Result.key_press := a_key_press
		end

feature -- Implementation

	signal_connect (
		a_c_object: POINTER;
		a_signal_name: EV_GTK_C_STRING;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
		invoke_after_handler: BOOLEAN) is
				--
		local
			l_agent: PROCEDURE [ANY, TUPLE]
		do
			if translate = Void then
					-- If we have no translate agent then we call the agent directly.
				l_agent := an_agent
			else
				l_agent := agent translate_and_call (an_agent, translate)
			end

			last_signal_connection_id := {EV_GTK_CALLBACK_MARSHAL}.c_signal_connect (
				a_c_object,
				a_signal_name.item,
				l_agent,
				invoke_after_handler
			)
		end

	last_signal_connection_id: INTEGER
		-- Last signal connection id.

feature -- Agent functions.

	set_focus_event_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for set-focus events
		once
			Result :=
			agent (n: INTEGER; p: POINTER): TUPLE
					-- Converted GtkWidget* to tuple.
				do
					Result := [{EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)]
				end
		end

	configure_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for size allocation events
		once
			Result :=
			agent (n: INTEGER; p: POINTER): TUPLE
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
		end

	size_allocate_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for size allocation events
		once
			Result :=
			agent (n: INTEGER; p: POINTER): TUPLE
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
		end

	expose_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for size allocation events
		once
			Result :=
			agent (n: INTEGER; p: POINTER): TUPLE
				local
					gdk_expose_event: POINTER
					l_rect: POINTER
				do
					gdk_expose_event := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (p)
					l_rect := {EV_GTK_EXTERNALS}.gdk_event_expose_struct_area (gdk_expose_event)
					Result := dimension_tuple (
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (l_rect),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (l_rect),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (l_rect),
						{EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (l_rect)
					)
				end
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
		-- Has `destroy' been called?

feature {EV_APPLICATION_IMP} -- Destruction

	destroy is
			-- Destroy `Current'.
		do
			--c_ev_gtk_callback_marshal_destroy
			is_destroyed := True
		end

feature -- Implementation

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
			l_retry_count: INTEGER
			l_integer_pointer_tuple: like integer_pointer_tuple
			app_imp: EV_APPLICATION_IMP
		do
			if l_retry_count = 0 then
				if n_args > 0 then
					l_integer_pointer_tuple := integer_pointer_tuple
					l_integer_pointer_tuple.integer := n_args
					l_integer_pointer_tuple.pointer := args
				end
				action.call (l_integer_pointer_tuple)
			elseif l_retry_count = 1 then
				app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
				app_imp.on_exception_action (app_imp.new_exception)
			else
				-- An exception has been raised during the exception action so we
				-- exit gracefully.
			end
		rescue
			l_retry_count := l_retry_count + 1
			retry
		end

feature {NONE} -- Tuple optimizations.

	internal_dimension_tuple: TUPLE [x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER] is
			-- Once function used for global access of dimension tuple.
		once
			create Result
		end

	internal_key_tuple: TUPLE [key: EV_KEY; string: STRING_32; key_press: BOOLEAN] is
			-- Once function used for global access of key tuple.
		once
			create Result
		end

	pointer_tuple: TUPLE [pointer: POINTER] is
		once
			create Result
		end

	integer_tuple: TUPLE [integer: INTEGER] is
		once
			create Result
		end

	integer_pointer_tuple: TUPLE [integer: INTEGER; pointer: POINTER] is
		once
			create Result
		end

	gtk_value_pointer_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [pointer: POINTER] is
			-- Tuple containing integer value from first of `args'.
		do
			Result := pointer_tuple
			Result.pointer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
		end

feature {EV_GTK_CALLBACK_MARSHAL} -- Externals

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

feature -- Implementation

	frozen c_ev_gtk_callback_marshal_set_is_enabled (a_enabled_state: BOOLEAN) is
			-- See ev_gtk_callback_marshal.c
		external
			"C signature (int) use %"ev_gtk_callback_marshal.h%""
		end

feature {EV_ANY_IMP, EV_GTK_CALLBACK_MARSHAL} -- Externals

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

