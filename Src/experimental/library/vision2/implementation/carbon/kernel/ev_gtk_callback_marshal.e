note
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

	default_create
			-- Create the dispatcher, one object per system.
		do
			initialize
		end

	initialize
			-- Initialize callbacks
		once
			c_ev_gtk_callback_marshal_init (Current, $marshal)
		end

feature {EV_ANY_IMP} -- Access

	translate_and_call (
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
	)
			-- Call `an_agent' using `translate' to convert `args' and `n_args'
		require
			an_agent_not_void: an_agent /= Void
			translate_not_void: translate /= Void
		do
		end

	dimension_tuple (a_1, a_2, a_3, a_4: INTEGER): like internal_dimension_tuple
			-- Return a dimension tuple from given arguments.
		do
		end

	key_tuple (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN): like internal_key_tuple
			-- Return a key tuple from given arguments.
		do
		end

feature {EV_ANY_IMP, EV_APPLICATION_IMP}

	gdk_event_to_tuple (n_args: INTEGER; args: POINTER): TUPLE
			-- A TUPLE containing `args' data from a GdkEvent.
			-- `n_args' is ignored.
		do
		end

feature {EV_ANY_IMP}

	set_focus_event_translate (n: INTEGER; p: POINTER): TUPLE
			-- Converted GtkWidget* to tuple.
		do
		end

	key_event_translate (n: INTEGER; p: POINTER): TUPLE
			-- Convert GdkEventKey to tuple.
		do
		end

	size_allocate_translate (n: INTEGER; p: POINTER): TUPLE
			-- Convert GtkAllocation to tuple.
		do
		end

	configure_translate (n: INTEGER; p: POINTER): TUPLE
			-- Convert GtkAllocation to tuple.
		do
		end

feature {EV_ANY_IMP} -- Agent implementation routines

	gtk_value_int_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [INTEGER]
			-- Tuple containing integer value from first of `args'.
		do
		end

	column_resize_callback_translate (n: INTEGER; args: POINTER): TUPLE [INTEGER, INTEGER]
			-- Translate function for MCL
		do
		end

	is_destroyed: BOOLEAN

feature {EV_APPLICATION_IMP} -- Destruction

	destroy
			-- Disconnect the
		do
		end

feature {NONE} -- Implementation

	marshal (action: PROCEDURE [ANY, TUPLE]; n_args: INTEGER; args: POINTER)
			-- Call `action' with GTK+ event data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
			-- Called by C function `c_ev_gtk_callback_marshal'.
		require
			action_not_void: action /= Void
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= default_pointer
		do
		end

feature {NONE} -- Tuple optimizations.

	internal_dimension_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			-- Once function used for global access of dimension tuple.
		once
		end

	internal_key_tuple: TUPLE [EV_KEY, STRING_32, BOOLEAN]
			-- Once function used for global access of key tuple.
		once
		end

feature {EV_ANY_IMP} -- Tuple optimizations

	pointer_tuple: TUPLE [POINTER]
			--
		once
		end

	integer_tuple: TUPLE [INTEGER]
		once
		end

	integer_pointer_tuple: TUPLE [INTEGER, POINTER]
		once
		end

	gtk_value_pointer_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [POINTER]
			-- Tuple containing integer value from first of `args'.
		do
		end

feature {NONE} -- Externals

	frozen c_ev_gtk_callback_marshal_init (
		object: EV_GTK_CALLBACK_MARSHAL; a_marshal: POINTER
		)
			-- See ev_gtk_callback_marshal.c
		do
		end

	frozen c_ev_gtk_callback_marshal_destroy
		
			-- See ev_gtk_callback_marshal.c
		do
		end

feature {EV_ANY_IMP} -- Externals

	frozen set_eif_oid_in_c_object (a_c_object: POINTER; eif_oid: INTEGER;
		c_object_dispose_address: POINTER)
				-- Store Eiffel object_id in `gtk_object'.
				-- Set up signal handlers.
		do
		end

	frozen c_signal_connect (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: PROCEDURE [ANY, TUPLE]; invoke_after_handler: BOOLEAN): INTEGER
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		do
		end

	frozen c_signal_connect_true (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: PROCEDURE [ANY, TUPLE]): INTEGER
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		do
		end

feature {EV_APPLICATION_IMP, EV_TIMEOUT_IMP} -- Externals

	frozen c_ev_gtk_callback_marshal_timeout_connect
		(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]): INTEGER
			-- Call `an_agent' after `a_delay'.
		do
		end

note
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

