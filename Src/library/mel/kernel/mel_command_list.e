indexing

	description: 
		"Execution of a list of commands as a result of MOTIF callback"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
    MEL_COMMAND_LIST

inherit
    MEL_COMMAND
		undefine
			copy, is_equal
		end

    LINKED_LIST [MEL_COMMAND_EXEC]

create
    make

feature -- Element change

    add_command (command: MEL_COMMAND; argument: ANY) is
            -- Add `command' with `argument' to list of commands.
		require
			command_not_void: command /= Void
        local
            exec: MEL_COMMAND_EXEC
        do
            create exec.make (command, argument)
            extend (exec)
        end

feature -- Removal

    remove_command (command: MEL_COMMAND; argument: ANY) is
            -- Remove all `command' with `argument' from the list of commands.
		require
			command_not_void: command /= Void
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_COMMAND_LIST


