-- General request from workbench to ised.

class EWB_REQUEST 

create
	make

feature -- Initialization

	make (code: INTEGER) is
		do
		end;

feature -- Update

	send_byte_code: BOOLEAN is
		do
		end;

	send_breakpoints is
		do
		end

	send is
		do
		end;

	request_code: INTEGER is
		do
		end

	recv_ack: BOOLEAN is
		do
		end

	recv_dead: BOOLEAN is
		do
		end
end
