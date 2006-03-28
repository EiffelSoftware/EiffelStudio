indexing
	description: "Tool bar items for SD_TOOL_BAR"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_TOOL_BAR_ITEM

inherit
	EV_ITEM
		redefine
			pixmap,
			set_pixmap,
			is_destroyed
		end

feature -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion.
		deferred
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer press.
		deferred
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer leave.
		deferred
		end

	on_pointer_leave is
			-- Handle pointer leave.
		deferred
		end

feature -- Query

	is_need_redraw: BOOLEAN is
			-- Do Current need redraw?
		deferred
		end

	width: INTEGER is
			-- Width of Current item.
		deferred
		end

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN is
			-- If `a_rect' inlcude Current?
		require
			not_void: a_rect /= Void
		deferred
		end

	state: INTEGER
			-- State to draw for`item'.
			-- One value from SD_TOOL_BAR_ITEM_STATE

	is_sensitive: BOOLEAN
			-- If Current sensitive?

	rectangle: EV_RECTANGLE is
			--  Button rectangle area
		do
			create Result.make (tool_bar.item_x (Current), tool_bar.item_y (Current), width, tool_bar.row_height)
		ensure
			not_void: Result /= Void
		end

feature -- Properties

	tool_bar: SD_TOOL_BAR
			-- Tool bar which Current button belong to.

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Set `tool_bar'.
		require
			not_void: a_tool_bar /= Void
		do
			tool_bar := a_tool_bar
		ensure
			set: tool_bar = a_tool_bar
		end

	set_wrap (a_wrap: BOOLEAN) is
			-- Set `wrap'
		do
			is_wrap := a_wrap
		ensure
			set: is_wrap = a_wrap
		end

	is_wrap: BOOLEAN
			-- If Current is wrap state?
			-- If it's wrap, then Current's next button will go to next line.	

	is_displayed: BOOLEAN
			-- If it is displayed on SD_TOOL_BAR_ZONE.

	description: STRING
			-- Description when use SD_TOOL_BAR_CUSTOMIZE_DIALOG to customize SD_TOOL_BAR.

	set_description (a_description: STRING) is
			-- Set `description'
		require
			not_void: a_description /= Void
		do
			description := a_description
		ensure
			set: description = a_description
		end

	enable_displayed is
			-- Enable `is_displayed'.
		do
			is_displayed := True
		end

	disable_displayed is
			-- Disable `is_displayed'
		do
			is_displayed := False
		end

	is_destroyed: BOOLEAN is False
			-- There is no under native widget for Current.
			-- So, it'll never destroyed.

	pixmap: EV_PIXMAP
			-- Pixmap shown on Current.

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap'
		do
			pixmap := a_pixmap
		end

feature {NONE} -- Implementation

	create_implementation is
			-- Fack function.
		do
		end

end
