class DEAD_HDLR

inherit
	RQST_HANDLER;
	SHARED_DEBUG;
	WINDOWS;
	OBJECT_ADDR

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
			if Run_info.is_running then
				debug_info.restore;
				debug_window.clear_window;
				debug_window.put_string ("Application terminated%N");
				debug_window.display;
				run_info.set_is_running (false)
			end;
				-- Get rid of adopted objects.
			addr_table.clear_all;
			window_manager.object_win_mgr.reset
		end

end
