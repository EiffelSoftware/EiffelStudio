indexing
	description: "EiffelVision toolbar. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
		
	EV_DOCKABLE_TARGET_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_TOOL_BAR_ITEM]
		redefine
			interface
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	insertion_position: INTEGER is
			-- `Result' is index of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button.
		deferred
		end
		
	block_selection_for_docking is
			-- Ensure that a tool bar button is not selected as a
			-- result of the transport ending.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_I

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

