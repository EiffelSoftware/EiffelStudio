indexing
	description:
		"Base class for GTK implementation (_IMP) classes. %N%
		%Handles interaction between Eiffel objects and GTK objects %N%
		%See important notes on memory management at end of class"
	keywords: "implementation, gtk, any, base"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ANY_IMP

inherit
	EV_ANY_I

	IDENTIFIED
		undefine
			is_equal,
			copy
		redefine
			dispose
		end

	EV_C_UTIL

--	GTK_ENUMS

--	EV_GTK_KEY_CONVERSION
--| Removed for implementation reasons regarding executable size

	INTERNAL

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
		do
			c_object := a_c_object
			debug ("EV_GTK_CREATION")
				print (generator + " created%N")
			--	print (generator + ".set_c_object new eif_object "
			--		+ out.substring (1, out.index_of ('%N', 1) - 1)
			--		+ " and new c_object " + c_object.out  +
			--		" and new eif_oid " + object_id.out + "%N")
			end
			set_eif_oid_in_c_object (c_object, object_id, $c_object_dispose)
		ensure
			c_object_assigned: c_object = a_c_object
		end

	eif_object_from_c (a_c_object: POINTER): EV_ANY_IMP is
			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
		require
			a_c_object_not_null: a_c_object /= NULL
		do
			Result := c_get_eif_reference_from_object_id (a_c_object)
		end

feature {EV_ANY, EV_ANY_IMP} -- Command

	disconnect_all_signals is
		local
			i, l: INTEGER
		do
			l := signal_ids.count
			from
				i := 1
			until
				i > l
			loop
				C.gtk_signal_disconnect (c_object, signal_ids.i_th (i))
				i := i + 1
			end
		end

	destroy is
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		local
			i, l: INTEGER
		do
			debug ("EV_GTK_DESTROY")
				safe_print (generator + ".destroy")
			end
			l := action_sequences.count
			from i := 1 until i > l loop
				action_sequences.i_th (i).block
				i := i + 1
			end
			is_destroyed := True
			disconnect_all_signals
			if C.gtk_is_window (c_object) then
				C.gtk_object_destroy (c_object)
			else
				C.gtk_object_unref (c_object)
			end	
			c_object := NULL
		ensure then
			c_object_detached: c_object = NULL
		end

