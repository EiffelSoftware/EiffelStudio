﻿note
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
			is_equal,
			dispose
		end

	EV_INTERMEDIARY_ROUTINES
		undefine
			default_create,
			dispose
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
			debug("gtk_net")
				print (generator + " initialize%N" )
			end

			create marshal_delegate.make (Current, $marshal)

			create free_delegate.make(Current, $free)

			c_ev_gtk_callback_marshal_init (marshal_delegate, free_delegate)
			c_ev_gtk_callback_marshal_set_is_enabled (True)

			dispatcher_object := {GC_HANDLE}.alloc (Current)

			cgtk_set_dispatcher_object ({GC_HANDLE}.to_pointer (dispatcher_object))
		end

feature {NONE} -- Implementation

	dispatcher_object: GC_HANDLE
			-- Handle to Current.

	marshal_delegate: detachable GTK_MARSHAL_DISPATCHER_DELEGATE note option: stable attribute end
			-- Delegate for callbacks.

	free_delegate: detachable WEL_ENUM_WINDOW_DELEGATE note option: stable attribute end
			-- Delegate for callbacks.

	procedure_delegate: detachable EIFFEL_PROCEDURE_DELEGATE

	dispatcher_procedure: detachable GC_HANDLE

	dispose
			-- Wean `Current'
		do
			if attached dispatcher_object as l_handle then
				if l_handle.is_allocated then
					l_handle.free
				end
				cgtk_set_dispatcher_object (default_pointer)
			end
		end


	free (a_pointer: POINTER)
		do
			debug("gtk_net")
				print (generator + ".free%N" )
			end

			if attached {GC_HANDLE}.from_int_ptr (a_pointer) as h then
				h.free
			end
		end

feature {EV_ANY_IMP} -- Access

	dimension_tuple (a_x, a_y, a_width, a_height: INTEGER): like internal_dimension_tuple
			-- Return a dimension tuple from given arguments.
		do
			Result := internal_dimension_tuple
			Result.x := a_x
			Result.y := a_y
			Result.width := a_width
			Result.height := a_height
		end

feature -- Implementation

	signal_connect (
					a_c_object: POINTER;
					a_signal_name: EV_GTK_C_STRING;
					an_agent: ROUTINE;
					invoke_after_handler: BOOLEAN
				)
			-- Signal connect, depending on `invoke_after_handler` invoked before or after default handler.
			-- Notes:
			--		- on connect the agent `an_agent` is eif_adopt-ed by the run-time
			--		- on disconnect the eif_adopt-ed agent `an_agent` is eif_wean-ed by the run-time
			--			and thus can be collected by the GC
		local
			l_agent_hdl: POINTER
		do

				-- How do we convert a ROUTINE to a Pointer.
			dispatcher_procedure :=  {GC_HANDLE}.alloc (an_agent)
			l_agent_hdl := {GC_HANDLE}.to_int_ptr (dispatcher_procedure)

			debug("gtk_net")
				print (generator + ".signal_connect ("+a_c_object.out +"," + a_signal_name.string.out + "," + an_agent.out + " -> "+ l_agent_hdl.out +"," + invoke_after_handler.out + ")%N" )
			end

			last_signal_connection_id := c_signal_connect (a_c_object,
									a_signal_name.item,
									l_agent_hdl,
									invoke_after_handler)

			debug("gtk_net")
				print (generator + ".signal_connect (..): AFTER%N" )
			end

			debug("gtk_signal")
				print (generator + ".signal_connect ("
							+ a_c_object.out +", "
							+ a_signal_name.string.to_string_8 + ", "
							+ if attached an_agent.target as tgt then tgt.generator else "NoTarget" end
							+ " ...,"+ invoke_after_handler.out +") -> "+ last_signal_connection_id.out +"%N")
			end
		end

	signal_connect_after (
					a_c_object: POINTER;
					a_signal_name: EV_GTK_C_STRING;
					an_agent: ROUTINE
				)
			-- Signal connect, invoke after default handler.
		do
			debug("gtk_net")
				print (generator + ".signal_connect_after ("+a_c_object.out +"," + a_signal_name.string.out + "," + an_agent.out + ")%N" )
			end
			signal_connect (a_c_object, a_signal_name, an_agent, True)
		end

	signal_disconnect (a_c_object: POINTER; a_conn_id: INTEGER)
			-- Close connection `a_conn_id` for object `a_c_object`.
			-- Note: the associated Eiffel agent will be "wean" by the run-time
		do
			debug("gtk_net")
				print (generator + ".signal_disconnect ("+a_c_object.out +"," + a_conn_id.out + ")%N" )
			end
			{GTK2}.signal_disconnect (a_c_object, a_conn_id)
		end

	last_signal_connection_id: INTEGER
			-- Last signal connection id.



feature {EV_ANY_IMP} -- Agent implementation routines

	is_destroyed: BOOLEAN
		-- Has `destroy' been called?

