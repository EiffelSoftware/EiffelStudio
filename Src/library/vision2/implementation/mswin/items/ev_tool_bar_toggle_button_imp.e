indexing
	description: "EiffelVision toogle tool bar, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

create
	make

feature -- Status setting

	enable_select is
			-- Select `Current'.
		do
			is_selected := True
			if parent_imp /= Void then
				parent_imp.check_button (id)
			end
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	disable_select is
			-- Deselect `Current'
		do
			is_selected := False
			if parent_imp /= Void then
				parent_imp.uncheck_button (id)
			end
			if select_actions_internal /= Void then	
				select_actions_internal.call (Void)
			end
		end

feature -- Status report
	
	is_selected: BOOLEAN
			-- Is `Current selected'?
	
feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON

feature {EV_TOOL_BAR_IMP} -- Status setting

	update_selected (new_is_selected: BOOLEAN) is
			-- Update the state of the selection according to
			-- Windows report.
		do
			is_selected := new_is_selected
		end

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

