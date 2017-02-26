note
	description: "Common ancestor for docking tool bars."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_GENERIC_TOOL_BAR

feature -- Docking query

	item_at_position (a_screen_x, a_screen_y: INTEGER_32): detachable SD_TOOL_BAR_ITEM
			-- Item at `a_screen_x', `a_screen_y'
			-- Result may be void when tool bar wraps.
		require
			in_position: is_item_position_valid (a_screen_x, a_screen_y)
		deferred
		end

	items_have_texts: BOOLEAN
			-- If any item has text?
		deferred
		end

	content: detachable SD_TOOL_BAR_CONTENT
			-- Related tool bar content.
		deferred
		end

	items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- Visible items
		deferred
		ensure
			not_void: Result /= Void
		end

	is_need_calculate_size: BOOLEAN
			-- Need recalcualte current `row_height' because of something have been changed?
		deferred
		end

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- If Current has `a_item' ?
		deferred
		end

	is_item_valid (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- If `a_item' valid?
		deferred
		end

	is_parent_set (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- If `a_item' parent set?
		deferred
		end

	is_item_position_valid (a_screen_x, a_screen_y: INTEGER_32): BOOLEAN
			-- If `a_screen_x' and `a_screen_y' within tool bar items area?
		deferred
		end

	padding_width: INTEGER
			-- Padding width
		deferred
		end

feature -- Vision2 query

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.
		deferred
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is released.
		deferred
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.
		deferred
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.
		deferred
		end

	minimum_width: INTEGER
			-- Lower bound on `width' in pixels.
		deferred
		end

	minimum_height: INTEGER
			-- Lower bound on `height' in pixels.
		deferred
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
		deferred
		end

	is_destroyed: BOOLEAN
			-- Is `Current' no longer usable?
		deferred
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		deferred
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		deferred
		end

	width: INTEGER
			-- Horizontal size in pixels.
			-- Same as `minimum_width' when not displayed.
		deferred
		end

	height: INTEGER
			-- Vertical size in pixels.
			-- Same as `minimum_height' when not displayed.
		deferred
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.
			-- If `Result' is empty then no tooltip displayed.
		deferred
		end

	has_capture: BOOLEAN
			-- Does widget have capture?
		deferred
		end

feature -- Docking command

	extend (a_item: SD_TOOL_BAR_ITEM)
			-- Extend `a_item' to the end.
		require
			not_void: a_item /= Void
			valid: is_item_valid (a_item)
		deferred
		ensure
			has: has (a_item)
			is_parent_set: is_parent_set (a_item)
		end

	force (a_item: SD_TOOL_BAR_ITEM; a_index: INTEGER)
			-- Assign item `a_item' to `a_index'-th entry.
			-- Always applicable: resize the array if `a_index' falls out of
			-- currently defined bounds; preserve existing items.
		require
			not_void: a_item /= Void
			valid: is_item_valid (a_item)
		deferred
		end

	prune (a_item: SD_TOOL_BAR_ITEM)
			-- Prune `a_item'
		deferred
		end

	compute_minimum_size
			-- Compute `minmum_width' and `minimum_height'
		deferred
		end

	set_need_calculate_size (a_bool: BOOLEAN)
			-- Set if need recalculate `row_height'
		deferred
		ensure
			a_bool_set: is_need_calculate_size = a_bool
		end

	update_size
			-- Update `tool_bar' size if Current width changed
		deferred
		end

feature {SD_TOOL_BAR_ITEM, SD_GENERIC_TOOL_BAR, SD_TOOL_BAR_ZONE_ASSISTANT, SD_FLOATING_TOOL_BAR_ZONE, SD_TOOL_BAR_ZONE} -- Docking internal command and query

	update
			-- Redraw item(s) when `is_need_redraw'
		deferred
		end

	remove_tooltip
			-- Make `tooltip' empty.
		deferred
		end

	item_x (a_item: SD_TOOL_BAR_ITEM): INTEGER
			-- Relative x position of `a_item'
		require
			has: has (a_item)
		deferred
		end

	item_y (a_item: SD_TOOL_BAR_ITEM): INTEGER
			-- Relative y position of `a_item'
		require
			has: has (a_item)
		deferred
		end

	start_x: INTEGER
			-- `internal_start_x'
		deferred
		end

	start_y: INTEGER
			-- `internal_start_y'
		deferred
		end

	set_start_x (a_start_x: INTEGER)
			-- Set start x position with `a_x'
		deferred
		ensure
			set: is_start_x_set (a_start_x)
		end

	set_start_y (a_start_y: INTEGER)
			-- Set start y position with `a_y'
		deferred
		ensure
			set: is_start_y_set (a_start_y)
		end

	is_start_x_set (a_x: INTEGER): BOOLEAN
			-- If `a_x' equal `start_x' of `tool_bar'?
		deferred
		end

	is_start_y_set (a_y: INTEGER): BOOLEAN
			-- If `a_y' equal `start_y' of `tool_bar'?
		deferred
		end

	all_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- All items
		deferred
		ensure
			not_void: Result /= Void
		end

	row_height: INTEGER
			-- Height of row
		deferred
		ensure
			valid: is_row_height_valid (Result)
		end

	set_row_height (a_height: INTEGER)
			-- Assign `a_height' to `row_height'
		deferred
		ensure
			set: row_height = a_height
		end

	standard_height: INTEGER
			-- Standard tool bar height
		deferred
		end

	is_row_height_valid (a_height: INTEGER): BOOLEAN
			-- If `a_height' valid?
		deferred
		end

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		deferred
		end

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when an area needs to be redrawn.
		deferred
		end

feature -- Vision2 command

	set_tooltip (a_tooltip: READABLE_STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		deferred
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER_32)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		deferred
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER_32)
			-- Call `expose_actions' for rectangle described with upper-left
			-- corner on (`a_x', `a_y') with size `a_width' and `a_height' when next idle.
		deferred
		end

	enable_capture
			-- Enable capture
		deferred
		end

	disable_capture
			-- Disable capture
		deferred
		end

	wipe_out
			-- Wipe out
		deferred
		end

	destroy
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		deferred
		end

	object_id: INTEGER
			-- Unique for current object in any given session
		deferred
		end

	set_pointer_style (a_style: EV_POINTER_STYLE)
			-- Assign `a_style' to pointer style.
		deferred
		end

feature {SD_WIDGET_TOOL_BAR, SD_TOOL_BAR_ZONE} -- Implementation

	set_content (a_content: SD_TOOL_BAR_CONTENT)
			-- Set `content' with `a_content'
		require
			not_void: a_content /= Void
		deferred
		ensure
			content_set: content = a_content
		end

	clear_content
			-- Remove `content'
		deferred
		end

	internal_shared: SD_SHARED
			-- All singletons
		deferred
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
