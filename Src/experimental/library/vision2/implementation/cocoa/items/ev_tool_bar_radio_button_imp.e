note
	description: " EiffelVision tool-bar radio button. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			make,
			interface
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

	make
			-- Create a Cocoa toggle button.
		do
			create button.make
			cocoa_view := button

			Precursor {EV_TOOL_BAR_BUTTON_IMP}
			Precursor {EV_RADIO_PEER_IMP}
			is_selected := True
			select_actions.extend (agent enable_select)
		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		do
			Precursor
			is_selected := True
		end

	disable_select
			-- Unselect 'Current'
		do
			Precursor
			is_selected := False
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
--		do
--			Result := not radio_group.is_empty and then radio_group.first = current
--		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_RADIO_BUTTON note option: stable attribute end
			-- Interface of `Current'

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP
