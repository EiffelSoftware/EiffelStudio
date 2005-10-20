indexing
	description: "Object that can create different types of pipe on Unix."
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
	
end
