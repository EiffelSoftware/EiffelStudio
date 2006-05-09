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

feature -- Query

	is_selected: BOOLEAN is
			-- If current selected?
		do
			Result := state = {SD_TOOL_BAR_ITEM_STATE}.checked
		end

feature -- Command

	enable_select is
			-- Enable select.
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.checked
			last_state := state
			update
		end

	disable_select is
			-- Disable select
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.normal
			last_state := state
			update
		end

feature {NONE} -- Agents
	
	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer press actions.
		do
			if has_position (a_relative_x, a_relative_y) and is_sensitive then
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
			if is_sensitive then
				if has_position (a_relative_x, a_relative_y) then
					if last_state = {SD_TOOL_BAR_ITEM_STATE}.hot or last_state = {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.hot_checked
						last_state := {SD_TOOL_BAR_ITEM_STATE}.checked
						is_need_redraw := True
						select_actions.call ([])
					elseif last_state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked or last_state = {SD_TOOL_BAR_ITEM_STATE}.checked then
						state := {SD_TOOL_BAR_ITEM_STATE}.hot
						last_state := {SD_TOOL_BAR_ITEM_STATE}.normal
						is_need_redraw := True
						select_actions.call ([])
					end
				else
					is_need_redraw := False
				end
			end
		end

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion actions.
		do
			if has_position (a_relative_x, a_relative_y) and is_sensitive then
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