feature {EV_APPLICATION_IMP} -- Destruction

	destroy
			-- Destroy `Current'.
		do
			--c_ev_gtk_callback_marshal_destroy
			is_destroyed := True
		end

feature {NONE} -- Implementation

	marshal (action_ptr: POINTER; n_args: INTEGER; args: POINTER; a_return_value: POINTER)
	--marshal (action: ROUTINE; n_args: INTEGER; args: POINTER; a_return_value: POINTER)
			-- Call `action' with GTK+ event data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
			-- Called by C function `c_ev_gtk_callback_marshal'.
		require
			action_not_void: action_ptr /= default_pointer
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= default_pointer
		local
			retry_count: INTEGER
			l_integer_pointer_tuple: detachable like integer_pointer_tuple
			l_pointer_tuple: detachable like pointer_tuple
			l_any: detachable ANY
			b: BOOLEAN
			action: SYSTEM_OBJECT
		do
			debug("gtk_net")
				print ("%N" + generator + ".marshal (" + action_ptr.out+"," + n_args.out + "," + args.out + "," + a_return_value.out + ") <<!>>%N")
				if retry_count > 0 then
					print (generator + ".marshal (..) retry_count=" + retry_count.out + "%N")
				end
			end
			action := if attached {GC_HANDLE}.from_int_ptr (action_ptr) as h then h.target else Void end
			if action = Void then
				debug("gtk_net")
					print (generator +  ".marshal(..) action is not set!%N")
				end
			elseif retry_count = 0 then
				if attached {PROCEDURE [detachable TUPLE [POINTER]]} action as l_action then
					debug("gtk_net")
						print (generator +  ".marshal(..) -> {PROCEDURE [detachable TUPLE [POINTER]]} %N")
						print (generator +  ".marshal(..) -> " + l_action.out + "%N")
					end
					if n_args > 0 then
						l_pointer_tuple := pointer_tuple
						l_pointer_tuple.pointer := args
					end
					b := False
					if l_action.valid_operands (l_pointer_tuple) then
						debug("gtk_net")
							print (generator +  ".marshal(..)  before action.call (arg_1)%N")
						end
						l_action.call (l_pointer_tuple)
					else
						debug("gtk_net")
							print (generator +  ".marshal(..)  cancel action.call due to invalid operands!%N")
						end
					end
				elseif attached {FUNCTION [TUPLE, POINTER]} action as fct then
					debug("gtk_net")
						print (generator +  "{FUNCTION [TUPLE, POINTER]} " )
						print ("%N")
					end

					if n_args > 0 then
						l_pointer_tuple := pointer_tuple
						l_pointer_tuple.pointer := args
					end
					b := False
					if fct.valid_operands (l_pointer_tuple) then
						l_any := fct.item (l_pointer_tuple)
					else
						debug("gtk_net")
							print (generator +  ".marshal(..)  cancel fct.item due to invalid operands!%N")
						end
					end
					if attached {BOOLEAN} l_any as l_bool then
						b := l_bool
					end
				elseif attached {PREDICATE [TUPLE [POINTER]]} action as fct then
					debug("gtk_net")
						print (generator +  ".marshal -> " + fct.generating_type.out)
						print ("%N")
					end

					if n_args > 0 then
						l_pointer_tuple := pointer_tuple
						l_pointer_tuple.pointer := args
					end
					b := False
					if fct.valid_operands (l_pointer_tuple) then
						debug("gtk_net")
							print (generator +  ".marshal(..)  call fct.item with pointer tuple operands%N")
						end
						l_any := fct.item (l_pointer_tuple)
					else
						debug("gtk_net")
							print (generator +  ".marshal(..)  cancel fct.item due to invalid operands!%N")
						end
					end
					if attached {BOOLEAN} l_any as l_bool then
						b := l_bool
					end
				elseif attached {FUNCTION [TUPLE, detachable ANY]} action as fct then
					debug("gtk_net")
						print (generator +  "{FUNCTION [TUPLE, detachable ANY]} " )
						print ("%N")
					end

					if n_args > 0 then
						l_integer_pointer_tuple := Integer_pointer_tuple
						l_integer_pointer_tuple.integer := n_args
						l_integer_pointer_tuple.pointer := args
					end
					b := False
					if fct.valid_operands (l_integer_pointer_tuple) then
						l_any := fct.item (l_integer_pointer_tuple)
					else
						debug("gtk_net")
							print (generator +  ".marshal(..)  cancel fct.item due to invalid operands!%N")
						end
					end
					if attached {BOOLEAN} l_any as l_bool then
						b := l_bool
					end
				else
					debug("gtk_net")
						print (generator + " else condition%N")
					end

					if n_args > 0 then
						l_integer_pointer_tuple := integer_pointer_tuple
						l_integer_pointer_tuple.integer := n_args
						l_integer_pointer_tuple.pointer := args
					end
					b := False
					check not attached {FUNCTION [TUPLE, detachable ANY]} action end
					if attached {PROCEDURE [TUPLE]} action as l_proc_action then
						debug("gtk_net")
							print (generator +  "{PROCEDURE [TUPLE]} " )
							print ("%N")
						end
						if l_proc_action.open_count = 0 then
							l_proc_action.call (Void)
						elseif l_proc_action.valid_operands (l_integer_pointer_tuple) then
							l_proc_action.call (l_integer_pointer_tuple)
						else
							debug("gtk_net")
								print (generator +  ".marshal(..)  cancel proc_action.call due to invalid operands!%N")
							end
						end
					end
				end

				debug("gtk_net")
					print (generator + ".marshal (..) completed%N")
				end
				if a_return_value /= default_pointer then
					{GTK2}.g_value_set_boolean (a_return_value, b) -- TODO: #gtk check if this is ok to return FALSE?
				end

			elseif retry_count = 1 then
				debug("gtk_net")
					print (generator + ".marshal (...) RETRY<1>%N")
				end
				check attached {EV_APPLICATION_IMP} (create {EV_ENVIRONMENT}).implementation.application_i as app_imp then
					app_imp.on_exception_action (app_imp.new_exception)
				end
			end
		rescue
			retry_count := retry_count + 1
			if retry_count = 1 then
					-- Only retry once
				retry
			else
					-- There is an exception from calling `on_exception_action' so we exit gracefully.
				print ("Error: An exception was raised when during handling of a previous exception%N")
			end
		end

