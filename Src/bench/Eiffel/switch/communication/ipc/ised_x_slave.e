indexing
	description	: "Listener to the daemon to execute corresponding request"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class ISED_X_SLAVE

inherit
	SHARED_STATUS

	SHARED_PLATFORM_CONSTANTS

	IO_CONST
		export
			{NONE} all
		end
	
feature -- Initialization

	init_connection (old_style: BOOLEAN) is
			-- Connect with ised and watch for inputs from ised.
		do
			init_connect

				-- Initialize the connection
				-- with the ised daemon.
			if old_style then
				create_handler
			else
				create io_watcher.make_with_action (~execute (Void))
			end

			pass_adresses
				-- Pass adresses of RQST_HANDLER objects to 
				-- C, so they can be called when the
				-- the workbench is in server mode.
			
			enable_server_mode
				-- Enable the server mode
		end

	create_handler is
			-- Create an IO handler to listen to ebench
		deferred
		end

feature {NONE} -- Implementation

	execute (argument: ANY) is
			-- Serve request from ised.
		local
			rqst_hdlr: RQST_HANDLER
		do
			rqst_hdlr := request_handler
			if rqst_hdlr /= Void then
				rqst_hdlr.execute
			end
		end

	io_watcher: EB_IO_WATCHER
			-- Class to watch for request from the daemon.

	failure_handler: FAILURE_HDLR
			-- Handler for failure error event.

	dead_handler: DEAD_HDLR
			-- Handler for dead application event.

	stopped_handler: STOPPED_HDLR
			-- Handler for stopped application event.
			-- (Called when the application hit a breakpoint or when
			-- the user change the status of a breakpoint while the
			-- debugged application is running)

	pass_adresses is
			-- Create all possible kinds of RQST_HANDLER that the outside could
			-- send on the pipe `Listen_to_const', and pass the corresponding 
			-- addresses to C so that C can set the proper object.
		do
			create failure_handler.make
			create dead_handler.make
			create stopped_handler.make
		end

feature {NONE} -- Externals

	init_connect is
			-- Initialize the connection
		external
			"C"
		end

	request_handler: RQST_HANDLER is
			-- Return the correct RequestHandler at run-time.
		external
			"C"
		end

end
