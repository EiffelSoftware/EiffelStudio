
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
			error_window.clean;
			error_window.put_string ("Failure%N");
			error_window.show_image;
			error_window.set_changed (false);
			debug_info.restore
		end

end
