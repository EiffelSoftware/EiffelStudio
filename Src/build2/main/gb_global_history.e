indexing
	description: "Objects that represent the global history of the layout."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GLOBAL_HISTORY


feature -- Access

	command_list: ARRAYED_LIST [GB_COMMAND] is
			--
		once
			create result.make (0)
		ensure
			Result /= Void
		end
		
	dialog: GB_HISTORY_DIALOG is
			-- The history dialog of the application.
			-- We must keep this updated when command list changes.
		once
			create result
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
			dialog.add_command_representation (a_command.textual_representation)
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
		ensure
			current_position = finish
		end
		
	undo is
			-- Undo command in `command_list' at `current_position'.
			-- Update user interface to reflect these events.
		do
			(command_list @ current_position).undo
			set_current_position (current_position - 1)
			if current_position = 0 then
				dialog.remove_selection
				set_current_position (-1)
			else
				dialog.select_item (current_position)
			end
			--| FIXME may need to call update all commands here.
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
			dialog.select_item (current_position)
			--| FIXME may need to update all command here.
		end
		
	cut_off_at_current_position is
			-- Remove all items from the history from
			-- `current_position' onwards.
		do
				-- We need to handle the case where we are at the very start
				-- of the history specially.
			if current_position = -1 then
				command_list.wipe_out
				dialog.remove_all_items
			elseif current_position < command_list.count then
				from
					command_list.go_i_th (current_position + 1)
				until
					command_list.off
				loop
					command_list.remove
				end
					-- Update the display in the dialog also.
				dialog.remove_items_from_position (current_position + 1)
			end
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
		do
			internal_current_position.set_item (a_value)
		end
	
feature {NONE} -- Implementation

	internal_current_position: INTEGER_REF is
			-- The implementation for `current_position'.
		once
			create Result
		end
		
end -- class GLOBAL_HISTORY
