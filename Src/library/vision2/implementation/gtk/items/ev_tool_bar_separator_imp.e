indexing
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		select
			interface
		end

	EV_ITEM_IMP
		rename
			interface as sep_item_interface
		undefine
			parent
		redefine
			initialize,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		select
			widget_parent,
			initialize,
			create_pointer_double_press_actions,
			create_pointer_button_press_actions
		end

	EV_VERTICAL_SEPARATOR_IMP
		rename
			initialize as vsep_initialize,
			interface as vsep_interface,
			parent as vsep_parent,
			create_pointer_button_press_actions as widget_create_pointer_button_press_actions,
			create_pointer_double_press_actions as widget_create_pointer_double_press_actions,
			parent_imp as widget_parent_imp
		undefine	
			button_press_switch,
			pointer_motion_actions,	
			pointer_button_press_actions,
			pointer_double_press_actions,
			destroy
		redefine
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature {NONE} -- Initialization
	
	initialize is
			-- Initialize some stuff useless to separators.
		do
			pixmapable_imp_initialize
			initialize_pixmap_box
			Precursor {EV_ITEM_IMP}
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, 10, -1)
			is_initialized := True
		end

	initialize_pixmap_box is
			-- Give parent to pixmap item box.
			--| This is just to satisfy pixmapable contracts.
		local
			box: POINTER
		do
			box := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (box)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, True, True, 0)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
end -- class EV_TOOL_BAR_SEPARATOR_I

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

