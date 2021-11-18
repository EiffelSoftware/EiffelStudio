note
	description: "[
			Base class for GTK implementation (_IMP) classes.
			Handles interaction between Eiffel objects and GTK objects
			See important notes on memory management at end of class
		]"
	legal: "See notice at end of class."
	keywords: "implementation, gtk, any, base"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ANY_IMP

inherit
	EV_ANY_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES, EV_ANY_I}
				is_destroyed
		end

	IDENTIFIED
		undefine
			is_equal,
			copy
		redefine
			dispose
		end

feature {EV_ANY_I} -- Access

	c_object: POINTER
			-- C pointer to an object conforming to GtkWidget.

	c_object_was_floating: BOOLEAN

feature {EV_ANY_I} -- Access

	set_c_object (a_c_object: POINTER)
			-- Assign `a_c_object' to `c_object'.
			-- Set up Eiffel GC / GTK cooperation.
			--| (See note at end of class)
		require
			a_c_object_not_null: a_c_object /= default_pointer
		local
			l_c_object: POINTER
		do
			if needs_event_box then
				l_c_object := {GTK}.gtk_event_box_new -- Floating ref
				l_c_object := {GTK}.g_object_ref_sink (l_c_object) -- Adopt floating ref count

				{GTK}.gtk_container_add (l_c_object, a_c_object) -- Adopt `a_c_object` floating ref, or add ref if a_c_object was not floating.
				{GTK}.gtk_widget_show (a_c_object)
			else
				if {GDK}.g_object_is_floating (a_c_object) then
					c_object_was_floating := True
						-- Adopt floating ref count, or increase ref count
					l_c_object := {GTK}.g_object_ref_sink (a_c_object)
				else
					check
						is_gtk_top_window: {GTK}.gtk_is_widget (a_c_object) and then
											{GTK}.gtk_widget_is_toplevel (a_c_object)
					end
					l_c_object := a_c_object -- Already has a ref
					l_c_object := {GTK}.g_object_ref (l_c_object) -- Increase ref count to protect the marshal callback
				end
			end

			debug ("EV_GTK_CREATION")
				print (generator + " created%N")
			end
			if internal_id = 0 then
				internal_id := eif_current_object_id
			end
			{EV_GTK_CALLBACK_MARSHAL}.set_eif_oid_in_c_object (l_c_object, internal_id, $c_object_dispose) -- No ref count increase from the C code, handled by the previous line

			c_object := l_c_object
			if
				{GTK}.gtk_is_widget (l_c_object) and then
				{GTK}.gtk_widget_is_toplevel (l_c_object)
			then
				if {GDK}.internal_g_object_ref_count (l_c_object) /= 2 then
					check unexpected_ref_count: False end
					{GDK}.printf (generator + ".set_c_object: unexpected ref count for c_object=" + l_c_object.out + " #" + {GDK}.internal_g_object_ref_count (l_c_object).out + " /= 2 !%N")
				end
			elseif {GDK}.internal_g_object_ref_count (l_c_object) /= 1 then
				check unexpected_ref_count: False end
				{GDK}.printf (generator + ".set_c_object: unexpected ref count for c_object=" + l_c_object.out + " #" + {GDK}.internal_g_object_ref_count (l_c_object).out + " /= 1 !%N")
			end

			debug ("gtk_name")
				update_gtk_name
			end
		end

	update_gtk_name
		local
			s: STRING_32
		do
			debug ("gtk_name")
				if
					not c_object.is_default_pointer and then
					{GTK}.gtk_is_widget (c_object) -- gtk_widget_set_name requires a GtkWidget
				then
					if attached interface as l_interface then
						if attached {EV_IDENTIFIABLE} l_interface as l_id and then l_id.has_identifier_name_set  then
							create s.make_from_string_general (l_id.identifier_name)
							s.prepend_character ('%"')
							s.append_character ('%"')
						else
							create s.make_empty
						end
						s.append_string_general (l_interface.generator)
					else
						create s.make_from_string_general (generating_type.name_32)
					end
					s.append_string_general ("-" + internal_id.out)
					{GTK}.gtk_widget_set_name (c_object, (create {EV_GTK_C_STRING}.set_with_eiffel_string (s)).item)
				end
			end
		end

	frozen eif_object_from_c (a_c_object: POINTER): detachable EV_ANY_IMP
			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
		external
			"C inline use <ev_any_imp.h>"
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id ($a_c_object)"
		ensure
			is_class: class
		end

