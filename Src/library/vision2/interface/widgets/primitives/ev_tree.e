indexing
	description: "EiffelVision tree."
	status: "See notice at end of class"
	keywords: "tree, container"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE

inherit
	EV_PRIMITIVE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_NODE_LIST
		redefine
			is_in_default_state,
			implementation
		end

	EV_TREE_NODE_CONTAINER
		undefine
			off,
			index_of,
			has,
			occurrences,
			search,
			changeable_comparison_criterion,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

create
	default_create

feature -- Access

	selected_item: EV_TREE_NODE is
			-- Currently selected item.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end
		
	find_item_recursively_by_data (some_data: ANY): EV_TREE_NODE is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		do
			Result := implementation.find_item_recursively_by_data (some_data)
		end

feature -- Status report

	ensure_item_visible (an_item: EV_TREE_ITEM) is
			-- Ensure `tree_item' is visible in `Current'.
		require
			item_contained: has_recursively	(an_item)
		do
			implementation.ensure_item_visible (an_item)
		end
		

	selected: BOOLEAN is
			-- Is an item selected in `Current' ?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected
		end

	pixmaps_width: INTEGER is
			-- Width in pixels of pixmaps displayed in `Current'.
			-- Note: The default value is 16.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_width
		ensure
			bridge_ok: Result = implementation.pixmaps_width
		end

	pixmaps_height: INTEGER is
			-- Height in pixels of pixmaps displayed in `Current'.
			-- Note: The default value is 16.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_height
		ensure
			bridge_ok: Result = implementation.pixmaps_height
		end
		
	has_recursively (an_item: EV_TREE_ITEM): BOOLEAN is
			-- Is `an_item' contained in `Current' at any level?
		do
			Result := implementation.has_recursively (an_item)
		end
		
feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in `Current' to
			-- `a_width' by `a_height' pixels.
			-- Note: The Default value is 16x16.
		require
			not_destroyed: not is_destroyed
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			implementation.set_pixmaps_size (a_width, a_height)
		ensure
			width_set: pixmaps_width = a_width
			height_set: pixmaps_height = a_height
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_TREE_NODE_LIST} and
				Precursor {EV_TREE_NODE_CONTAINER}
		end
		
feature {EV_ANY_I} -- Implementation
	
	implementation: EV_TREE_I	
			-- Responsible for interaction with native graphics toolkit.
		
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_IMP} implementation.make (Current)
		end

end -- class EV_TREE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
