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
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization
	carbon_arrange_children
			do

			end


	needs_event_box: BOOLEAN = False

	make (an_interface: like interface)
			-- Create the tree item.
		do

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

	width: INTEGER
			-- Width of `Current' in pixels.

	minimum_width: INTEGER
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

feature -- PND

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
		end

	enable_transport
			-- Enable PND transport
		do

		end

	disable_transport
			-- Disable PND transport
		do

		end

	draw_rubber_band
		do

		end

	erase_rubber_band
		do

		end

	enable_capture
		do

		end

	disable_capture
		do

		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
        	-- Start PND transport (not needed)
		do

		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
			-- End PND transport (not needed)
		do

		end

	set_pointer_style, internal_set_pointer_style (curs: EV_POINTER_STYLE)
			-- Set 'pointer_style' to 'curs' (not needed)
		do

		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
		end

	height: INTEGER
			-- Height in pixels.
		do
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
		end

feature {EV_HEADER_IMP} -- Implementation

	set_parent_imp (par_imp: like parent_imp)
			-- Set `parent_imp' to `par_imp'.
		do

		end

	item_event_id: INTEGER
		-- Item event id of `Current'

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'

feature {NONE} -- Implementation

	default_box_height: INTEGER
			-- Default height of the box.
		once

		end

	tree_view_column_width: INTEGER
			-- `Result' is width of `Current' used
			-- while parented.
		do

		end

	box: POINTER
		-- Box to hold column text and pixmap.

	create_drop_actions: EV_PND_ACTION_SEQUENCE
		do


		end

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE
		do

		end

feature {NONE} -- Implementation

	destroy
			-- Destroy `c_object'.
		do

		end

	interface: EV_HEADER_ITEM;
		-- Interface object of `Current'.

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end
