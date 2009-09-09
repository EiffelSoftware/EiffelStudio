note
	description: "Toggle button on SD_TOOL_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
			-- Creation method
		do
			Precursor {SD_TOOL_BAR_BUTTON}
			last_state := state
		end

feature -- Query

	is_selected: BOOLEAN
			-- If current selected?
		do
			Result := state = {SD_TOOL_BAR_ITEM_STATE}.checked or state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked
		end

feature -- Command

	enable_select
			-- Enable select
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.checked
			last_state := state
			update
		end

	disable_select
			-- Disable select
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.normal
			last_state := state
			update
		end

feature {NONE} -- Agents

	on_pointer_press (a_relative_x, a_relative_y: INTEGER)
			-- Handle pointer press actions
		do
			-- We have to check `tool_bar /= Void', because on GTK plaforms, pointer press actions maybe delayed
			-- The action maybe called even after tool bar has been destroyed.
			-- See bug#13178			
			if attached tool_bar and then (has_position (a_relative_x, a_relative_y) and is_sensitive) then
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

	on_pointer_release (a_relative_x, a_relative_y: INTEGER)
			-- Handle pointer release actions
		do
			if is_sensitive then
				if tool_bar /= Void and then has_position (a_relative_x, a_relative_y) then
					if last_state = {SD_TOOL_BAR_ITEM_STATE}.hot or last_state = {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.hot_checked
						last_state := {SD_TOOL_BAR_ITEM_STATE}.checked
						is_need_redraw := True
						select_actions.call (Void)
					elseif last_state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked or last_state = {SD_TOOL_BAR_ITEM_STATE}.checked then
						state := {SD_TOOL_BAR_ITEM_STATE}.hot
						last_state := {SD_TOOL_BAR_ITEM_STATE}.normal
						is_need_redraw := True
						select_actions.call (Void)
					end
				else
					is_need_redraw := False
				end
			end
		end

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER)
			-- Handle pointer motion actions
		do
			if tool_bar /= Void then
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
		end

	on_pointer_leave
			-- Handle pointer leave actions
		do
			if state /= last_state then
				state := last_state
				is_need_redraw := True
			else
				is_need_redraw := False
			end
		end

feature {NONE} --Implementation

	last_state: INTEGER;
			-- Last button state

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
