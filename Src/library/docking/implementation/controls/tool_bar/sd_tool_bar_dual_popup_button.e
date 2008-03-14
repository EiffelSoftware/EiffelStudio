indexing
	description: "Toolbar button for SD_TOOL_BAR behave in the same way as SD_TOOL_BAR_BUTTON, but popup a widget if end user pressed at the end dropdown area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DUAL_POPUP_BUTTON

inherit
	SD_TOOL_BAR_POPUP_BUTTON
		export
			{ANY} select_actions
		redefine
			make,
			on_pointer_motion,
			on_pointer_release
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			Precursor
			select_actions.wipe_out
		end

feature -- Query

	is_dropdown_area: BOOLEAN
			-- If pointer hover in ending dropdown area?

feature {NONE} -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			-- Tool bar maybe void when CPU is busy on GTK.
			-- See bug#13102.
			if tool_bar /= Void then
				if has_position (a_relative_x, a_relative_y) and is_sensitive then
					if state = {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.hot
						is_need_redraw := True
					else
						is_need_redraw := False
					end

					-- Judge if pointer in the end dropdown area
					if dropdown_left < a_relative_x then
						if is_dropdown_area /= True then
							is_need_redraw := True
						end
						is_dropdown_area := True
					else
						if is_dropdown_area /= False then
							is_need_redraw := True
						end
						is_dropdown_area := False
					end
				else
					if state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.normal
						is_need_redraw := True
					else
						is_need_redraw := False
					end
				end
			end
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			if tool_bar /= Void and has_position (a_relative_x, a_relative_y) then
				if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
					state := {SD_TOOL_BAR_ITEM_STATE}.hot
					is_need_redraw := True
					if is_dropdown_area then
						on_select
					else
						select_actions.call (Void)
					end
				else
					is_need_redraw := False
				end
			end
		end

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
