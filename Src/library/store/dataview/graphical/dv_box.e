indexing
	description: "Box container for display elements"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_BOX

inherit
	EV_BOX
		redefine
			extend
		end

feature -- Initialization

	make is
			-- Initialize.
		do
			default_create
			set_default
		end

	make_without_borders is
			-- Initialize.
			-- Box has no borders: use this to have a nice display
			-- when box is contained in another box. 
		do
			make
			disable_borders
		end

	set_default is
			-- Initialize default values
		do
			set_padding (default_padding.item)
			set_border_width (default_border_width.item)
		end

feature -- Status report

	is_default_non_expand: BOOLEAN
			-- Can't elements be expanded by default?

feature -- Status setting

	enable_borders is
			-- Display with borders.
		do
			set_border_width (default_border_width.item)
		end

	disable_borders is
			-- Display without borders.
		do
			set_border_width (Minimum_spacing)
		end

	enable_padding is
			-- Display with padding.
		do
			set_padding (default_padding.item)
		end

	disable_padding is
			-- Display without padding.
		do
			set_padding (Minimum_spacing)
		end

	enable_default_expand is
			-- Enable default element displays expansion.
		do
			is_default_non_expand := False
		ensure
			is_default_expand: not is_default_non_expand
		end

	disable_default_expand is
			-- Disable default element displays expansion.
		do
			is_default_non_expand := True
		ensure
			is_default_non_expand: is_default_non_expand
		end

feature -- Basic operations

	extend (widget: EV_WIDGET) is
			-- Add `widget' to end of structure.
		do
			Precursor (widget)
			if is_default_non_expand then
				disable_item_expand (widget)
			end
		end

	extend_cell is
			-- Add a cell, i.e. an empty display element,
			-- to end of structure.
		local
			cell: EV_CELL
		do
			create cell
			extend (cell)
			if is_default_non_expand then
				enable_item_expand (cell)
			end
		end

	extend_separator is
			-- Add a non-expandable separator to end
			-- of structure.
		deferred
		end

	set_default_border_width (new_border_width: INTEGER) is
			-- Set `new_border_width' as default border width.
		do
			default_border_width.set_item (new_border_width)
			enable_borders
		end

	set_default_padding (new_padding: INTEGER) is
			-- Set `new_padding' as default padding.
		do
			default_padding.set_item (new_padding)
			enable_padding
		end

feature {NONE} -- Implementation

	default_border_width: INTEGER_REF is
			-- Default border width.
		once
			create Result
			Result.set_item (Minimum_spacing) --FIXME: Is it needed?
		end

	default_padding: INTEGER_REF is
			-- Default padding.
		once
			create Result
			Result.set_item (Minimum_spacing) --FIXME: Is it needed?
		end

	Minimum_spacing: INTEGER is 0;
			-- Minimum spacing for a box.

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_BOX



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

