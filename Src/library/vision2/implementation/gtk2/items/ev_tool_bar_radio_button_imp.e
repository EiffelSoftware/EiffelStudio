indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			parent_imp,
			make,
			interface,
			set_parent_imp,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal,
			create_select_actions
		end

	EV_RADIO_PEER_IMP
		undefine
			visual_widget
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make a radio button with a default of selected.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_radio_tool_button_new (NULL))
				-- Needed to prevent calling of action sequence.
		end

feature -- Status setting

	enable_select is
			-- Select `Current'.
		do
			if not is_selected then
				feature {EV_GTK_EXTERNALS}.gtk_toggle_tool_button_set_active (visual_widget, True)
			end
		end	

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_toggle_tool_button_get_active (visual_widget)
		end

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			real_signal_connect (visual_widget, "clicked", agent (App_implementation.gtk_marshal).toolbar_item_select_actions_intermediary (internal_id), Void)
		end

feature {NONE} -- Implementation

	set_parent_imp (a_container_imp: EV_CONTAINER_IMP) is
			-- Set `parent_imp' to `a_container_imp'.
			-- (from EV_WIDGET_IMP)
			-- (export status {EV_CONTAINER_IMP})
		do
			Precursor {EV_TOOL_BAR_BUTTON_IMP} (a_container_imp)
			if a_container_imp = Void then
				-- `Current' is being unparented so we unset the radio group
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_radio_tool_button_set_group (visual_widget, NULL)
			end
		end

	parent_imp: EV_TOOL_BAR_IMP is
		do
			Result ?= Precursor
		end

feature {EV_ANY_I} -- Implementation

	radio_group: POINTER is
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_radio_tool_button_get_group (visual_widget)
		end

	interface: EV_TOOL_BAR_RADIO_BUTTON

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

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

