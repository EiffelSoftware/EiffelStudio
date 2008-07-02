indexing
	description: "Object that can create different types of pipe on Unix."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	UNIX_PIPE_FACTORY

inherit
	PROCESS_UNIX_OS
		export
			{UNIX_PIPE_FACTORY} unix_pipe
		end

create 
	default_create

feature 

	new_unnamed_pipe: UNIX_UNNAMED_PIPE is
			-- Create a new unamed pipe.
		local
			read_fd, write_fd: INTEGER
		do
			unix_pipe ($read_fd, $write_fd)
			create Result.make (read_fd, write_fd)
		ensure
			pipe_created: Result /= Void
		end
	
indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
