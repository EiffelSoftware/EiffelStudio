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
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface,
			pointer_double_press_actions_internal,
			pointer_button_press_actions_internal,
			pointer_motion_actions_internal
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
			set_foreground_color,
			foreground_color_pointer,
			visual_widget
		redefine
			initialize,
			pointer_double_press_actions_internal,
			pointer_button_press_actions_internal,
			pointer_motion_actions_internal
		end

	EV_BUTTON_IMP
		rename
			interface as button_interface,
			parent as button_parent,
			parent_imp as widget_parent_imp,
			select_actions_internal as button_select_actions_internal
		undefine
			button_press_switch,
			pointer_motion_actions,	
			pointer_button_press_actions,
			pointer_double_press_actions,
			create_pointer_button_press_actions,
			create_pointer_double_press_actions,
			select_actions,
			on_focus_changed,
			destroy
		redefine
			make,
			initialize,
			initialize_button_box,
			pointer_double_press_actions_internal,
			pointer_button_press_actions_internal,
			pointer_motion_actions_internal,
			create_select_actions
		select
			button_parent
		end

	EV_TOOLTIPABLE_IMP
		undefine
			visual_widget
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_button_new)		
		end

	initialize is
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
				-- We want tool bar buttons to be flat in appearance and not focusable.
			feature {EV_GTK_EXTERNALS}.gtk_button_set_relief (visual_widget, feature {EV_GTK_EXTERNALS}.gtk_relief_none_enum)
			feature {EV_GTK_EXTERNALS}.GTK_WIDGET_UNSET_FLAGS (visual_widget, feature {EV_GTK_EXTERNALS}.gTK_CAN_FOCUS_ENUM)
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
			box := feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (visual_widget, box)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (box)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_end (box, text_label, True, True, 0)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (text_label)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, True, True, 0)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)
		end

feature -- Access

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			gray_pixmap := a_gray_pixmap.twin
			--| FIXME IEK Needs proper implementation
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		do
			gray_pixmap := Void
			--| FIXME IEK Needs proper implementation
		end

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
	
	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
	
	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
	
	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			real_signal_connect (visual_widget, "clicked", agent (App_implementation.gtk_marshal).toolbar_button_select_actions_intermediary (c_object), Void)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

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

