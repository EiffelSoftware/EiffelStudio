indexing
	description: "EiffelVision item, gtk implementation";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EV_ITEM_IMP

inherit
	EV_ITEM_I
		redefine
			interface,
			initialize,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		select
			interface,
			initialize
		end

	EV_WIDGET_IMP
			-- Inheriting from widget,
			-- because items are widget in gtk
		rename
			interface as widget_interface,
			parent as widget_parent,
			initialize as widget_initialize,
			parent_imp as widget_parent_imp
		export {NONE}
			widget_interface,
			widget_parent,
			widget_initialize
		undefine
			pointer_motion_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			needs_event_box,
			destroy
		redefine
			button_press_switch,
			create_pointer_button_press_actions,
			create_pointer_double_press_actions,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal,
			destroy
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			needs_event_box
		redefine
			interface,
			destroy
		end

feature {NONE} -- Initialization

	initialize is
			-- Sets up `Current' ready for use.
		do
			widget_initialize
			if feature {EV_GTK_EXTERNALS}.gtk_is_widget (c_object) then
				feature {EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			end
			is_initialized := True
		end

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			if a_type = feature {EV_GTK_EXTERNALS}.gDK_BUTTON_PRESS_ENUM then
				if pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
			else -- a_type = feature {EV_GTK_EXTERNALS}.gDK_2BUTTON_PRESS_ENUM
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
			end
        end
		
feature -- Access

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- The parent of the Current widget
			-- May be void.
		do
				Result := item_parent_imp
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			create Result
			Result.not_empty_actions.extend (agent connect_button_press_switch)
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			create Result
			Result.not_empty_actions.extend (agent connect_button_press_switch)
		end

feature {EV_ANY_IMP} -- Implementation

	destroy is
			-- Destroy `Current'
		do
			if parent_imp /= Void then
					parent_imp.interface.prune_all (interface)
			end
			Precursor {EV_ANY_IMP}
		end

	item_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM]
		-- Used to store parent imp of items where parent stores
		-- items in a list widget instead of the c_object.

	set_item_parent_imp (a_parent: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- Set `item_parent_imp' to `a_parent'.
		do
			item_parent_imp := a_parent
		end
		
feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM

feature {NONE} -- Implmentation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
	
	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
	
	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

end -- class EV_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

