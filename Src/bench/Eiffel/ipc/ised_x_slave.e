-- Listener to ised to execute corresponding request (an IN_REQUEST)

deferred class ISED_X_SLAVE 

inherit

	COMMAND_W
		export
			{NONE} all
		redefine
			execute
		end;
	IO_CONST
		export
			{NONE} all
		end
	
feature 

	init_connection is
			-- Connect with ised 
			-- and watch for inputs from ised.
		do
			if (toolkit = Void) then io.putstring ("KATASTROPHEN!!%N") end;
			init_connect;
				-- Initialize the connection
				-- with the ised daemon.
			create_handler;

			pass_adresses
				-- Pass adresses of RQST_HANDLER objects to 
				-- C, so they can be called when the
				-- the workbench is in server mode.
		end;

	create_handler is
			-- Create an IO handler to listen to ebench
		deferred
		end;

feature {NONE}

	work (argument: ANY) is
		do
		end;

	execute (argument: ANY) is
			-- Serve request from ised.
		local
			rqst_hdlr: RQST_HANDLER
		do
			rqst_hdlr := request_handler;
			if rqst_hdlr /= Void then
				rqst_hdlr.execute
			end
		end;

	db_info_handler: DB_INFO_HDLR;
	job_done_handler: JOB_DONE_HDLR;
	failure_handler: FAILURE_HDLR;
	melt_handler: MELT_HDLR;
	dead_handler: DEAD_HDLR;
	stopped_handler: STOPPED_HDLR;
	

	pass_adresses is
			-- Create all possible kinds of RQST_HANDLER that the outside could
			-- send on the pipe `Listen_to_const', and pass the corresponding 
			-- addresses to C so that C can set the proper object.
		do
			!!db_info_handler.make;
			!!job_done_handler.make;
			!!failure_handler.make;
			!!melt_handler.make;
			!!dead_handler.make;
			!!stopped_handler.make
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