feature {NONE} -- Tuple optimizations.

	internal_dimension_tuple: TUPLE [x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER]
			-- Once function used for global access of dimension tuple.
		once
			create Result
		end

	internal_key_tuple: TUPLE [key: EV_KEY; string: STRING_32; key_press: BOOLEAN]
			-- Once function used for global access of key tuple.
		once
			create Result
		end

	pointer_tuple: TUPLE [pointer: POINTER]
		once
			create Result
		end

	integer_tuple: TUPLE [integer: INTEGER]
		once
			create Result
		end

	integer_pointer_tuple: TUPLE [integer: INTEGER; pointer: POINTER]
		once
			create Result
		end

feature {EV_GTK_CALLBACK_MARSHAL} -- Externals

	frozen c_ev_gtk_callback_marshal_init (a_marshal: like marshal_delegate; a_free: like free_delegate)
			-- See ev_gtk_callback_marshal.c
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"c_ev_gtk_callback_marshal_init ((void (*) (EIF_POINTER, EIF_INTEGER, EIF_POINTER, EIF_POINTER)) $a_marshal, (void (*) (EIF_POINTER))$a_free);"
		ensure
			is_class: class
		end

	frozen c_ev_gtk_callback_marshal_destroy
			-- See ev_gtk_callback_marshal.c
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"c_ev_gtk_callback_marshal_destroy()"
		ensure
			is_class: class
		end

