class EWB_MOTIF

inherit
	EWB
		redefine
			init_toolkit
		end

	IO_HANDLER
		rename
			make as io_handler_create
		export
			{NONE} all
		redefine
			init_toolkit
		end;

creation
	make

feature {NONE}

	init_toolkit: MOTIF is once !!Result.make ("ewb") end;

feature 

	listen_to: RAW_FILE;

	create_handler is
		do
				-- Initialize the connection
				-- with the ised daemon.
			io_handler_create;
				-- Create an IO handler which
				-- listens to the appropriate
				-- pipe.
			!!listen_to.make ("toto");
			listen_to.fd_open_read (Listen_to_const);
				-- Associate the file descriptor corresponding
				-- to the pipe on which reading is done 
				-- with `listen_to'.
			set_read_call_back (listen_to, Current, Current);
				-- Set `Current' as callback to be called 
				-- when there is something new to read on
				-- the `Listen_to_const' pipe.
		end;

end
