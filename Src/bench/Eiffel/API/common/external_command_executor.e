indexing

	description: 
		"Calls commands outside the eiffel environment.%
		%If a connection has been made then execute the command%
		%as a background process. Otherwize, do a system call";
	date: "$Date$";
	revision: "$Revision $"

class EXTERNAL_COMMAND_EXECUTOR

inherit

	BENCH_COMMAND_EXECUTOR
		export
			{NONE} all;
			{ANY} execute
		end

end -- class EXTERNAL_COMMAND_EXECUTOR
