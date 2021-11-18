note
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
		undefine
			init_select_actions
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			new_tool_bar_button
		end

create
	make

feature -- Initialization

	new_tool_bar_button: POINTER
			-- <Precursor>
		do
			Result := {GTK2}.gtk_toggle_tool_button_new
		end

feature -- Status setting

	disable_select
			-- Unselect `Current'.
		do
			if is_selected then
				{GTK2}.gtk_toggle_tool_button_set_active (visual_widget, False)
			end
		end

	enable_select
			-- Select `Current'.
		do
			if not is_selected then
				{GTK2}.gtk_toggle_tool_button_set_active (visual_widget, True)
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
			Result := {GTK2}.gtk_toggle_tool_button_get_active (visual_widget)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_TOGGLE_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP
