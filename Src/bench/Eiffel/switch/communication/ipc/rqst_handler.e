-- General response to a request from
-- ised to workbench.

deferred class RQST_HANDLER 

inherit

	IPC_SHARED

feature 

	execute is
			-- Execute Current action as 
			-- requested by ised.
		deferred
		end;

	request_type: INTEGER;
			-- Constant from IPC_SHARED defining current

	detail: STRING;
			-- Detail of Current. Can be a job number, a position...

feature -- Eiffel/C interface.

	pass_addresses is
			-- Pass addresses from Current to C.
		do
			rqst_handler_to_c (Current, request_type, $set)
		end;

	set (s: like detail) is
			-- Assign `s' to `detail'
		do
			detail := s
		end;

feature {NONE} -- external

	rqst_handler_to_c (a: like Current; i: like request_type; f: POINTER)  is
			-- Pass addresses to C.
		external
			"C"
		end;

end
