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
			on_parented,
			interface
		end

feature -- Status report
	
	is_selected: BOOLEAN
			-- Is `Current selected'?
	
feature -- Status setting

	enable_select is
			-- Select `Current'.
		deferred
		end

	disable_select is
			-- Deselect `Current'
		do
			is_selected := False
			if parent_imp /= Void then
				parent_imp.uncheck_button (id)
			end
		end

feature {EV_TOOL_BAR_SELECT_BUTTON_IMP} -- Implementation

	on_parented is
			-- `Current' has just been parented.
		require else
			has_parent: parent_imp /= Void
		do
			if is_selected = True then
				parent_imp.check_button (id)
			else
				parent_imp.uncheck_button (id)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SELECT_BUTTON

end -- class EV_TOOL_BAR_SELECT_BUTTON_IMP
