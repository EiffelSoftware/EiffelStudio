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

feature {EV_ANY_I, EV_PND_TRANSPORTER_IMP} -- Access

	c_object: POINTER
			-- C pointer to an object conforming to GtkWidget.

feature {EV_ANY_I} -- Access

	set_c_object (a_c_object: POINTER) is
			-- Assign `a_c_object' to `c_object'.
			-- Set up Eiffel GC / GTK cooperation.
			--| (See note at end of class)
		require
			a_c_object_not_null: a_c_object /= Default_pointer
		do
			c_object := a_c_object
			debug ("EV_GTK_DEBUG")
				print (generator + ".set_c_object new eif_object "
					+ out.substring (1, out.index_of ('%N', 1) - 1)
					+ " and new c_object " + c_object.out  +
					" and new eif_oid " + object_id.out + "%N")
			end
			set_eif_oid_in_c_object (c_object, object_id, $c_object_dispose)
		ensure
			c_object_assigned: c_object = a_c_object
		end

	eif_object_from_c (a_c_object: POINTER): EV_ANY_IMP is
			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
		require
			a_c_object_not_null: a_c_object /= Default_pointer
		do
			Result := c_get_eif_reference_from_object_id (a_c_object)
		end

feature {EV_ANY, EV_ANY_IMP} -- Command

	destroy is
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		do
			debug ("EV_GTK_DEBUG")
				safe_print (generator + ".destroy")
			end
			C.gtk_object_destroy (c_object)
			c_object := Default_pointer
			is_destroyed := True
			destroy_just_called := True
		ensure then
			c_object_detached: c_object = Default_pointer
		end

