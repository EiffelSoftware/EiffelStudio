indexing
	description: "Objects that represent the global history of the layout."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GLOBAL_HISTORY
	
inherit
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end

feature -- Access

	history_dialog: GB_HISTORY_DIALOG is
			-- The history dialog of the application.
			-- We must keep this updated when command list changes.
		once
			create result
		ensure
			Result /= Void
		end

	command_list: ARRAYED_LIST [GB_COMMAND] is
			-- All commands currently referenced by
			-- the history.
		once
			create result.make (0)
		ensure
			Result /= Void
		end
		
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
			history_dialog.add_command_representation (a_command.textual_representation)
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
			System_status.enable_project_modified
			command_handler.update
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
				history_dialog.remove_selection
				set_current_position (-1)
			else
				history_dialog.select_item (current_position + 1)
			end
			
				-- Update modified status of project.
			System_status.enable_project_modified
			command_handler.update
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
			history_dialog.select_item (current_position + 1)
			
				-- Update modified status of project.
			System_status.enable_project_modified
			command_handler.update
		end
		
	cut_off_at_current_position is
			-- Remove all items from the history from
			-- `current_position' onwards.
		do
				-- We need to handle the case where we are at the very start
				-- of the history specially.
			if current_position = -1 then
				command_list.wipe_out
				history_dialog.remove_all_items
			elseif current_position < command_list.count then
				from
					command_list.go_i_th (current_position + 1)
				until
					command_list.off
				loop
					command_list.remove
				end
					-- Update the display in the history_dialog also.
				history_dialog.remove_items_from_position (current_position + 2)
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
			history_dialog_empty: history_dialog.history_list.count = 1
		end
		

	current_position: INTEGER is
			-- Position `Current' refers to.
			-- i.e. as users step forewards or backwards in
			-- the history, this points to where they are.
		do
			Result := internal_current_position.item
		end

feature {GB_HISTORY_DIALOG} -- Status setting
		
	set_current_position (a_value: INTEGER) is
			-- Assign `a_value' to `current_position'.
		require
			position_valid: a_value >= -1 and a_value <= command_list.count
		do
			internal_current_position.set_item (a_value)
		ensure
			current_position_set: internal_current_position.item = a_value
		end
	
feature {NONE} -- Implementation

	internal_current_position: INTEGER_REF is
			-- The implementation for `current_position'.
		once
			create Result
		end
		
end -- class GLOBAL_HISTORY
