-- Listener to ised to execute corresponding request (an IN_REQUEST)

class ISED_X_SLAVE 

inherit

	IO_HANDLER
		rename
			make as io_handler_create
		export
			{NONE} all
		redefine
			init_toolkit
		end;
	COMMAND_W
		export
			{NONE} all
		redefine
			init_toolkit, execute
		end;
	IO_CONST
		export
			{NONE} all
		end
	
feature {NONE}

	init_toolkit: MOTIF is once !!Result.make ("ewb") end;

feature 

	init_connection is
			-- Connect with ised 
			-- and watch for inputs from ised.
		local
			listen_to: UNIX_FILE
		do
			if (toolkit = Void) then io.putstring ("KATASTROPHEN!!%N") end;
			init_connect;
				-- Initialize the connection
				-- with the ised daemon.
			io_handler_create;
				-- Create an IO handler which
				-- listens to the appropriate
				-- pipe.
			!!listen_to.make ("");
			listen_to.fd_open_read (Listen_to_const);
				-- Associate the file descriptor corresponding
				-- to the pipe on which reading is done 
				-- with `listen_to'.
			set_read_call_back (listen_to, Current, Current);
				-- Set `Current' as callback to be called 
				-- when there is something new to read on
				-- the `Listen_to_const' pipe.
			pass_adresses
				-- Pass adresses of RQST_HANDLER objects to 
				-- C, so they can be called when the
				-- the workbench is in server mode.
		end;

feature {NONE}

	work (argument: ANY) is
		do
		end;

	execute (argument: ANY) is
			-- Serve request from ised.
		do
			request_handler.execute
		end;

	db_info_handler: DB_INFO_HDLR;
	job_done_handler: JOB_DONE_HDLR;
	failure_handler: FAILURE_HDLR;
	melt_handler: MELT_HDLR;

	pass_adresses is
			-- Create all possible kinds of RQST_HANDLER that the outside could
			-- send on the pipe `Listen_to_const', and pass the corresponding 
			-- addresses to C so that C can set the proper object.
		do
			!!db_info_handler.make;
			!!job_done_handler.make;
			!!failure_handler.make;
			!!melt_handler.make
		end;

feature {NONE} -- External features

	init_connect is
		external
			"C"
		end;

	request_handler: RQST_HANDLER is
		external
			"C"
		end

end
