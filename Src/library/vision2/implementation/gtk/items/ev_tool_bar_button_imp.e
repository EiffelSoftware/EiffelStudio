indexing
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		select
			interface
		end

	EV_ITEM_IMP
		rename
			interface as simple_item_interface
		undefine
			set_pixmap,
			remove_pixmap,
			parent,
			pointer_over_widget,
			set_foreground_color,
			foreground_color_pointer,
			visual_widget
		redefine
			initialize
		end

	EV_BUTTON_IMP
		rename
			interface as button_interface,
			parent as button_parent,
			select_actions_internal as button_select_actions_internal,	
			pointer_motion_actions_internal as button_pointer_motion_actions_internal,	
			pointer_button_press_actions_internal as button_pointer_button_press_actions_internal,
			pointer_double_press_actions_internal as button_pointer_double_press_actions_internal,
			parent_imp as widget_parent_imp 
		undefine
			button_press_switch,
			select_actions,
			pointer_motion_actions,	
			pointer_button_press_actions,
			pointer_double_press_actions,
			create_select_actions,
			create_pointer_button_press_actions,
			create_pointer_double_press_actions
		redefine
			make,
			initialize,
			initialize_button_box
		select
			button_parent,
			button_pointer_motion_actions_internal,	
			button_pointer_button_press_actions_internal,
			button_pointer_double_press_actions_internal 
		end

	EV_TOOLTIPABLE_IMP
		undefine
			visual_widget
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_IMP
		redefine
			select_actions_internal,
			create_select_actions
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			connect_signal_to_actions ("clicked", Result, Void)
		end

	initialize is
			-- Initialization of button box and events.
		do
			{EV_ITEM_IMP} Precursor
			GTK_WIDGET_UNSET_FLAGS (c_object, C.GTK_CAN_FOCUS_ENUM)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			is_initialized := True
		end

	initialize_button_box is
			-- Create the box for pixmap and label and connect action sequence.
		local
			box: POINTER
		do
			box := C.gtk_vbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_end (box, text_label, True, True, 0)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_start (box, pixmap_box, True, True, 0)
			C.gtk_widget_hide (pixmap_box)
		end

feature -- Access

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	gray_pixmap_imp: EV_PIXMAP_IMP is
			-- Implementation of the gray pixmap contained 
		do
			if gray_pixmap /= Void then
				Result ?= gray_pixmap.implementation
			end
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			gray_pixmap := clone (a_gray_pixmap)
			--| FIXME IEK Needs proper implementation
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		do
			gray_pixmap := Void
			--| FIXME IEK Needs proper implementation
		end

feature -- Status report

	index: INTEGER is
			-- Index in toolbar
		do
			if parent_imp /= Void then
				Result := C.gtk_list_child_position (
					parent_imp.list_widget,
					Current.c_object
				) + 1
			end 
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

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