feature {EV_ANY_I} -- Event handling

	signal_connect (
		a_signal_name: STRING;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE]
		) is
			-- Connect `an_agent' to `a_signal_name'.
			-- Use `translate' to convert GTK+ event data to TUPLE.
		require
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		do
			real_signal_connect (visual_widget, a_signal_name, an_agent, translate)
		ensure
			signal_connection_id_positive: last_signal_connection_id > 0
		end

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
			a_connection_id: INTEGER
			temp_string: ANY
		do
			temp_string := a_signal_name.to_c
			a_connection_id := c_signal_connect_true (
				c_object,
				$temp_string,
				an_agent
			)
			signal_ids.extend (a_connection_id)
		end

	real_signal_connect (
		a_c_object: like c_object;
		a_signal_name: STRING;
		an_agent: PROCEDURE [ANY, TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE]
		) is
			-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
			-- Use `translate' to convert GTK+ event data to TUPLE.
		require
			a_c_object_not_void: a_c_object /= NULL
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_agent_not_void: an_agent /= Void
		local
			a_sig_temp: ANY
		do
			a_sig_temp := a_signal_name.to_c
			if translate /= Void then
				last_signal_connection_id := c_signal_connect (
					a_c_object,
					$a_sig_temp,
					agent gtk_marshal.translate_and_call (an_agent, translate, ?, ?)
				)
			else
				last_signal_connection_id := c_signal_connect (
					a_c_object,
					$a_sig_temp,
					an_agent
				)
			end
			signal_ids.extend (last_signal_connection_id)
		ensure
			signal_connection_id_positive: last_signal_connection_id > 0
		end
	
	signal_ids: ARRAYED_LIST [INTEGER] is
			-- Ids of GTK signal connections.
		do
			if opo_signal_ids = Void then
				create opo_signal_ids.make (2)
			end
			Result := opo_signal_ids
		ensure
			Result /= Void
		end

	opo_signal_ids: ARRAYED_LIST [INTEGER]
			-- Once per object for implementation for `signal_ids'.
	
	action_sequences: ARRAYED_LIST [ACTION_SEQUENCE [TUPLE]] is
			-- Action sequences connected to GTK signals.
		do
			if opo_action_sequences = Void then
				create opo_action_sequences.make (2)
			end
			Result := opo_action_sequences
		ensure
			Result /= Void
		end

	opo_action_sequences: ARRAYED_LIST [ACTION_SEQUENCE [TUPLE]]
			-- Once per object for implementation for `action_sequences'.

	last_signal_connection_id: INTEGER
			-- GTK signal connection id of the most recent `signal_connect'.

	signal_disconnect (a_connection_id: INTEGER) is
			-- Disconnect signal connection with `a_connection_id'.
		require
			a_connection_id_positive: a_connection_id > 0
		do
			C.gtk_signal_disconnect (visual_widget, a_connection_id)
			signal_ids.prune_all (a_connection_id)
		end

	connect_signal_to_actions (
		a_signal_name: STRING;
		an_action_sequence: ACTION_SEQUENCE [TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE]
		) is
			-- Connect `a_signal_name' to `an_action_sequence'.
			-- Use `translate' to convert GTK+ event data to TUPLE.
		require
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_action_sequence_not_void: an_action_sequence /= Void
		do
			real_connect_signal_to_actions (
				visual_widget,
				a_signal_name,
				an_action_sequence,
				translate
			)
		end

	real_connect_signal_to_actions (
		a_c_object: POINTER;
		a_signal_name: STRING;
		an_action_sequence: ACTION_SEQUENCE [TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE]
		) is
			-- Connect `a_signal_name' for `a_c_object' to `an_action_sequence'.
			-- Use `translate' to convert GTK+ event data to TUPLE.
			-- Connection delayed until `an_actions_sequence' is not empty.
		require
			a_c_object_not_void: a_c_object /= NULL
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.is_empty
			an_action_sequence_not_void: an_action_sequence /= Void
		do
			an_action_sequence.not_empty_actions.extend (
				agent connect_signal_to_actions_now (
					a_c_object,
					a_signal_name,
					an_action_sequence,
					translate
				)
			)
			if not an_action_sequence.is_empty then
				connect_signal_to_actions_now (
					a_c_object,
					a_signal_name,
					an_action_sequence,
					translate
				)
			end
			action_sequences.extend (an_action_sequence)
		end

	connect_signal_to_actions_now (
		a_c_object: POINTER;
		a_signal_name: STRING;
		an_action_sequence: ACTION_SEQUENCE [TUPLE];
		translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE]
		) is
			-- Connect `a_signal_name' for `a_c_object' to `an_action_sequence'.
			-- Use `translate' to convert GTK+ event data to TUPLE.
		local
			disconnect_agent: PROCEDURE [ANY, TUPLE []]
		do
			real_signal_connect (
				a_c_object,
				a_signal_name,
				agent an_action_sequence.call (?),
				translate
			)
			disconnect_agent := agent gtk_marshal.signal_disconnect_agent_routine (visual_widget, last_signal_connection_id, signal_ids)
			an_action_sequence.empty_actions.extend (disconnect_agent)
			an_action_sequence.empty_actions.extend (
				gtk_marshal.kamikaze_agent (an_action_sequence.empty_actions, disconnect_agent)
			)
		end

	default_translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE] is		
		once
			Result := agent gtk_marshal.gdk_event_to_tuple
		end
		
