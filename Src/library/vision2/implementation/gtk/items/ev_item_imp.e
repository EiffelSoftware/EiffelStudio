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
		local
			c_parent: POINTER
			Result_imp: EV_ITEM_LIST_IMP [EV_ITEM]
		do
			if item_parent_imp /= Void then
				Result := item_parent_imp
			else
				from
					c_parent := c_object
				until
					Result /= Void or c_parent = NULL
				loop
					c_parent := C.gtk_widget_struct_parent (c_parent)
					if c_parent /= NULL then
						Result_imp ?= eif_object_from_c (c_parent)
						if Result_imp /= Void then
							Result := Result_imp
						end
					end
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			create Result
			Result.not_empty_actions.extend (~connect_button_press_switch)
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			create Result
			Result.not_empty_actions.extend (~connect_button_press_switch)
		end

feature {EV_ITEM_IMP, EV_ITEM_LIST_IMP} -- Implementation

	item_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM]
		-- Used to store parent imp of items where parent stores
		-- items in a list widget instead of the c_object.

	set_parent_imp (a_parent: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- Set `item_parent_imp' to `a_parent'.
		do
			item_parent_imp := a_parent
		end

	interface: EV_ITEM

end -- class EV_ITEM_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.32  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.4.11  2000/11/01 01:07:05  andrew
--| Renamed wid_imp parent_imp to widget_parent_imp
--|
--| Revision 1.17.4.10  2000/09/06 23:18:38  king
--| Reviewed
--|
--| Revision 1.17.4.9  2000/08/03 21:37:31  king
--| Redefining button action sequences to connect swtich agent
--|
--| Revision 1.17.4.8  2000/07/28 21:11:12  king
--| Corrected log message
--|
--| Revision 1.17.4.7  2000/07/28 21:09:33  king
--| Corrected initialize so no qualified calls are made through interface
--|
--| Revision 1.17.4.6  2000/07/24 21:33:39  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.17.4.5  2000/06/12 16:22:56  oconnor
--| removed references to obsolete features
--|
--| Revision 1.17.4.4  2000/06/05 23:47:40  oconnor
--| support double click
--|
--| Revision 1.17.4.3  2000/06/01 22:02:10  king
--| Removed direct inheritence from EV_PND as we have it from EV_WIDGET_IMP
--|
--| Revision 1.17.4.2  2000/05/13 00:04:09  king
--| Converted to new EV_CONTAINABLE class
--|
--| Revision 1.17.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.29  2000/05/02 18:55:19  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.28  2000/05/01 21:32:20  king
--| Exporting redundant features to none
--|
--| Revision 1.27  2000/04/19 20:42:39  oconnor
--| formatting
--|
--| Revision 1.26  2000/04/07 22:35:53  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.25  2000/04/04 20:50:18  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.24  2000/03/24 02:20:29  oconnor
--| removed c-ed out code
--|
--| Revision 1.23  2000/03/09 01:15:27  king
--| Corrected comment of set_parent_imp
--|
--| Revision 1.21  2000/03/08 22:20:39  king
--| Made set_combo_parent_imp generic to deal with tree items
--|
--| Revision 1.20  2000/03/08 21:34:34  king
--| Removed obsolete parenting functions, add combo box parent hack
--|
--| Revision 1.19  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.18  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.16  2000/02/04 21:20:05  king
--| Removed unused body code from set_parent and set_parent_with_index
--|
--| Revision 1.17.6.15  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.17.6.14  2000/02/02 00:41:06  king
--| Implemented parent_imp, obsoleted set_parent
--|
--| Revision 1.17.6.13  2000/01/28 18:39:37  king
--| Set is_initialized to true
--|
--| Revision 1.17.6.12  2000/01/27 19:29:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.11  2000/01/18 23:13:40  king
--| Set is_initialized to true
--|
--| Revision 1.17.6.10  1999/12/17 23:27:38  oconnor
--| marked set_parent_and_index obsolete
--|
--| Revision 1.17.6.9  1999/12/15 00:22:05  oconnor
--|  removed create  global_pnd_targets, it is now once
--|
--| Revision 1.17.6.8  1999/12/13 19:44:49  oconnor
--| added global_pnd_targets
--|
--| Revision 1.17.6.7  1999/12/08 17:42:27  oconnor
--| removed more inherited externals
--|
--| Revision 1.17.6.6  1999/12/06 17:28:44  oconnor
--| tweak to compile, be fixed later
--|
--| Revision 1.17.6.5  1999/12/04 18:59:12  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.17.6.4  1999/12/03 07:49:32  oconnor
--| use new  connect_signal_to_actions
--|
--| Revision 1.17.6.3  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that
--| relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.17.6.2  1999/11/30 22:52:43  oconnor
--| added action sequence
--|
--| Revision 1.17.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.3  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.17.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
