indexing
	description: "Base class for tool bar buttons that have two states (See is_selected)"
	status: "See notice at end of class."
	keywords: "state, toggle, button"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_SELECT_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		redefine
			implementation
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is button depressed?
		require
		do
			Result := implementation.is_selected
		ensure
			bridge_ok: Result = implementation.is_selected
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			implementation.enable_select
		ensure
			is_selected: is_selected
		end

feature {NONE} -- Implementation

	implementation: EV_TOOL_BAR_SELECT_BUTTON_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_TOOL_BAR_SELECT_BUTTON