feature {EV_ANY_I} -- Event handling

	signal_connect (a_signal_name: STRING; an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Connect `an_agent' to `a_signal_name'.
		require
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.empty
			an_agent_not_void: an_agent /= Void
		do
			real_signal_connect (c_object, a_signal_name, an_agent)
		ensure
			signal_connection_id_positive: last_signal_connection_id > 0
		end

	real_signal_connect (
		a_c_object: like c_object;
		a_signal_name: STRING;
		an_agent: PROCEDURE [ANY, TUPLE]
	) is
			-- Connect `an_agent' to `a_signal_name' of `a_c_object'.
		require
			a_c_object_not_void: a_c_object /= Void
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.empty
			an_agent_not_void: an_agent /= Void
		do
			last_signal_connection_id := 
			c_signal_connect (a_c_object, eiffel_to_c(a_signal_name), an_agent)
		ensure
			signal_connection_id_positive: last_signal_connection_id > 0
		end

	last_signal_connection_id: INTEGER
			-- GTK signal connection id of the most recent `signal_connect'.

	signal_disconnect (a_connection_id: INTEGER) is
			-- Disconnect signal connection with `a_connection_id'.
		require
			a_connection_id_positive: a_connection_id > 0
		do
			C.gtk_signal_disconnect (c_object, a_connection_id)
		end

	connect_signal_to_actions (a_signal_name: STRING;
		an_action_sequence: ACTION_SEQUENCE [TUPLE]) is

			-- Connect `a_signal_name' to `an_action_sequence'.
		require
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.empty
			an_action_sequence_not_void: an_action_sequence /= Void
		do
			real_connect_signal_to_actions (
				c_object,
				a_signal_name,
				an_action_sequence
			)
		end

	real_connect_signal_to_actions (a_c_object: POINTER; a_signal_name: STRING;
		an_action_sequence: ACTION_SEQUENCE [TUPLE]) is

			-- Connect `a_signal_name' to `an_action_sequence'.
		require
			a_c_object_not_void: a_c_object /= Void
			a_signal_name_not_void: a_signal_name /= Void
			a_signal_name_not_empty: not a_signal_name.empty
			an_action_sequence_not_void: an_action_sequence /= Void
		do
			an_action_sequence.set_source_connection_agent (
				~real_signal_connect (
					a_c_object,
					a_signal_name,
					an_action_sequence~call (?)
				)
			)
		end

feature {NONE} -- Implementation

	dispose is
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
			--| Use the localy gtk_object_destroy defined below to avoid making
			--| a dot call to C.gtk_object_destroy which is not allowed here.
		do
			debug ("EV_GTK_DEBUG")
				safe_print (generator + ".dispose")
			end
			if c_object /= Default_pointer then
				gtk_object_unref (c_object)
			end
			Precursor
		end

	c_object_dispose is
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		do
			debug ("EV_GTK_DEBUG")
				safe_print (generator + ".c_object_dispose")
			end
			c_object := Default_pointer
			is_destroyed := True
			destroy_just_called := True
		ensure
			is_destroyed_set: is_destroyed
			destroy_just_called_set: destroy_just_called
			c_object_detached: c_object = Default_pointer
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

	gtk_object_unref (a_c_object: POINTER) is
			-- Only for use in dispose.
			-- (Dispose cannot call C.gtk_object_unref)
        external
            "C (GtkObject*) | <gtk/gtk.h>"
        end

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end

invariant
	c_object_only_null_when_destroyed:
		is_destroyed = (c_object = Default_pointer)
	c_invariant: c_object /= Default_pointer implies c_invariant (c_object)
	c_object_coupled: c_object /= Default_pointer implies
		eif_object_from_c (c_object) = Current
	c_externals_object_not_void: C /= Void

end -- class EV_ANY_IMP

--|-----------------------------------------------------------------------------
--| Scheme for Eiffel GC / GTK RC cooperation (with a twist).
--| 
--| This describes the interaction between the ISE garbage collector[1] (GC) and
--| the GTK+ reference counter[3] (RC). Eiffel objects get collected some time
--| after they are no longer reachable from the root Eiffel object. GTK objects
--| are destroyed right after their reference count drops to zero.
--|
--| Eiffel objects have a `dispose' feature that is called when they are reaped.
--| GTK objects have a "destroy" signal that is emitted when they are destroyed.
--|
--| A "widget" in Vision is actual a pair of objects one Eiffel, one GTK.
--| Henceforth:
--|     EIF object: refers to an Eiffel object that corresponds to a GTK object.
--|     GTK object: refers to a GtkWidget that corresponds to an EIF object.
--|
--| The principle is that a GTK object and the corresponding EIF object are
--| tightly coupled and that such couples are handled by both memory management
--| systems. Thats is, if the couple is reachable from either Eiffel or C it
--| is considered alive, only if it is reachable from neither is it reaped.
--| (Note that due to the mark & sweep GC in ISE Eiffel reachable /= referenced)
--| If one member of the couple is explicitly destroyed the other must also die.
--| At any point in time the couple must be under the control of only one memory
--| management system (Eiffel GC or GTK RC). To put it under the control of one,
--| we simply make an extra reference to it from the other.
--| 
--| The execution goes something like this:
--| 
--| When the widget is parented, it's destiny is controlled by GTK.
--|     The GTK object makes an Eiffel reference on the EIF object to save it
--|     from the Eiffel GC. An EIF_OBJECT[5] is stored in the GTK object data
--|     payload with eif_wean as the destroy notify function.
--|     (gtk_object_set_data_full[4] allows arbitrary data to be stored.)
--|     If we previously incremented the GTK object reference count we decrement
--|     it (see below) so that it is destroyed if all other references are lost.
--|
--| When the widget is unparented, it's destiny is controlled by the EIFFEL GC.
--|     The EIF object increments the GTK object reference count to save it
--|     from the GTK RC. An entry is made in the GTK object data payload to note
--|     that we made an extra reference.
--|     The EIF_OBJECT in the GTK object data payload is removed, this causes
--|     eif_wean to release it's reference so that if there are no other Eiffel
--|     references to it, it is destroyed.
--|
--| Toplevel widgets like Windows are considered to be always parented, that is,
--| they are always at the mercy of the GTK RC.
--| 
--| `c_object_dispose' is connected to the GTK object "destroy" signal and marks
--|  the Eiffel object as `is_destroyed'.
--| 
--| `dispose' destroys the GTK object if the Eiffel object is collected.
--| 
--| The user may also explicitly call `destroy', this destroys the GTK object
--| and marks the Eiffel object as `is_destroyed'.
--| 
--| The twist:
--| In order to create EIF_OBJECTs and have C signal handlers call Eiffel
--| functions the GTK object must have a reference to the EIF object.
--| But if it has a reference the Eiffel object will never be collected by the
--| GC and we'll run out of memory. So, we use the eif_object_id function from
--| eif_object_id.h (and its partner in crime eif_id_object) to create a weak
--| reference from the GTK object to the EIF object, it can be used to get a
--| normal strong reference when needed but doesn't deter the GC from reaping
--| the object the rest of the time. 
--| See the July 1998 "Weak references in Eiffel?"[6] thread on comp.lang.eiffel
--| for some heated debate on this topic.
--| 
--| Note: much of what is described here is implemented in C, see ev_any_imp.c
--| 
--| [1] http://www.eiffel.com/doc/manuals/technology/internal/gc/page.html
--| [2] http://www/runtime/doc/gc.html
--| [3] http://cvs.gnome.org/lxr/source/gtk+/docs/refcounting.txt
--| [4] http://cvs.gnome.org/lxr/source/gtk+/gtk/gtkobject.c
--| [5] http://www.eiffel.com/doc/manuals/technology/library/cecil/page.html
--| [6] http://x41.deja.com/viewthread.xp?AN=374238517&ST=PS&
--|     CONTEXT=942256350.2001338403&HIT_CONTEXT=942256350.2001338403&HIT_NUM=0&
--|     recnum=%3cEwK3tD.5D8@ecf.toronto.edu%3e%231/1&group=comp.lang.eiffel
--|     (join that mess onto one line or just search deja.com)
--|
--|-----------------------------------------------------------------------------

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:08  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.27  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.1.2.26  2000/01/27 19:29:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.25  2000/01/27 18:52:49  brendel
--| Fixed bug in real_signal_connect.
--|
--| Revision 1.1.2.24  2000/01/27 17:50:41  oconnor
--| added real_signal_connect and real_connect_signal_to_actions
--|
--| Revision 1.1.2.23  2000/01/20 23:47:28  oconnor
--| added casting information to externals
--|
--| Revision 1.1.2.22  1999/12/17 23:27:02  oconnor
--| formatting
--|
--| Revision 1.1.2.21  1999/12/17 23:23:26  oconnor
--| call gtk_object_unref not gtk_object_destroy in dispose,
--|  destroy does not free memory, it just disables the widget.
--|
--| Revision 1.1.2.20  1999/12/16 09:16:56  oconnor
--| make signal_connect avalible to ANY_I
--|
--| Revision 1.1.2.19  1999/12/09 18:16:08  oconnor
--| added signal_disconnect
--|
--| Revision 1.1.2.18  1999/12/07 22:00:07  oconnor
--| Add external for gtk_object_destroy for use in dispose.
--| dispose is not allowed to make dot calls and thus cannot
--| call C.gtk_object_dispose
--|
--| Revision 1.1.2.17  1999/12/05 00:35:48  oconnor
--| improved invariant tag wording
--|
--| Revision 1.1.2.16  1999/12/04 18:59:12  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.1.2.15  1999/12/03 05:02:31  oconnor
--| extra comments
--|
--| Revision 1.1.2.14  1999/12/03 04:06:17  brendel
--| Added feature `make'.
--|
--| Revision 1.1.2.13  1999/12/02 20:27:22  oconnor
--| connect_signal_to_actions: delayed actual connection of action sequence
--|
--| Revision 1.1.2.12  1999/12/02 07:59:33  oconnor
--| formatting only
--|
--| Revision 1.1.2.11  1999/12/02 01:55:13  brendel
--| Corrected ACTION_SEQUENCE to ACTION_SEQUENCE [TUPLE].
--|
--| Revision 1.1.2.10  1999/12/02 00:06:12  oconnor
--| wrap to 80 cols
--|
--| Revision 1.1.2.9  1999/12/01 23:06:36  brendel
--| Added connect_signal_to_actions. Changes precondition tags to start with
--| a_ or an_.
--|
--| Revision 1.1.2.8  1999/12/01 02:14:52  oconnor
--| implement part of invariant in C
--|
--| Revision 1.1.2.7  1999/12/01 01:51:02  oconnor
--| spelink
--|
--| Revision 1.1.2.6  1999/12/01 01:41:29  oconnor
--| improved commets
--|
--| Revision 1.1.2.5  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that
--|  relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.1.2.4  1999/11/29 17:19:03  brendel
--| Ignore log message on previous version. Removed old external-files from
--| inheritance clause.
--|
--| Revision 1.1.2.3  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.1.2.2  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.1  1999/11/23 23:23:41  oconnor
--| merged from support/ev_gtk_any_imp in REVIEW BRANCH
--|
--| Revision 1.4.2.9  1999/11/18 03:39:58  oconnor
--| added signal connecting features
--|
--| Revision 1.4.2.8  1999/11/17 01:51:22  oconnor
--| fixed single_point_of_reference invariant to handle NULL c_object,
--| cleand up debug messages
--|
--| Revision 1.4.2.7  1999/11/12 08:07:47  oconnor
--| spelling
--|
--| Revision 1.4.2.6  1999/11/12 07:56:51  oconnor
--| reworked memory management from ground up
--|
--| Revision 1.4.2.5  1999/11/10 23:04:36  oconnor
--| about to change mem management, commiting to save old prototype
--|
--| Revision 1.4.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.4.2.3  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
