indexing
	description: "EiffelVision tool-bar dropdown button, mswindows implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP

inherit
	EV_TOOL_BAR_DROP_DOWN_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

create
	make

feature {EV_TOOL_BAR_IMP} -- Implementation

	interface: EV_TOOL_BAR_DROP_DOWN_BUTTON
			-- Tool bar drop down button bridge.


end
