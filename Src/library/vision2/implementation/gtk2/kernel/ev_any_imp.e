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
		export
			{EV_INTERMEDIARY_ROUTINES, EV_ANY_IMP}
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
		do
			c_object := a_c_object
				-- Add reference and removing floating state
			feature {EV_GTK_EXTERNALS}.object_ref (c_object)
			feature {EV_GTK_EXTERNALS}.gtk_object_sink (c_object)
			debug ("EV_GTK_CREATION")
				print (generator + " created%N")
			end
			feature {EV_GTK_CALLBACK_MARSHAL}.set_eif_oid_in_c_object (c_object, object_id, $c_object_dispose)
		ensure
			c_object_assigned: c_object = a_c_object
		end

	eif_object_from_c (a_c_object: POINTER): EV_ANY_IMP is
			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
		require
			a_c_object_not_null: a_c_object /= NULL
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

feature {EV_ANY, EV_ANY_IMP} -- Command

	destroy is
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		local
			item_imp: EV_ITEM_IMP
			widget_imp: EV_WIDGET_IMP
		do
			if not is_destroyed then
				item_imp ?= Current
				if item_imp /= Void and then item_imp.parent_imp /= Void then
						item_imp.parent_imp.interface.prune_all (item_imp.interface)
				else
					widget_imp ?= Current
					if widget_imp /= Void and then widget_imp.parent_imp /= Void then
						widget_imp.parent_imp.interface.prune_all (widget_imp.interface)
					end
				end
				is_destroyed := True
				if internal_id /= 0 then
						feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect_by_data (c_object, internal_id)
				end	
	
					-- Windows are explicitly reffed on initialization as they are toplevel widgets.
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_destroy (c_object)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (c_object)
				c_object := NULL
			end
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
			real_signal_connect (c_object, a_signal_name, an_agent, translate)
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
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (a_signal_name)
			a_connection_id := feature {EV_GTK_CALLBACK_MARSHAL}.c_signal_connect_true (
				c_object,
				a_cs.item,
				an_agent
			)
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
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (a_signal_name)
			if translate /= Void then
				last_signal_connection_id := feature {EV_GTK_CALLBACK_MARSHAL}.c_signal_connect (
					a_c_object,
					a_cs.item,
					agent (App_implementation.gtk_marshal).translate_and_call (an_agent, translate, ?, ?)
				)
			else
				last_signal_connection_id := feature {EV_GTK_CALLBACK_MARSHAL}.c_signal_connect (
					a_c_object,
					a_cs.item,
					an_agent
				)
			end
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
			feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (c_object, a_connection_id)
		end
		
feature {NONE} -- Implementation

	dispose is
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if c_object /= NULL and then not is_in_final_collect and then not App_implementation.gtk_marshal.is_destroyed then
					-- Destroy has not been explicitly called.
					is_destroyed := True
						-- This is incase events are fired from the calls to gtk upon disposal
					if internal_id /= 0 then
						feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect_by_data (c_object, internal_id)
					end			
					--| This is the signal attached in ev_any_imp.c
					--| used for GC/Ref-Counting interaction.
					feature {EV_GTK_DEPENDENT_EXTERNALS}.object_destroy (c_object)
					feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (c_object)
					c_object := NULL
				end
				Precursor {IDENTIFIED}
			end
		rescue
			retried := True
			Precursor {IDENTIFIED}
			retry
		end

	c_object_dispose is
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		do
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

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

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

feature -- Conversion

	pointer_to_integer (pointer: POINTER): INTEGER is
			-- int pointer_to_integer (void* pointer) {
			--     return (int) pointer;
			-- }
			-- Hack used for Result = ((EIF_INTEGER)(pointer)), blank alias avoids parser rules.
		external
			"C [macro <stdio.h>] (EIF_POINTER): EIF_INTEGER"
		alias
			" "
		end
		
feature -- Measurement

	NULL: POINTER is
		external
			"C [macro <stdio.h>]"
		alias
			"NULL"
		end

invariant
	c_object_coupled: c_object /= NULL implies
		eif_object_from_c (c_object) = Current

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

