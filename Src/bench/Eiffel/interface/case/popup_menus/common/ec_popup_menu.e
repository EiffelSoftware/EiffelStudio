indexing
	description: "Popup Menu launched from Ecase part."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_POPUP_MENU

inherit
	EV_POPUP_MENU

creation
	make

feature -- Operations

	colorize (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Colorize 'data'.
		do
		end

feature -- Implementation

	data: COLORABLE
		-- Current data that applies to Current Menu.

	workarea: WORKAREA
		-- Current workarea

invariant
	data_exists: data /= Void
	workarea_exists: workarea /= Void

end -- class EC_POPUP_MENU
