note
	description: "EiffelVision toggle button, gtk implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		undefine
			init_select_actions
		redefine
			interface
		end

	EV_BUTTON_IMP
		redefine
			old_make,
			interface,
			new_gtk_button
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a gtk toggle button.
		do
			assign_interface (an_interface)
		end

	new_gtk_button: POINTER
		do
			Result := {GTK}.gtk_toggle_button_new
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		do
			if not is_selected then
				{GTK}.gtk_toggle_button_set_active (visual_widget, True)
			end
		end

	disable_select
				-- Set `is_selected' `False'.
		do
			if is_selected then
				{GTK}.gtk_toggle_button_set_active (visual_widget, False)
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is toggle button pressed?
		do
			Result := {GTK}.gtk_toggle_button_get_active (visual_widget)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOGGLE_BUTTON note option: stable attribute end;

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

end -- class EV_TOGGLE_BUTTON_IMP