feature {NONE} -- Externals

	cgtk_set_dispatcher_object (dispatcher: POINTER)
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"cgtk_set_dispatcher_object($dispatcher)"
		end

	cgtk_release_dispatcher_object
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"cgtk_release_dispatcher_object"
		end

feature -- Implementation

	frozen c_ev_gtk_callback_marshal_is_enabled: BOOLEAN
			-- See ev_gtk_callback_marshal.c
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"(EIF_BOOLEAN) c_ev_gtk_callback_marshal_is_enabled"
		ensure
			is_class: class
		end

	frozen c_ev_gtk_callback_marshal_set_is_enabled (a_enabled_state: BOOLEAN)
			-- See ev_gtk_callback_marshal.c
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"c_ev_gtk_callback_marshal_set_is_enabled((int)$a_enabled_state)"
		ensure
			is_class: class
		end

feature {EV_ANY_IMP} -- Disposal implementation

	frozen on_destroy_event (oid: INTEGER)
			-- Dispose object associated with eif object id `oid`, if any and not yet destroyed.
		do
			debug("gtk_net")
				-- print ("dispose oid="+ oid.out+"..%N")
			end
			if
				oid >= 0 and then
				attached {EV_ANY_IMP} eif_id_object (oid) as obj and then
				not obj.is_destroyed
			then
				obj.c_object_dispose
			end
		end

feature {EV_ANY_IMP, EV_GTK_CALLBACK_MARSHAL} -- Externals

	frozen set_eif_oid_in_c_object (a_c_object: POINTER; eif_oid: INTEGER)
				-- Store Eiffel object_id in `gtk_object'.
				-- Set up signal handlers.
		do
			c_g_object_set_eif_oid_data (a_c_object, eif_oid)
			if {GTK}.gtk_is_tree_view_column (a_c_object) then
				-- Signal destroy is not applicable to object type GtkTreeViewColumn
			else
				signal_connect (a_c_object, {EV_GTK_EVENT_STRINGS}.destroy_event_string, agent on_destroy_event (eif_oid), False)
			end
		end

	frozen c_g_object_set_eif_oid_data (a_gtk_object: POINTER; a_object_id: INTEGER)
			-- Associate GtkObject `a_gtk_object' with object id `a_object_id'
		external
			"C inline use %"ev_gtk.h%""
		alias
			"[
				g_object_set_data (
					G_OBJECT ($a_gtk_object),
					"eif_oid",
					(gpointer) (rt_int_ptr) $a_object_id
				);
			]"
		end

	frozen c_signal_connect (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: POINTER; invoke_after_handler: BOOLEAN): INTEGER
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"c_ev_gtk_callback_marshal_signal_connect((gpointer) $a_c_object, (gchar*) $a_signal_name, (EIF_POINTER) $an_agent, (gboolean) $invoke_after_handler)"
		ensure
			is_class: class
		end

feature {EV_APPLICATION_IMP, EV_TIMEOUT_IMP} -- Externals

	frozen c_ev_gtk_callback_marshal_timeout_connect
		(a_delay: INTEGER; an_agent: POINTER): NATURAL_32
			-- Call `an_agent' after `a_delay'.
		external
			"C inline use <ev_gtk_callback_marshal.h>"
		alias
			"c_ev_gtk_callback_marshal_timeout_connect((gint) $a_delay, (EIF_OBJECT) $an_agent)"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_GTK_CALLBACK_MARSHAL











