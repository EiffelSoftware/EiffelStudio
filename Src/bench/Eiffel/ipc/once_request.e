-- Request for once functions' result

class

	ONCE_REQUEST

inherit

	IPC_SHARED;
	DEBUG_EXT;
	RECV_VALUE;
	SHARED_DEBUG

creation

	make

feature 

	make is
		do
			init_recv_c
		end;

	already_called (once_routine: E_FEATURE): BOOLEAN is
			-- Has `once_routine' already been called?
		require
			exists: once_routine /= Void;
			is_once: once_routine.is_once
		local
			real_body_id: INTEGER
		do
			if not Run_info.is_running then
				Result := False
			else
				real_body_id := Debug_info.real_body_id (once_routine);
				send_rqst_3 (Rqst_once, Out_called, 0, real_body_id - 1);
				Result := c_tread.to_boolean
			end
	
debug ("ONCE")
	io.error.putstring ("Once routine `");
	io.error.putstring (once_routine.name);
	io.error.putstring ("' (");
	io.error.putint (Debug_info.real_body_id (once_routine));
	if Result then
		io.error.putstring (") already called.")
	else
		io.error.putstring (") not called yet.")
	end;
	io.error.new_line
end
		end;

	once_result (once_function: E_FEATURE): DEBUG_VALUE is
			-- Result of `once_function'
		require
			exists: once_function /= Void;
			is_once: once_function.is_once;
			is_function: once_function.is_function;
			result_exists: already_called (once_function)
		local
			real_body_id: INTEGER
		do
			real_body_id := Debug_info.real_body_id (once_function);
			send_rqst_3 (Rqst_once, Out_result, 
						once_function.argument_count, real_body_id - 1);
			c_recv_value (Current);
			Result := item;
				-- Convert the physical addresses received from 
				-- the application to hector addresses.
			Result.set_hector_addr
		ensure
			result_exists: Result /= Void
		end;

end -- class ONCE_REQUEST	
