indexing	
	description: 
		"Eiffel Vision item. Implementation interface."
	status: "See notice at end of class"
	keywords: "item"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_I

inherit
	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_I

feature -- Access

	parent: EV_ITEM_LIST [EV_ITEM] is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
				check 
					parent_not_void: Result /= Void
				end
			end
		end

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_I

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

