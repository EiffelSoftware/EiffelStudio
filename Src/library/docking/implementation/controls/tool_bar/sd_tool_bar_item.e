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
			is_destroyed,
			drop_actions
		end

feature -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion.
		deferred
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion for tooltip setting.
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

	is_need_redraw: BOOLEAN
			-- Redefine

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

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Redefine
		do
			if internal_drop_actions = Void then
				create internal_drop_actions
			end
			Result := internal_drop_actions
		end

feature -- Properties

	tool_bar: SD_TOOL_BAR
			-- Tool bar which Current button belong to.

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

	name: STRING
			-- Name which is used for store configuration

	set_name (a_name: STRING) is
			-- Set `name'
		require
			not_void: a_name /= Void
		do
			name := a_name
		ensure
			set: name = a_name
		end

feature {NONE} -- Implementation

	update is
			-- Redraw Current
		do
			is_need_redraw := True
			if tool_bar /= Void then
--				check has: tool_bar.has (Current) end
				tool_bar.update
			end
		end

feature {SD_TOOL_BAR} -- Internal issues

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			--  Update for pick and drop.
		require
			not_void: a_starting implies a_pebble /= Void
		deferred
		end

	create_implementation is
			-- Fack function.
		do
		end

	disable_redraw is
			-- Set `is_need_redraw' False.
		do
			is_need_redraw := False
		end

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Set `tool_bar'.
		do
			tool_bar := a_tool_bar
		ensure
			set: tool_bar = a_tool_bar
		end

feature {NONE} -- Implementation

	internal_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Drop actions.

invariant
	not_void: name /= Void

end
