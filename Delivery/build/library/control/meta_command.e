indexing

	description:
		"General notion of EiffelBuild command (semantic unity)";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class META_COMMAND 

inherit

	HASH_TABLE [BUILD_CMD, INTEGER]
		rename
			make as hash_table_make,
			control as hash_table_control
		end;
	COMMAND
		undefine
			is_equal, copy
		redefine
			context_data_useful
		end;
	SHARED_CONTROL
		undefine
			is_equal, copy
		end

creation

	make

feature {NONE}

	make is
			-- Make current.
		do
			hash_table_make (5);	
		end;

feature 

	context_data_useful: BOOLEAN;
			-- Information related to Current command,
			-- provided by the underlying user interface
			-- mechanism

	add (state: INTEGER; command: BUILD_CMD) is
			-- Add `command' in state `state'.
		do
			put (command, state);	
			if not context_data_useful and then 
				command.context_data_useful 
			then
				context_data_useful := True;
			end;
		end;

	execute (argument: ANY) is
			-- Execute command depending on current state.
		local
			command: BUILD_CMD
			current_state: INTEGER
		do
			command := item (control.state);
			current_state := control.state
			if command /= Void then
				if context_data_useful and then 
					command.context_data_useful 
				then
					command.set_context_data (context_data);
				end;
				command.work
			end;
		end;

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
