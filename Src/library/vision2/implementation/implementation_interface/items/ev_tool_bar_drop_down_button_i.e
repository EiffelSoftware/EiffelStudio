indexing
	description:
		"Eiffel Vision tool bar dropdown button. Implementation interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_DROP_DOWN_BUTTON_I

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

feature {NONE} -- Implementation

	interface: EV_TOOL_BAR_DROP_DOWN_BUTTON
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end
