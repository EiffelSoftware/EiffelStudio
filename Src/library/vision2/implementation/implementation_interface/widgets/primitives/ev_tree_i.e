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

	EV_TREE_ACTION_SEQUENCES_I

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
				-- Set default width & height for the pixmaps
			pixmaps_width := 16
			pixmaps_height := 16
		end

feature -- Access

	selected_item: EV_TREE_NODE is
			-- Currently selcted tree item.
		deferred
		end

feature -- Status report

	ensure_item_visible (an_item: EV_TREE_ITEM) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		deferred
		end

	selected: BOOLEAN is
			-- Is at least one tree item selected?
		require
		deferred
		end

	pixmaps_width: INTEGER
			-- Width of pixmaps displayed in `Current'.

	pixmaps_height: INTEGER
			-- Height of pixmaps displayed in `Current'.

feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of pixmaps displayed in `Current' to
			-- `a_width', `a_height' in pixels.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		end

feature {EV_ANY_I} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| Do nothing by default
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

