indexing
	description:
		"EiffelVision toggle tool bar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
		-- Create the tool-bar toggle button.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_toggle_tool_button_new)
		end

feature -- Status setting

	disable_select is
			-- Unselect `Current'.
		do
			if is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_tool_button_set_active (visual_widget, False)
			end
		end

	enable_select is
			-- Select `Current'.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_tool_button_set_active (visual_widget, True)
			end
		end	

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_tool_button_get_active (visual_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

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

