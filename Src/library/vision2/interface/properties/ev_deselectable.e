indexing
	description:
		"Abstraction for objects that may be selected/unselected."
	status: "See notice at end of class"
	keywords: "deselect, deselectable, select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DESELECTABLE

inherit
	EV_SELECTABLE
		redefine
			implementation,
			is_in_default_state
		end
	
feature -- Status setting

	disable_select is
			-- Deselect the object.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_select
		ensure
			unselected: not is_selected
		end
		
	toggle is
			-- Change `is_selected'.
		require
			not_is_destroyed: not is_destroyed
			can_be_selected: not is_selected implies is_selectable
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		ensure
			is_selected_changed: is_selected /= old is_selected
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_SELECTABLE} and not is_selected 
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_DESELECTABLE_I
			-- Responsible for interaction with native graphics toolkit.
			
invariant

	not_selectable_therefore_not_selected: not is_selectable implies not is_selected
		-- Some descendents of deselectable may only be selected when parented. This is
		-- any descendent in which the parent can be in a single selection mode, to combat the
		-- problem of adding two selected items, we have this assertion, so these items
		-- cannot be selected unless they are parented.
		

end -- class EV_DESELECTABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

