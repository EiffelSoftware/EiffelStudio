indexing

	description: 
		"Implementation of the callback mechanism."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_COMMAND

feature -- Access

	callback_struct: MEL_CALLBACK_STRUCT;
			-- The callback structure is set by MEL when
			-- Current command is invoked as a callback

	is_executable (arg: ANY): BOOLEAN is
			-- Is the Current command able to be executed?
			-- (By defauult, it is True).
		do
			Result := True
		end;

feature -- Element change

	set_callback_struct (a_callback_struct: MEL_CALLBACK_STRUCT) is
			-- Set the callback structure.
		do
			callback_struct := a_callback_struct
		ensure
			set: callback_struct = a_callback_struct
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute current command.
			-- the argument is automatically passed by MEL when Current
			-- command is invoked as a callback.
		require
			is_executuable: is_executable (argument)
		deferred
		end;

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




end -- class MEL_COMMAND


