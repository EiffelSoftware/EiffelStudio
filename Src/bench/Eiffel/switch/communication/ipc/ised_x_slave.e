-- Listener to ised to execute corresponding request (an IN_REQUEST)

deferred class ISED_X_SLAVE 

inherit

	SHARED_STATUS;
	IO_CONST
		export
			{NONE} all
		end
	
feature 

	init_connection (really_connect: BOOLEAN) is
			-- Connect with ised 
			-- and watch for inputs from ised if 
			-- `really_connect' is True.
		do
			if really_connect then
				init_connect;
					-- Initialize the connection
					-- with the ised daemon.
				create_handler;

				pass_adresses;
					-- Pass adresses of RQST_HANDLER objects to 
					-- C, so they can be called when the
					-- the workbench is in server mode.
				
				enable_server_mode
					-- Enable the server mode
			end;
		end;

	create_handler is
			-- Create an IO handler to listen to ebench
		deferred
		end;

feature {NONE}

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

	failure_handler: FAILURE_HDLR;
	dead_handler: DEAD_HDLR;
	stopped_handler: STOPPED_HDLR;

	pass_adresses is
			-- Create all possible kinds of RQST_HANDLER that the outside could
			-- send on the pipe `Listen_to_const', and pass the corresponding 
			-- addresses to C so that C can set the proper object.
		do
			!! failure_handler.make;
			!! dead_handler.make;
			!! stopped_handler.make
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
