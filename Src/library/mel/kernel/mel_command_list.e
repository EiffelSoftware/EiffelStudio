indexing

	description: 
		"Execution of a list of commands as a result of MOTIF callback";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
    MEL_COMMAND_LIST

inherit
    MEL_COMMAND;

    LINKED_LIST [MEL_COMMAND_EXEC]

creation
    make

feature -- Element change

    add_command (command: MEL_COMMAND; argument: ANY) is
            -- Add `command' with `argument' to list of commands.
		require
			command_not_void: command /= Void
        local
            exec: MEL_COMMAND_EXEC
        do
            !! exec.make (command, argument)
            extend (exec)
        end

feature -- Removal

    remove_command (command: MEL_COMMAND; argument: ANY) is
            -- Remove all `command' with `argument' from the list of commands.
		require
			command_not_void: command /= Void
		local
			a_cmd: MEL_COMMAND
        do
			from
				start
			until
				after
			loop
				if item.command = command and then	
					equal (item.argument, argument)
				then
					remove
				else
					forth
				end
			end
        end

feature -- Execution

    execute (argument: ANY) is
            -- Execute list of commands
		local
			a_list: like Current
        do
			start;
				-- Duplicate list just in case that commands are removed
				-- during the executing of the callbacks.
			a_list := duplicate (count);
            from
                a_list.start
            until
                a_list.after
            loop
                a_list.item.execute (callback_struct);
                a_list.forth
            end
        end

end -- class MEL_COMMAND_LIST

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