feature {NONE} -- Implementation

	dispose is
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
			--| Use the localy gtk_object_unref defined below to avoid making
			--| a dot call to C.gtk_object_unref which is not allowed here.
			--| Same for gtk_signal_disconnect_by_data.
		do
			-- FIXME this may not be safe!
			debug ("EV_GTK_DISPOSE")
				safe_print (generator + ".dispose")
			end
			if c_object /= NULL then
				-- Destroy has been explicitly called.
				gtk_signal_disconnect_by_data (c_object, object_id)
					--| This is the signal attached in ev_any_imp.c
					--| used for GC/Ref-Counting interaction.
				gtk_object_unref (c_object)
			end
			Precursor {IDENTIFIED}
		end

	c_object_dispose is
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		do
			debug ("EV_GTK_C_OBJECT_DISPOSE")
				safe_print (generator + ".c_object_dispose")
			end
			c_object := NULL
			is_destroyed := True
		ensure
			is_destroyed_set: is_destroyed
			c_object_detached: c_object = NULL
		end

	visual_widget: POINTER is
			-- Pointer to the widget viewed by user.
		do
			Result := c_object
		end

	default_gtk_window: POINTER is
			-- Pointer to a default GtkWindow.
		once
			Result := default_window_imp.c_object
		end

	default_gdk_window: POINTER is
			-- Pointer to a default GdkWindow that may be used to
			-- access default visual information (color depth).
		do
			Result := C.gtk_widget_struct_window (default_gtk_window)
		end
		
	default_window: EV_WINDOW is
			-- Default Window used for creation of agents and holder of clipboard widget.
		once
			create Result
		end
		
	default_window_imp: EV_WINDOW_IMP is
			--
		once
			Result ?= default_window.implementation
		end
	
	app_implementation: EV_APPLICATION_IMP is
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
		
	gtk_marshal: EV_GTK_CALLBACK_MARSHAL is
			-- 
		once
			create Result
		end
		
	empty_tuple: TUPLE is
		once
			Result := []
		end

feature {NONE} -- External implementation

	set_eif_oid_in_c_object (a_c_object: POINTER; eif_oid: INTEGER;
		c_object_dispose_address: POINTER) is
				-- Store Eiffel object_id in `gtk_object'.
				-- Set up signal handlers.
		external
			"C (GtkWidget*, int, void*) | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_set_eif_oid_in_c_object"
		end

	c_get_eif_reference_from_object_id (a_c_object: POINTER): EV_ANY_IMP is
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		end

	c_invariant (a_c_object: POINTER): BOOLEAN is
			-- External invariant implementation
		external
			"C (GtkWidget*): gboolean | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_invariant"
		end

	c_signal_connect (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		external
			"C (GtkObject*, gchar*, EIF_OBJECT): guint | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_signal_connect"
		end

	c_signal_connect_true (a_c_object: POINTER; a_signal_name: POINTER;
		an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Connect `an_agent' to 'a_signal_name' on `a_c_object'.
		external
			"C (GtkObject*, gchar*, EIF_OBJECT): guint | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_signal_connect_true"
		end

	gtk_object_destroy (a_c_object: POINTER) is
			-- Only for use in dispose.
			-- (Dispose cannot call C.gtk_object_destroy)
        	external
            		"C (GtkObject*) | <gtk/gtk.h>"
        	end

	gtk_object_unref (a_c_object: POINTER) is
			-- Only for use in dispose.
			-- (Dispose cannot call C.gtk_object_destroy)
        	external
            		"C (GtkObject*) | <gtk/gtk.h>"
        	end

	gtk_signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER) is
			-- Only for use in dispose.
			-- (Dispose cannot call C.gtk_signal_disconnect_by_data)
        	external
            		"C (GtkObject*, gpointer) | <gtk/gtk.h>"
        	end

invariant
	c_invariant: c_object /= NULL implies c_invariant (c_object)
	c_object_coupled: c_object /= NULL implies
		eif_object_from_c (c_object) = Current
	c_externals_object_not_void: C /= Void

