note
	description: "Eiffel Vision radio button. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		export
			{NONE}
				c_object
			{EV_CONTAINER_IMP}
				visual_widget
		undefine
			default_alignment
		redefine
			interface,
			old_make,
			make,
			new_gtk_button
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			widget_object
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create radio button.
		do
			assign_interface (an_interface)
		end

	new_gtk_button: POINTER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_radio_button_new (NULL)
		end

	make
			-- Initialize `Current'
		do
			Precursor
			align_text_left
			enable_select
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is toggle button pressed?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)
			end
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER
			-- Returns c_object relative to a_list data.
		do
			Result := {EV_GTK_EXTERNALS}.gslist_struct_data (a_list)
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (Result)
		end

	radio_group: POINTER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_radio_button_group (visual_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_RADIO_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_RADIO_BUTTON_IMP





