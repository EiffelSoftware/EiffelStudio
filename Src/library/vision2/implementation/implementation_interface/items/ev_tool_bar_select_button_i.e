indexing
	description: "Eiffel Vision toolbar select button. Implementation interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_SELECT_BUTTON_I

inherit

	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is button depressed?
		deferred
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		deferred
		ensure
			is_selected: is_selected
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SELECT_BUTTON

end -- class EV_TOOL_BAR_SELECT_BUTTON_I
