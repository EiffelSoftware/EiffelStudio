indexing
	description: "Eiffel Vision list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_I
	
inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- `Result is all items currently selected in `Current'.
		local
			original_position: INTEGER
		do
			original_position := interface.index
			create Result.make(2)
			from
				interface.start
			until
				interface.off
			loop
				if interface.item.is_selected then
					Result.extend (interface.item)
				end
				interface.forth
			end
			interface.go_i_th (original_position)
		end

feature -- Status report

	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_item' is visible in `Current'.
		deferred
		end

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		deferred
		end

	pixmaps_width: INTEGER
			-- Width of displayed pixmaps in `Current'.

	pixmaps_height: INTEGER
			-- Height of displayed pixmaps in `Current'.

feature -- Status setting

	enable_multiple_selection is
			-- Allow multiple items to be selected.
		deferred
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		deferred
		end

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in `Current' to
			-- `a_width' by `a_height'.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		end

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			-- Do nothing by default
		end

	initialize_pixmaps is
			-- Initialize `Current'.
		do
			pixmaps_width := default_pixmaps_width
			pixmaps_height := default_pixmaps_height
		end

	default_pixmaps_width: INTEGER is 16
		-- Default width for pixmaps

	default_pixmaps_height: INTEGER is 16
		-- Default height for pixmaps
	
feature {EV_LIST_I, EV_LIST_ITEM_IMP} -- Implementation

	interface: EV_LIST

end -- class EV_LIST_I

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

