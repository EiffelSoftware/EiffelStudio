-- Listener to ised to execute corresponding request (an IN_REQUEST)

deferred class ISED_X_SLAVE 

inherit
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
		end

	create_handler is
			-- Create an IO handler to listen to ebench
		deferred
		end;

feature {NONE}

	execute (argument: ANY) is
			-- Serve request from ised.
		do
		end

end
