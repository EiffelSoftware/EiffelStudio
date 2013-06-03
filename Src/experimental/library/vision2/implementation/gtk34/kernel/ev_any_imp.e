note
	description:
		"Base class for GTK implementation (_IMP) classes. %N%
		%Handles interaction between Eiffel objects and GTK objects %N%
		%See important notes on memory management at end of class"
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
				l_c_object := {GTK}.gtk_event_box_new
				{GTK}.gtk_container_add (l_c_object, a_c_object)
				{GTK}.gtk_widget_show (a_c_object)
			else
				l_c_object := a_c_object
			end

				-- Remove floating state.
			l_c_object := {GTK2}.g_object_ref (l_c_object)
			l_c_object := {GTK}.g_object_ref_sink (l_c_object)

			debug ("EV_GTK_CREATION")
				print (generator + " created%N")
			end
			if internal_id = 0 then
				internal_id := eif_current_object_id
			end
			{EV_GTK_CALLBACK_MARSHAL}.set_eif_oid_in_c_object (l_c_object, internal_id, $c_object_dispose)
			c_object := l_c_object
		end

	frozen eif_object_from_c (a_c_object: POINTER): detachable EV_ANY_IMP
			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
		external
			"C inline use %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id ($a_c_object)"
		end

feature {EV_ANY, EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		do
			set_is_destroyed (True)
				-- Gtk representation of `Current' may only be cleaned up on dispose to prevent crashes where `Current' is
				-- destroyed as a result of `Current's event handler being called, this causes instability within gtk
		end

feature {EV_ANY_I, EV_APPLICATION_IMP} -- Event handling

	real_signal_connect (
		a_c_object: like c_object;
		a_signal_name: STRING_8;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: detachable FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
		)
				-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
		require
			a_c_object_not_void: a_c_object /= default_pointer
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (a_c_object, a_signal_name, an_agent, translate, False)
		end

	real_signal_connect_after (
		a_c_object: like c_object;
		a_signal_name: STRING_8;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: detachable FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
		)
				-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
				-- 'an_agent' called after default gtk signal handler for `a_signal_name'
		require
			a_c_object_not_void: a_c_object /= default_pointer
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (a_c_object, l_app_imp.c_string_from_eiffel_string (a_signal_name), an_agent, translate, True)
		end

	last_signal_connection_id: INTEGER
			-- GTK signal connection id of the most recent `signal_connect'.
		do
			Result := app_implementation.gtk_marshal.last_signal_connection_id
		end

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN
			-- Does `event_widget' need an event box to receive events?
		do
			Result := False
		end

	dispose
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
		local
			l_c_object, l_null: POINTER
		do
				-- Disable the marshaller so we do not get C to Eiffel calls
				-- during GC cycle otherwise bad things may happen.
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (False)
			l_c_object := c_object
			if l_c_object /= l_null then
					-- Disconnect dispose signal for `c_object'.
				{GTK2}.signal_disconnect_by_data (l_c_object, internal_id)
					-- Unref `c_object' so that is may get collected by gtk.
				if {GTK}.gtk_is_window (l_c_object) then
						-- Windows need to be explicitly destroyed.
					{GTK2}.gtk_widget_destroy (l_c_object)
				end
				{GTK2}.g_object_unref (l_c_object)
			end
			Precursor {IDENTIFIED}

				-- Renable marshaller.
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (True)
		end

	c_object_dispose
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		local
			l_null: POINTER
		do
				-- Disable the marshaller so we do not get C to Eiffel calls
				-- during GC cycle otherwise bad things may happen.
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (False)

				-- The object has been marked for destruction from its parent so we unref
				-- so that gtk will reap back the memory.
			{GTK2}.g_object_unref (c_object)
			c_object := l_null
			set_is_destroyed (True)

				-- Renable marshaller.
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (True)
		ensure
			is_destroyed_set: is_destroyed
			c_object_detached: c_object = default_pointer
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	process_draw_event (a_cairo_context: POINTER)
			-- A "draw" signal has occurred
		do
			-- Redefined by descendents.
		end

	process_gdk_event (n_args: INTEGER; args: POINTER)
			-- Process any incoming gdk event.
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

	eif_current_object_id: INTEGER
			-- New identifier for Current
		obsolete
			"Use `eif_object_id (Current)' instead."
		external
			"built_in"
		ensure
			eif_current_object_id: Result > 0
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

	App_implementation: EV_APPLICATION_IMP
			--
		local
			env: EV_ENVIRONMENT
			l_app_imp: detachable EV_APPLICATION_IMP
		once
			create env
			l_app_imp ?= env.implementation.application_i
			check l_app_imp /= Void then end
			Result := l_app_imp
		end

feature -- Measurement

	NULL: POINTER
		external
			"C [macro <stdio.h>]"
		alias
			"NULL"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_ANY_IMP











