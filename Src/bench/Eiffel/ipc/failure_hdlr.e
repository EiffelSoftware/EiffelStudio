
class FAILURE_HDLR

inherit

	RQST_HANDLER;
	SHARED_DEBUG;
	WINDOWS

creation

	make

feature 

	make is
			-- Create Current and pass addresses to C.
		do
			request_type := Rep_failure;
			pass_addresses
		end;
	
	execute is
			-- Announce in error window that the job was finished.
		do
			error_window.clear_window;
		--	error_window.put_string ("Failure%N");
			error_window.display;
			debug_info.restore
		end

end
