indexing
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
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES, EV_ANY_IMP}
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

	set_c_object (a_c_object: POINTER) is
			-- Assign `a_c_object' to `c_object'.
			-- Set up Eiffel GC / GTK cooperation.
			--| (See note at end of class)
		require
			a_c_object_not_null: a_c_object /= NULL
		local
			l_c_object: POINTER
		do
			l_c_object := a_c_object
			if needs_event_box then
				l_c_object := {EV_GTK_EXTERNALS}.gtk_event_box_new
				{EV_GTK_EXTERNALS}.gtk_container_add (l_c_object, a_c_object)
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_c_object)
			end

				-- Remove floating state.
			{EV_GTK_EXTERNALS}.object_ref (l_c_object)
			{EV_GTK_EXTERNALS}.gtk_object_sink (l_c_object)

			debug ("EV_GTK_CREATION")
				print (generator + " created%N")
			end
			{EV_GTK_CALLBACK_MARSHAL}.set_eif_oid_in_c_object (l_c_object, object_id, $c_object_dispose)
			c_object := l_c_object
		ensure
			c_object_coupled: eif_object_from_c (c_object) = Current
		end

	frozen eif_object_from_c (a_c_object: POINTER): EV_ANY_IMP is
			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
		external
			"C inline use %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id ($a_c_object)"
		end

	frozen gtk_is_object (a_c_object: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_IS_OBJECT ($a_c_object)"
		end

feature {EV_ANY, EV_ANY_IMP} -- Implementation

	destroy is
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		do
			set_is_destroyed (True)
				-- Gtk representation of `Current' may only be cleaned up on dispose to prevent crashes where `Current' is
				-- destroyed as a result of `Current's event handler being called, this causes instability within gtk
		end

feature {EV_ANY_I, EV_APPLICATION_IMP} -- Event handling

	signal_connect_true (
		a_signal_name: STRING;
		an_agent: PROCEDURE [ANY, TUPLE]
		) is
			-- Connect `an_agent' to `a_signal_name'.
			-- Use `translate' to convert GTK+ event data to TUPLE.
		require
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		local
			a_cs: EV_GTK_C_STRING
			l_translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
			a_connection_id: INTEGER
		do
			a_cs := a_signal_name
			l_translate := app_implementation.default_translate
			a_connection_id := {EV_GTK_CALLBACK_MARSHAL}.c_signal_connect_true (
				c_object,
				a_cs.item,
				agent (App_implementation.gtk_marshal).translate_and_call (an_agent, l_translate)
			)
		end

	real_signal_connect (
		a_c_object: like c_object;
		a_signal_name: STRING;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
		) is
				-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
		require
			a_c_object_not_void: a_c_object /= NULL
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.string.is_empty
			an_agent_not_void: an_agent /= Void
		do
			signal_connect (a_c_object, app_implementation.c_string_from_eiffel_string (a_signal_name), an_agent, translate, False)
		end

	real_signal_connect_after (
		a_c_object: like c_object;
		a_signal_name: STRING;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE];
		) is
				-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
				-- 'an_agent' called after default gtk signal handler for `a_signal_name'
		require
			a_c_object_not_void: a_c_object /= NULL
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.string.is_empty
			an_agent_not_void: an_agent /= Void
		do
			signal_connect (a_c_object, app_implementation.c_string_from_eiffel_string (a_signal_name), an_agent, translate, True)
		end

	signal_connect (
		a_c_object: like c_object;
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
				l_agent := agent (App_implementation.gtk_marshal).translate_and_call (an_agent, translate)
			end

			last_signal_connection_id := {EV_GTK_CALLBACK_MARSHAL}.c_signal_connect (
				a_c_object,
				a_signal_name.item,
				l_agent,
				invoke_after_handler
			)
		end

	last_signal_connection_id: INTEGER
			-- GTK signal connection id of the most recent `signal_connect'.

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN is
			-- Does `event_widget' need an event box to receive events?
		do
			Result := False
		end

	dispose is
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
		local
			l_c_object: POINTER
		do
			if not is_in_final_collect then
				l_c_object := c_object
				if l_c_object /= NULL then
						-- Disconnect dispose signal for `c_object'.
					{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect_by_data (l_c_object, internal_id)
						-- Unref `c_object' so that is may get collected by gtk.
					if {EV_GTK_EXTERNALS}.gtk_is_window (l_c_object) then
							-- Windows need to be explicitly destroyed.
						{EV_GTK_DEPENDENT_EXTERNALS}.object_destroy (l_c_object)
					end
					{EV_GTK_DEPENDENT_EXTERNALS}.object_unref (l_c_object)
				end
			end
			Precursor {IDENTIFIED}
		end

	c_object_dispose is
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		do
				-- The object has been marked for destruction from its parent so we unref
				-- so that gtk will reap back the memory.
			{EV_GTK_DEPENDENT_EXTERNALS}.object_unref (c_object)
			c_object := NULL
			set_is_destroyed (True)
		ensure
			is_destroyed_set: is_destroyed
			c_object_detached: c_object = NULL
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	process_gdk_event (n_args: INTEGER; args: POINTER) is
			-- Process any incoming gdk event.
		do
			-- Redefined by descendents.
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Access

	visual_widget: POINTER is
			-- Pointer to the widget viewed by user.
		do
			if needs_event_box then
				Result := {EV_GTK_EXTERNALS}.gtk_bin_struct_child (c_object)
			else
				Result := c_object
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

	App_implementation: EV_APPLICATION_IMP is
			--
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result ?= env.application.implementation
			check
				Result_not_void: Result /= Void
			end
		end

feature -- Measurement

	NULL: POINTER is
		external
			"C [macro <stdio.h>]"
		alias
			"NULL"
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




end -- class EV_ANY_IMP

