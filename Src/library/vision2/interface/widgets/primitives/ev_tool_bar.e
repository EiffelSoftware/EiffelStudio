indexing
	description:
		"EiffelVision toolbar. Can only contain tool bar items."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR

inherit
	EV_PRIMITIVE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end
		
	EV_DOCKABLE_TARGET
		undefine
			is_equal,
			is_in_default_state
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_LIST [EV_TOOL_BAR_ITEM]
		redefine
			is_in_default_state,
			implementation
		end

create
	default_create
	
feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of `Current'.
		do
			create {EV_TOOL_BAR_IMP} implementation.make (Current)
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST}
		end
		
	is_parent_recursive (a_tool_bar_item: EV_TOOL_BAR_ITEM): BOOLEAN is
			-- Is `a_tool_bar_item' a parent of `Current'?
		do
				-- As we cannot insert an EV_TOOL_BAR into an EV_TOOL_BAR_ITEM,
				-- it cannot be True.
			Result := False
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_I
			-- Platform dependent access.

end -- class EV_TOOL_BAR

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

