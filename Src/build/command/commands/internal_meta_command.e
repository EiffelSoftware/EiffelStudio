indexing
	description: "Command used on the interface to take into account %
				% the mode in which EiffelBuild is. Do nothing if %
				% the current state is the editing state.";
	date: "$Date$";
	revision: "$Revision$"

class
	INTERNAL_META_COMMAND

inherit
	COMMAND
	MODE_CONSTANTS
	SHARED_MODE
		rename
			current_mode as editing_or_executing_mode
		end

creation
	make

feature

	make is
		do
			!! associated_meta_command.make
		end

feature {NONE} -- Attributes

	associated_meta_command: META_COMMAND
			-- Command used in Executing mode

	editing_command: COMMAND
			-- Command used in Editing mode

feature 

	execute (arg: ANY) is
			-- Execute `associated_meta_command' if current mode is
			-- `Executing_mode'. Execute `editing_command' if current
			-- mode is `Editing_mode'.
		do
			if editing_or_executing_mode = Executing_mode then
				associated_meta_command.execute (arg)
			elseif editing_command /= Void then
				editing_command.execute (arg)
			end
		end

feature -- Access 

	add_command (a_state: STATE; a_command: BUILD_CMD) is
			-- Add `a_command' to be executed in the state `a_state'.
		require
			command_not_void: a_command /= Void
		do
			associated_meta_command.add (a_state.identifier, a_command)
		end

	remove_command (a_state: STATE; a_command: BUILD_CMD) is
			-- Remove `a_command' in the state `a_state'.
		require
			command_not_void: a_command /= Void
		do
			associated_meta_command.remove (a_state.identifier)
		end

	set_editing_command (a_command: COMMAND) is
			-- Set `editing_command' to `a_command'.
		do
			editing_command := a_command
		end

end -- class INTERNAL_META_COMMAND
