note
	description: "Box container for display elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
			-- Initialize.
		do
			default_create
			set_default
		end

	make_without_borders
			-- Initialize.
			-- Box has no borders: use this to have a nice display
			-- when box is contained in another box. 
		do
			make
			disable_borders
		end

	set_default
			-- Initialize default values
		do
			set_padding (default_padding.item)
			set_border_width (default_border_width.item)
		end

feature -- Status report

	is_default_non_expand: BOOLEAN
			-- Can't elements be expanded by default?

feature -- Status setting

	enable_borders
			-- Display with borders.
		do
			set_border_width (default_border_width.item)
		end

	disable_borders
			-- Display without borders.
		do
			set_border_width (Minimum_spacing)
		end

	enable_padding
			-- Display with padding.
		do
			set_padding (default_padding.item)
		end

	disable_padding
			-- Display without padding.
		do
			set_padding (Minimum_spacing)
		end

	enable_default_expand
			-- Enable default element displays expansion.
		do
			is_default_non_expand := False
		ensure
			is_default_expand: not is_default_non_expand
		end

	disable_default_expand
			-- Disable default element displays expansion.
		do
			is_default_non_expand := True
		ensure
			is_default_non_expand: is_default_non_expand
		end

feature -- Basic operations

	extend (widget: EV_WIDGET)
			-- Add `widget' to end of structure.
		do
			Precursor (widget)
			if is_default_non_expand then
				disable_item_expand (widget)
			end
		end

	extend_cell
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

	extend_separator
			-- Add a non-expandable separator to end
			-- of structure.
		deferred
		end

	set_default_border_width (new_border_width: INTEGER)
			-- Set `new_border_width' as default border width.
		do
			default_border_width.set_item (new_border_width)
			enable_borders
		end

	set_default_padding (new_padding: INTEGER)
			-- Set `new_padding' as default padding.
		do
			default_padding.set_item (new_padding)
			enable_padding
		end

feature {NONE} -- Implementation

	default_border_width: INTEGER_REF
			-- Default border width.
		once
			create Result
			Result.set_item (Minimum_spacing) --FIXME: Is it needed?
		end

	default_padding: INTEGER_REF
			-- Default padding.
		once
			create Result
			Result.set_item (Minimum_spacing) --FIXME: Is it needed?
		end

	Minimum_spacing: INTEGER = 0;
			-- Minimum spacing for a box.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_BOX



