indexing
	description: "Eiffel Vision tool bar select button. %N%
	%Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_SELECT_BUTTON_IMP

inherit

	EV_TOOL_BAR_SELECT_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := checked
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			set_checked
		end

feature {NONE} -- Implementation

	checked: BOOLEAN is
			-- To be effected by WEL class.
		deferred
		end

	set_checked is
			-- To be effected by WEL class.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SELECT_BUTTON

end -- class EV_TOOL_BAR_SELECT_BUTTON_IMP
