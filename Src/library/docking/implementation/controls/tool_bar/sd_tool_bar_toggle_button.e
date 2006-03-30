indexing
	description: "Toggle button on SD_TOOL_BAR."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_TOGGLE_BUTTON

inherit
	SD_TOOL_BAR_BUTTON
		redefine
			make,
			on_pointer_press,
			on_pointer_release,
			on_pointer_motion,
			on_pointer_leave
		end

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method
		do
			Precursor {SD_TOOL_BAR_BUTTON}
			last_state := state
		end

feature {NONE} -- Agents

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer press actions.
		do
			if has_position (a_relative_x, a_relative_y) then
				if state = {SD_TOOL_BAR_ITEM_STATE}.hot then
					last_state := state
				elseif state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked  then
					last_state := state
				end
				state := {SD_TOOL_BAR_ITEM_STATE}.pressed
				is_need_redraw := True
			else
				is_need_redraw := False
			end
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer release actions.
		do
			if has_position (a_relative_x, a_relative_y) then
				if last_state = {SD_TOOL_BAR_ITEM_STATE}.hot then
					state := {SD_TOOL_BAR_ITEM_STATE}.checked
					last_state := state
					is_need_redraw := True
				elseif last_state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
					state := {SD_TOOL_BAR_ITEM_STATE}.normal
					last_state := state
					is_need_redraw := True
				end
			else
				is_need_redraw := False
			end
		end

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion actions.
		do
			if has_position (a_relative_x, a_relative_y) then
				if state = {SD_TOOL_BAR_ITEM_STATE}.normal then
					state := {SD_TOOL_BAR_ITEM_STATE}.hot
					is_need_redraw := True
				elseif state = {SD_TOOL_BAR_ITEM_STATE}.checked then
					state := {SD_TOOL_BAR_ITEM_STATE}.hot_checked
					is_need_redraw := True
				else
					is_need_redraw := False
				end
			else
				if state /= last_state then
					state := last_state
					is_need_redraw := True
				else
					is_need_redraw := False
				end
			end
		end

	on_pointer_leave is
			-- Handle pointer leave actions.
		do
			if state /= last_state then
				state := last_state
				is_need_redraw := True
			else
				is_need_redraw := False
			end
		end

feature {NONE} --Implementation

	last_state: INTEGER
			-- Last button state.

end
