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
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface,
			pointer_double_press_actions_internal,
			pointer_button_press_actions_internal,
			pointer_motion_actions_internal
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize,
			pointer_double_press_actions_internal,
			pointer_button_press_actions_internal,
			pointer_motion_actions_internal
		end

	EV_TOOLTIPABLE_IMP
		undefine
			visual_widget
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is do Result := False end

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_tool_button_new (NULL, NULL))		
		end

	initialize is
			-- Initialization of button box and events.
		do
			Precursor {EV_ITEM_IMP}
				-- We want tool bar buttons to be flat in appearance and not focusable.
			pixmapable_imp_initialize
			textable_imp_initialize
			feature {EV_GTK_EXTERNALS}.gtk_tool_button_set_icon_widget (visual_widget, pixmap_box)
			feature {EV_GTK_EXTERNALS}.gtk_tool_button_set_label_widget (visual_widget, text_label)
			align_text_center
			is_initialized := True
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

	
	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			real_signal_connect (visual_widget, "clicked", agent (App_implementation.gtk_marshal).toolbar_button_select_actions_intermediary (c_object), Void)
		end

feature {NONE} -- Implmentation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
	
	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
	
	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

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