feature {EV_ANY, EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		local
			l_c_object: like c_object
		do
			disconnect_all_recorded_connections (default_pointer)

			-- Gtk representation of `Current' may only be cleaned up on dispose to prevent crashes where `Current' is
			-- destroyed as a result of `Current's event handler being called, this causes instability within gtk
			-- TODO: check the previous comment

			l_c_object := c_object
			if
				not l_c_object.is_default_pointer and then
				{GTK}.gtk_is_widget (l_c_object) -- gtk_widget_* requires a GtkWidget
			then
					-- The call to `gtk_widget_destroy` should trigger the `c_object_dispose`
					-- See the `set_c_object` code, and the related C code (in ev_any_imp.c) .
				if {GTK}.gtk_widget_is_toplevel (l_c_object) then
						-- TODO: check if the following line could cause trouble
					if {GTK}.gtk_is_window (l_c_object) then
							-- Do not call gtk_widget_destroy, as the causes troubles when the app receives remaining events
							-- related to this window.
							-- Let the `dispose` do the job.
					else
						check should_not_occur: False end
						{GTK}.gtk_widget_destroy (l_c_object)
					end
				else
					{GTK}.gtk_widget_destroy (l_c_object)
				end
			end
			set_is_destroyed (True)
		end

feature {EV_ANY_I, EV_APPLICATION_IMP} -- Event handling

	real_signal_connect (
		a_c_object: like c_object;
		a_signal_name: STRING_8;
		an_agent: ROUTINE)
				-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
		require
			a_c_object_not_void: not a_c_object.is_default_pointer
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (a_c_object, a_signal_name, an_agent, False)
			record_signal_connection (a_c_object, a_signal_name, l_app_imp.gtk_marshal.last_signal_connection_id)
		end

	real_signal_connect_after (
		a_c_object: like c_object;
		a_signal_name: STRING_8;
		an_agent: ROUTINE)
				-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
				-- 'an_agent' called after default gtk signal handler for `a_signal_name'
		require
			a_c_object_not_void: not a_c_object.is_default_pointer
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (a_c_object, l_app_imp.c_string_from_eiffel_string (a_signal_name), an_agent, True)
			record_signal_connection (a_c_object, a_signal_name, l_app_imp.gtk_marshal.last_signal_connection_id)
		end

	real_signal_disconnect (a_c_object: like c_object; a_conn_id: INTEGER)
		require
			a_c_object_not_void: not a_c_object.is_default_pointer
			a_conn_id > 0
		local
			l_app_imp: EV_APPLICATION_IMP
			conn: like signal_connections.item
		do
			debug ("gtk_signal")
				print (generator + ": calling signal_disconnect (" + a_c_object.out + ", " + a_conn_id.out + ")%N")
			end
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_disconnect (a_c_object, a_conn_id)
			if attached signal_connections as conn_lst then
				from
					conn_lst.start
				until
					conn_lst.off
				loop
					conn := conn_lst.item
					if
						conn.c_object = a_c_object and
						conn.connection_id = a_conn_id
					then
						conn_lst.remove
					else
						conn_lst.forth
					end
				end
			end
		end

	last_signal_connection_id: INTEGER
			-- GTK signal connection id of the most recent `signal_connect'.
		do
			Result := app_implementation.gtk_marshal.last_signal_connection_id
		end

	last_signal_connection: detachable GTK_SIGNAL_MARSHAL_CONNECTION
		do
			if attached signal_connections as l_connections then
				Result := l_connections.last
			end
		end

	record_signal_connection (a_c_object: POINTER; a_signal_name: READABLE_STRING_8; a_connection_id: like last_signal_connection_id)
		local
			lst: like signal_connections
		do
			if a_connection_id > 0 then
				lst := signal_connections
				if lst = Void then
					create {ARRAYED_LIST [like signal_connections.item]} lst.make (1)
					signal_connections := lst
				end
				lst.force (create {GTK_SIGNAL_MARSHAL_CONNECTION}.make (a_c_object, a_connection_id))
			end
		end

	disconnect_all_recorded_connections (a_c_object: POINTER)
		do
			if attached signal_connections as l_connections then
				debug ("gtk_signal")
					print (generator + ".disconnect_all_recorded_connections (...) -> count = " + l_connections.count.out + "%N")
				end
				from
					l_connections.start
				until
					l_connections.off
				loop
					if
						attached l_connections.item as conn and then
						conn.is_connected
					then
						if
							a_c_object.is_default_pointer -- Any target C object
							or else conn.c_object = a_c_object -- Matched the `a_c_object` argument.
						then
							conn.close
							l_connections.remove
						else
							l_connections.forth
						end
					else
						l_connections.remove
					end
				end
				if l_connections.is_empty then
					signal_connections := Void
				else
					do_nothing
				end
			end
		end

	signal_connections: detachable LIST [GTK_SIGNAL_MARSHAL_CONNECTION]
			-- Signal name and Connection id indexed by c_object pointer.

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN
			-- Does `event_widget' need an event box to receive events?
		do
			Result := False
		end

	c_object_dispose_called: BOOLEAN

	dispose
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
		local
			l_c_object: like c_object
		do
			l_c_object := c_object
			if
				not l_c_object.is_default_pointer and then
				{GTK}.gtk_is_widget (l_c_object) -- note: gtk_widget_* requires a GtkWidget
			then
					-- The next call should trigger the `c_object_dispose`
					-- See the `set_c_object` code, and the related C code (in ev_any_imp.c) .
				if {GTK}.gtk_widget_is_toplevel (l_c_object) then
						-- TODO: check if this is fully safe.
					{GTK}.gtk_widget_destroy (l_c_object)
				else
					{GTK}.gtk_widget_destroy (l_c_object)
				end
			end
			Precursor {IDENTIFIED}
		end

	c_object_dispose
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		local
			l_c_object: POINTER
			l_c_ev_gtk_callback_marshal_is_enabled: BOOLEAN
		do
			if not c_object_dispose_called then
				c_object_dispose_called := True

					-- Disable the marshaller so we do not get C to Eiffel calls
					-- during GC cycle otherwise bad things may happen.
				l_c_ev_gtk_callback_marshal_is_enabled := {EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_is_enabled
				{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (False)

					-- Note: in the case of `needs_event_box`, no need to unref the `visual_widget`
					--		  as its floating ref was adopted by the EventBox container

					-- The object has been marked for destruction from its parent so we unref
					-- so that gtk will reap back the memory.
				l_c_object := c_object
				if not l_c_object.is_default_pointer then

						-- TODO Review
						-- Remove any reference l_c_object may have on other Gtk objects.

						-- disconnect_all_signals (l_c_object)
					if {GTK}.gtk_is_window (l_c_object) then
							-- Windows need to be explicitly destroyed.
						{GTK2}.gtk_widget_destroy (l_c_object)
					elseif {GTK}.gtk_is_widget (l_c_object)  then
							-- Should not be needed, but do it anyway, it destroys reference on other resources
						{GTK2}.gtk_widget_destroy (l_c_object)
					else
							-- the run dispose is usually called by gtk_widget_destroy.
						{GDK}.g_object_run_dispose (l_c_object)
					end

						-- Decrement the reference count for `l_c_object` (should correspond to the reference used to protect the marshal callback  see `set_c_object`)
					debug ("gtk_memory")
						{GDK}.printf (generator + ".c_object_dispose before final unref " + l_c_object.out + " #" + {GDK}.internal_g_object_ref_count (l_c_object).out + " .%N")
					end
					{GDK}.g_object_unref (l_c_object)

					c_object := default_pointer
				end
				set_is_destroyed (True)

					-- Restore marshaller.
				{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (l_c_ev_gtk_callback_marshal_is_enabled)
			end
		ensure
			is_destroyed_set: is_destroyed
			c_object_detached: c_object = default_pointer
			c_object_dispose_called: c_object_dispose_called
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES, EV_APPLICATION_I} -- Implementation

	process_draw_event (a_cairo_context: POINTER): BOOLEAN
			-- A "draw" signal has occurred
			-- Result:
			-- 		False: execute remaining processing (including default)
			--		True: stop all processing
		do
			-- Redefined by descendents.
		ensure
			same_ref_count: {CAIRO}.get_reference_count (a_cairo_context) = old ({CAIRO}.get_reference_count (a_cairo_context))
		end

	process_gdk_event (n_args: INTEGER; args: POINTER)
			-- Process any incoming gdk event.
		do
			-- Redefined by descendents.
		end

	process_configure_event (a_x, a_y, a_width, a_height: INTEGER): BOOLEAN
			-- "configure-event" signal occurred
			-- Result:
			-- 		False: execute remaining processing (including default)
			--		True: stop all processing
		do
			-- Redefined by descendents.
		end

	process_enter_event (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- "enter-notify-event" signal occurred
		do
			-- Redefined by descendents.
		end

	process_leave_event (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- "leave-notify-event" signal occurred
		do
			-- Redefined by descendents.
		end

	process_button_event (a_gdk_event: POINTER; a_recursive: BOOLEAN)
			-- "button-press-event", "button-release-event", ... signal occurred
		do
			-- Redefined by descendents.
		end

	process_motion_notify_event (a_gdk_event: POINTER)
			-- "motion-notify-event" signal occurred
		do
			-- Redefined by descendents.
		end

	process_scroll_event (a_gdk_event: POINTER): BOOLEAN
			-- "scroll-event" signal occurred
			-- Result
			--       TRUE to stop other handlers from being invoked for the event.
			--		 FALSE to propagate the event further.
		do
			-- Redefined by descendents.
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Access

	visual_widget: POINTER
			-- Pointer to the widget viewed by user.
		do
			if needs_event_box then
				Result := {GTK}.gtk_bin_get_child (c_object)
			else
				Result := c_object
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

	App_implementation: EV_APPLICATION_IMP
			--
		local
			env: EV_ENVIRONMENT
		once
			create env
			check attached {EV_APPLICATION_IMP} env.implementation.application_i as l_app_imp then
				Result := l_app_imp
			end
		end

invariant

	has_c_object: not is_destroyed implies not c_object.is_default_pointer

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
