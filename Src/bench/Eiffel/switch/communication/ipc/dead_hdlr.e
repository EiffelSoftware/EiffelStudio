class DEAD_HDLR

inherit

	RQST_HANDLER;
	SHARED_DEBUG;
	OBJECT_ADDR

create

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
			if Application.is_running then
				Application.process_termination;
			end;
		end

end
