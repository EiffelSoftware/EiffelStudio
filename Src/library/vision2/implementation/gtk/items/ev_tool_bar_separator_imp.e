--| FIXME NOT_REVIEWED this file has not been reviewed
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
			interface
		select
			interface
		end

	EV_ITEM_IMP
		rename
			interface as sep_item_interface
		undefine
			parent
		redefine
			initialize
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
			pointer_motion_actions_internal as widget_pointer_motion_actions_internal,
			pointer_button_press_actions_internal as widget_pointer_button_press_actions_internal,
			pointer_double_press_actions_internal as widget_pointer_double_press_actions_internal,
			create_pointer_button_press_actions as widget_create_pointer_button_press_actions,
			create_pointer_double_press_actions as widget_create_pointer_double_press_actions,
			parent_imp as widget_parent_imp
		undefine	
			button_press_switch,
			pointer_motion_actions,	
			pointer_button_press_actions,
			pointer_double_press_actions
		end

create
	make

feature {NONE} -- Initialization
	
	initialize is
			-- Initialize some stuff useless to separators.
		do
			pixmapable_imp_initialize
			initialize_pixmap_box
			{EV_ITEM_IMP} Precursor
		--| FIXME sementation violation?
		--| 	set_minimum_width (12)
			is_initialized := True
		end

	initialize_pixmap_box is
			-- Give parent to pixmap item box.
			--| This is just to satisfy pixmapable contracts.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_widget_hide (box)
			C.gtk_box_pack_start (box, pixmap_box, True, True, 0)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR

end -- class EV_TOOL_BAR_SEPARATOR_I

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

