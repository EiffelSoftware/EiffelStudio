
class FAILURE_HDLR

inherit

	RQST_HANDLER;
	SHARED_DEBUG;

create

	make

feature 

	make is
			-- Create Current and pass addresses to C.
		do
			request_type := Rep_failure;
			pass_addresses
		end;
	
	execute is
			-- Restore the debug information when
			-- a failure occurs.
		do
debug ("DEBUGGER")
	io.error.put_string ("Failure happened%N")
end
			debug_info.restore
		end

end
