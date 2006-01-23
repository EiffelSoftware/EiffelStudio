indexing
	description:
		"EiffelVision toggle tool bar, implementation interface."
	legal: "See notice at end of class."
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

	interface: EV_TOOL_BAR_TOGGLE_BUTTON;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

