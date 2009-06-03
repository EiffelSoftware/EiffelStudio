note
	description:
		"Eiffel Vision tool bar separator. Mswindows implemenatation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		undefine
			parent
		redefine
			interface
		end

	EV_TOOL_BAR_ITEM_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_id
		end

	initialize
			-- Do post creation initialization.
		do
			set_is_initialized (True)
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

	width: INTEGER
			-- Horizontal size in pixels.
		do
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
		end

feature {NONE} -- Implementation

	parent_imp: EV_TOOL_BAR_IMP
		-- The parent of `Current'.

	set_parent_imp (a_parent_imp: like parent_imp)
			-- Make `a_parent_imp' the new parent of `Current'.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
				parent_imp.auto_size
			else
				parent_imp := Void
			end
		end

	text: STRING_32
			-- Text displayed in textable.
			-- For separators, it must always be empty.
		do
			Result := ""
		end

	has_pixmap: BOOLEAN = False
			-- Has Current a pixmap?

	set_pixmap_in_parent
			-- Add the pixmap to the parent by updating the
			-- parent's image list.
		do
			check
				not_called: False
			end
		end

	is_sensitive: BOOLEAN = True
			-- Is `Current' sensitive?

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Nothing to do here.
		end

	disable_sensitive
			-- Enable `Current'.
		do
			-- Nothing to do here.
		end

	enable_sensitive
			-- Disable `Current'.
		do
			-- Nothing to do here.
		end

	internal_non_sensitive: BOOLEAN = True
			-- Is `Current' not sensitive to input as seen
			-- from `interface'?

	restore_private_pixmaps
			-- When `Current' is parented, `private_pixmap' and
			-- `private_gray_pixmap' are assigned Void. This is to stop
			-- us keeping to many references to GDI objects. When
			-- `Current' is removed from its parent, we must then
			-- restore them.
		do
			-- Nothing to do here.
		end


feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_SEPARATOR

invariant
	no_pixmap: has_pixmap = False
	image_index_zero: image_index = 0

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




end -- class EV_TOOL_BAR_SEPARATOR_IMP

