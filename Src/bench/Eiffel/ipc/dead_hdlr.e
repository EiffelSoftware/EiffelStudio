class DEAD_HDLR

inherit
	RQST_HANDLER;
	SHARED_DEBUG;
	WINDOWS

creation

	make

feature
	
	make is
			-- Create Current and pass addresses to C
		do
			request_type := Rep_dead;
			pass_addresses
		end;

	execute is
			-- register termination of the controlled application
		do
			run_info.set_is_running (false);
			debug_info.restore;
			debug_window.clear_window;
			debug_window.put_string ("Application terminated%N");
			debug_window.display;
		end

end
