indexing
	description: "Objects that represent the global history of the layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GLOBAL_HISTORY

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create command_list.make (0)
			create change_actions
		ensure
			components_set: components = a_components
		end

feature -- Access

	command_list: ARRAYED_LIST [GB_COMMAND]
			-- All commands currently referenced by
			-- the history.

	is_empty: BOOLEAN is
			-- Is the history empty?
		do
			Result := command_list.is_empty
		end

feature -- Basic operation

	add_command (a_command: GB_COMMAND) is
			-- Add `a_command' to `command_list'.
		require
			command_not_void: a_command /= Void
		do
			command_list.force (a_command)
			components.tools.history_dialog.add_command_representation (a_command.textual_representation)
			set_current_position (command_list.count)
		ensure
			command_added: command_list.has (a_command)
			current_position = (command_list.count)
		end

	step_from (start, finish: INTEGER) is
			-- Step through history from position `start' until
			-- position `finish'.
		require
			start_valid: start >=0 and start <= command_list.count
			finish_valid: finish >=0 and finish <= command_list.count
		local
			counter: INTEGER
		do
			if start > finish then
				from
					counter := start
				until
					counter = finish
				loop
					(command_list @ counter).undo
					counter := counter - 1
				end
			else
				from
					counter := start
				until
					counter > finish
				loop
					(command_list @ counter).execute
					counter := counter + 1
				end
			end
			set_current_position (finish)
				-- Update modified status of project.
			components.system_status.mark_as_dirty
		ensure
			current_position = finish
		end

	undo is
			-- Undo command in `command_list' at `current_position'.
			-- Update user interface to reflect these events.
		do
			(command_list @ current_position).undo
			set_current_position (current_position - 1)
			if current_position = -1 then
				components.tools.history_dialog.remove_selection
				set_current_position (-1)
			else
				components.tools.history_dialog.select_item (current_position + 1)
			end

				-- Update modified status of project.
			components.system_status.mark_as_dirty
		end

	redo is
			-- Redo command in `command_list' at `current_position'.
			-- Update user interface to reflace these events.
		do
			if current_position = -1 then
				set_current_position (current_position + 1)
			end

			(command_list @ (current_position + 1)).execute
			set_current_position (current_position + 1)
				-- Update undo/redo buttons.
			components.tools.history_dialog.select_item (current_position + 1)

				-- Update modified status of project.
			components.system_status.mark_as_dirty
		end

	cut_off_at_current_position is
			-- Remove all items from the history from
			-- `current_position' onwards.
		do
				-- We need to handle the case where we are at the very start
				-- of the history specially.
			if current_position = -1 then
				command_list.wipe_out
				components.tools.history_dialog.remove_all_items
			elseif current_position < command_list.count then
				from
					command_list.go_i_th (current_position + 1)
				until
					command_list.off
				loop
					command_list.remove
				end
					-- Update the display in the history_dialog also.
				components.tools.history_dialog.remove_items_from_position (current_position + 2)
			end
		end

	wipe_out is
			-- Clear the complete history.
		do
			set_current_position (-1)
			cut_off_at_current_position
				--| FIXME This seems a little strange, but seems to be required
				--| when closing a project with an open history window
				--| containing some history.
				--| If we do not do this, then when we open the next project the
				--| redo button is sensitive, which is not allowed. Julian.
			set_current_position (0)
		ensure
			history_empty: command_list.is_empty
			history_dialog_empty: components.tools.history_dialog.history_list.count = 1
		end


	current_position: INTEGER
			-- Position `Current' refers to.
			-- i.e. as users step forewards or backwards in
			-- the history, this points to where they are.

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- `Result' is an action sequence fired each time
			-- the position in the history changes.

feature {GB_HISTORY_DIALOG} -- Status setting

	set_current_position (a_value: INTEGER) is
			-- Assign `a_value' to `current_position'.
		require
			position_valid: a_value >= -1 and a_value <= command_list.count
		do
			current_position := a_value
			change_actions.call (Void)
		ensure
			current_position_set: current_position = a_value
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GLOBAL_HISTORY
