indexing
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
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Create the tree item.
		do
			base_make (an_interface)
			create {NS_BOX}cocoa_item.new
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

	minimum_width: INTEGER is 10
		-- Lower bound on `width' in pixels.

	minimum_height: INTEGER is 10
		-- Lower bound on `width' in pixels.

	maximum_width: INTEGER is 10
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

	set_maximum_width (a_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do

		end

	set_minimum_width (a_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do

		end

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		do

		end

	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do

		end

feature {NONE} -- Implementation

	interface: EV_HEADER_ITEM;
		-- Interface object of `Current'.

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
