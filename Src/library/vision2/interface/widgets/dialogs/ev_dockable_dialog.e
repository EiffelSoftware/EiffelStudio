indexing
	description: "[
			Dialogs that are created by the Vision2 docking mechanism when
			an EV_DOCKABLE_SOURCE is dropped while not over a valid EV_DOCKABLE_TARGET.
			The transported component will be inserted into `Current', and when `Current'
			is destroyed, it will be restored back to its original position before the
			transport began.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DOCKABLE_DIALOG
	
inherit
	EV_DIALOG
		export
			{EV_DOCKABLE_SOURCE_I} close_request_actions
		end

feature -- Access

	original_parent: EV_DOCKABLE_TARGET
			-- Original parent of `item' before it was
			-- dragged out.
			
	original_parent_index: INTEGER
			-- Original index of `item' in parent before it was
			-- dragged out.
			
	expansion_was_disabled: BOOLEAN
		-- Was `item' originally disabled in `original_parent'? This
		-- may only be True if `original_parent' is an EV_BOX.

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	set_original_parent (an_original_parent: EV_DOCKABLE_TARGET) is
			-- Assign `an_original_parent' to `original_parent'.
		do
			original_parent := an_original_parent
		end
		
	set_original_parent_index (an_index: INTEGER) is
			-- Assign `an_index' to `original_parent_index'.
		do
			original_parent_index := an_index
		end
		
	set_expansion_was_disabled is
			-- Assign `True' to `expansion_was_disabled'.
		do
			expansion_was_disabled := True
		end

end -- class EV_DOCKABLE_DIALOG

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