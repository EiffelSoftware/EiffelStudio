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
			initialize
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
			pointer_motion_actions_internal as widget_pointer_motion_actions_internal,
			pointer_button_press_actions_internal as widget_pointer_button_press_actions_internal,
			pointer_double_press_actions_internal as widget_pointer_double_press_actions_internal,
			parent_imp as widget_parent_imp
		export {NONE}
			widget_interface,
			widget_parent,
			widget_initialize
		undefine
			pointer_motion_actions,
			pointer_button_press_actions,
			pointer_double_press_actions
		redefine
			button_press_switch,
			create_pointer_button_press_actions,
			create_pointer_double_press_actions
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize is
			-- Sets up `Current' ready for use.
		do
			if C.gtk_is_widget (c_object) then
				C.gtk_widget_show (c_object)
			end

			set_default_colors
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
			if a_type = C.GDK_BUTTON_PRESS_ENUM then
				if pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
			else -- a_type = C.GDK_2BUTTON_PRESS_ENUM
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

	item_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM]
		-- Used to store parent imp of items where parent stores
		-- items in a list widget instead of the c_object.

	set_item_parent_imp (a_parent: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- Set `item_parent_imp' to `a_parent'.
		do
			item_parent_imp := a_parent
		end

	interface: EV_ITEM

end -- class EV_ITEM_IMP

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