indexing
	description: "[
	 Scheme for Eiffel GC / GTK RC cooperation (with a twist).
	
	 See diagram: ev_any_imp.fig
	 
	 This describes the interaction between the ISE garbage collector[1] (GC) and
	 the GTK+ reference counter[3] (RC). Eiffel objects get collected some time
	 after they are no longer reachable from the root Eiffel object. GTK objects
	 are destroyed right after their reference count drops to zero.
	
	 Eiffel objects have a `dispose' feature that is called when they are reaped.
	 GTK objects have a "destroy" signal that is emitted when they are destroyed.
	
	 A "widget" in Vision is actual a pair of objects one Eiffel, one GTK.
	 Henceforth:
	     EIF object: refers to an Eiffel object that corresponds to a GTK object.
	     GTK object: refers to a GtkWidget that corresponds to an EIF object.
	
	 The principle is that a GTK object and the corresponding EIF object are
	 tightly coupled and that such couples are handled by both memory management
	 systems. Thats is, if the couple is reachable from either Eiffel or C it
	 is considered alive, only if it is reachable from neither is it reaped.
	 (Note that due to the mark & sweep GC in ISE Eiffel reachable /= referenced)
	 If one member of the couple is explicitly destroyed the other must also die.
	 At any point in time the couple must be under the control of only one memory
	 management system (Eiffel GC or GTK RC). To put it under the control of one,
	 we simply make an extra reference to it from the other.
	 
	 The execution goes something like this:
	 
	 When the widget is parented, it's destiny is controlled by GTK.
	     The GTK object makes an Eiffel reference on the EIF object to save it
	     from the Eiffel GC. An EIF_OBJECT[5] is stored in the GTK object data
	     payload with eif_wean as the destroy notify function.
	     (gtk_object_set_data_full[4] allows arbitrary data to be stored.)
	     If we previously incremented the GTK object reference count we decrement
	     it (see below) so that it is destroyed if all other references are lost.
	
	 When the widget is unparented, it's destiny is controlled by the EIFFEL GC.
	     The EIF object increments the GTK object reference count to save it
	     from the GTK RC. An entry is made in the GTK object data payload to note
	     that we made an extra reference.
	     The EIF_OBJECT in the GTK object data payload is removed, this causes
	     eif_wean to release it's reference so that if there are no other Eiffel
	     references to it, it is destroyed.
	
	 Toplevel widgets like Windows are considered to be not parentable, that is,
	 they are always at the mercy of the Eiffel GC.
	 
	 `c_object_dispose' is connected to the GTK object "destroy" signal and marks
	  the Eiffel object as `is_destroyed'.
	 
	 `dispose' destroys the GTK object if the Eiffel object is collected.
	 
	 The user may also explicitly call `destroy', this destroys the GTK object
	 and marks the Eiffel object as `is_destroyed'.
	 
	 The twist:
	 In order to create EIF_OBJECTs and have C signal handlers call Eiffel
	 functions the GTK object must have a reference to the EIF object.
	 But if it has a reference the Eiffel object will never be collected by the
	 GC and we'll run out of memory. So, we use the eif_object_id function from
	 eif_object_id.h (and its partner in crime eif_id_object) to create a weak
	 reference from the GTK object to the EIF object, it can be used to get a
	 normal strong reference when needed but doesn't deter the GC from reaping
	 the object the rest of the time. 
	 See the July 1998 "Weak references in Eiffel?"[6] thread on comp.lang.eiffel
	 for some heated debate on this topic.
	 
	 Note: much of what is described here is implemented in C, see ev_any_imp.c
	 
	 [1] http://www.eiffel.com/doc/manuals/technology/internal/gc/page.html
	 [2] http://www/runtime/doc/gc.html
	 [3] http://cvs.gnome.org/lxr/source/gtk+/docs/refcounting.txt
	 [4] http://cvs.gnome.org/lxr/source/gtk+/gtk/gtkobject.c
	 [5] http://www.eiffel.com/doc/manuals/technology/library/cecil/page.html
	 [6] http://x41.deja.com/viewthread.xp?AN=374238517&ST=PS&
	     CONTEXT=942256350.2001338403&HIT_CONTEXT=942256350.2001338403&HIT_NUM=0&
	     recnum=%3cEwK3tD.5D8@ecf.toronto.edu%3e%231/1&group=comp.lang.eiffel
	     (join that mess onto one line or just search deja.com)
	]"
	
end -- class EV_ANY_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

