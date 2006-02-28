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

feature -- Access

	is_whole_drop_down: BOOLEAN is
			-- Is current whole drop down style?
		deferred
		end

feature -- Basic operations

	enable_whole_drop_down is
			-- Enable whole drop down button style.
		deferred
		end

	disable_whole_drop_down is
			-- Disable whole drop down button style.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_TOOL_BAR_DROP_DOWN_BUTTON
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end
