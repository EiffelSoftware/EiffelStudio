indexing
	description: "Open the Menu Window"
	date: "$Date$"
	revision: "$Revision$"

class
	FLO_MENU_COMMAND

inherit
	EV_COMMAND

	ONCES

creation
	make

feature -- Initialization

	make is do end

feature -- execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	do
	--		Windows.menu_window.raise
	--		Windows.menu_window.popup
	--		Windows.menu_window.raise
	end
end -- class FLO_MENU_COMMAND
