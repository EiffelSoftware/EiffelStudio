note
	description: "Eiffel Vision radio button. Cocoa implementation."
	author:	"Daniel Furrer"
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
		undefine
			default_alignment
		redefine
			interface,
			make,
			old_make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			make,
			enable_select,
			disable_select
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create radio button.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		do
			cocoa_view := current
			Precursor {EV_RADIO_PEER_IMP}
			Precursor {EV_BUTTON_IMP}
			cocoa_make
			set_button_type ({NS_BUTTON}.radio_button)
			align_text_left
			set_state ({NS_CELL}.on_state)
			select_actions.extend (agent enable_select)
		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		do
			Precursor
			set_state ({NS_CELL}.on_state)
		end

	disable_select
			-- Unselect 'Current'
		do
			Precursor
			set_state ({NS_CELL}.off_state)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
			Result := state = {NS_CELL}.on_state
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RADIO_BUTTON note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_RADIO_BUTTON_IMP
