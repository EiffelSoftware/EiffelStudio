note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM_IMP

inherit
	EV_HEADER_ITEM_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			width
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Create the tree item.
		do
			base_make (an_interface)
			create table_column.new
			cocoa_item := table_column
		end

	initialize
			-- Initialize the header item.
		do

		end

	handle_resize
			-- Call the appropriate actions for the header item resize
		do

		end

feature -- Access

	minimum_width: INTEGER
		-- Lower bound on `width' in pixels.

	minimum_height: INTEGER
		-- Lower bound on `width' in pixels.

	maximum_width: INTEGER
		-- Upper bound on `width' in pixels.

	user_can_resize: BOOLEAN
		-- Can a user resize `Current'?


	disable_user_resize
			-- Prevent `Current' from being resized by users.
		do

		end

	enable_user_resize
			-- Permit `Current' to be resized by users.
		do

		end

	is_dockable: BOOLEAN

feature -- Status setting

	set_text (a_text: STRING_GENERAL)
		do
			table_column.header_cell.set_string_value (create {NS_STRING}.make_with_string (a_text))
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			minimum_width := a_minimum_width
			if width < minimum_width then
				set_width (minimum_width)
			end
		end

	set_maximum_width (a_maximum_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			maximum_width := a_maximum_width
			if width > maximum_width then
				set_width (maximum_width)
			end
		end

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		do
			table_column.set_width (a_width)
		end

	width: INTEGER
		do
			Result := table_column.width.floor
		end

	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
			table_column.size_to_fit
		end

feature {EV_HEADER_IMP} -- Implementation

	table_column: NS_TABLE_COLUMN

feature {NONE} -- Implementation

	interface: EV_HEADER_ITEM;
		-- Interface object of `Current'.

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
