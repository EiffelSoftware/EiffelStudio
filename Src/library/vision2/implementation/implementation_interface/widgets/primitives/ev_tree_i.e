indexing
	description:
		"EiffelVision Tree. Implementation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_TREE_NODE_LIST_I
		redefine
			interface
		end
		
	EV_ITEM_PIXMAP_SCALER_I
		redefine
			interface
		end

	EV_TREE_ACTION_SEQUENCES_I

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
				-- Set default width & height for the pixmaps
			initialize_pixmaps
		end

feature -- Access

	selected_item: EV_TREE_NODE is
			-- Currently selected tree item.
		deferred
		end

feature -- Status report

	ensure_item_visible (an_item: EV_TREE_NODE) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		deferred
		end

	selected: BOOLEAN is
			-- Is at least one tree item selected?
		deferred
		end
		
feature {EV_ANY_I}

	interface: EV_TREE

end -- class EV_TREE_I

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

