indexing
	description: "Tool bar separator for SD_TOOL_BAR_SEPARATOR."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_SEPARATOR

inherit
	SD_TOOL_BAR_ITEM
		redefine
			rectangle
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		local
			l_shared: SD_SHARED
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.normal
			is_sensitive := True
			is_displayed := True
			description := "SD_TOOL_BAR_SEPARATOR"
			create l_shared
			pixmap := l_shared.icons.default_icon
		end

feature -- Redefine Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
		end

	on_pointer_leave is
			-- Redefine
		do
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
		end

feature -- Redefine querys

	is_need_redraw: BOOLEAN is
			-- Redefine
		do
		end

	width: INTEGER is 6
			-- Redefine

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN is
			-- Redefine
		do
			Result := True
		end

	rectangle: EV_RECTANGLE is
			-- Redefine
		do
			if is_wrap then
				create Result.make (0, tool_bar.item_y (Current), tool_bar.minimum_width, width)
			else
				Result := Precursor {SD_TOOL_BAR_ITEM}
			end
		end

end
