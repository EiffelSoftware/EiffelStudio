-- General request from workbench to ised.

class EWB_REQUEST 

inherit

	DEBUG_EXT;
	IPC_SHARED;
	SHARED_DEBUG;
	SHARED_WORKBENCH

creation

	make 

feature 

	start_application (app_name: STRING): BOOLEAN is
			-- Send a request to the Ised daemon to 
			-- start the application `app_name',
			-- and perform a handshake with the
			-- application to check that it is alive.
			-- Return False if something went wrong
			-- in the communication.
		local
			ext_str: ANY;
		do
			-- Start the application (in debug mode).
			send_rqst_0 (Rqst_application);

			-- Send the name of the application.
			ext_str := app_name.to_c;
			c_send_str ($ext_str);
			Result := recv_ack;

			-- Perform a handskae with the application.
			if Result then
				send_rqst_0 (Rqst_hello);
				Result := recv_ack
			end;
		end;

	send_byte_code: BOOLEAN is
			-- Send the byte code of routines which have
			-- been dynamicaly melted.
		local
			deb: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			deb_l: LINKED_LIST [DEBUGGABLE];
			byte_array: TO_SPECIAL [CHARACTER];
			c_ptr: ANY
		do
			-- Send Load request
			send_rqst_2 (Rqst_load, debug_info.new_extension,
							debug_info.debuggable_count);
			Result := recv_ack;

			-- Send the byte code.
			if Result then
				from
					deb := debug_info.new_debuggables;
					deb.start
				until
					deb.offright or else
					not Result
				loop
					deb_l := deb.item_for_iteration;
					from
						deb_l.start
					until
						deb_l.after or else
						not Result
					loop
						send_rqst_2 (Rqst_bc,
							deb_l.item.real_body_index - 1,
							deb_l.item.real_body_id - 1);
						byte_array := deb_l.item.byte_code;
						c_ptr := byte_array.area;
						c_twrite ($c_ptr, deb_l.item.byte_code.size);
						Result := recv_ack;
						deb_l.forth
					end;
					deb.forth;
				end;
			end;
		end;

	send_breakpoints is
		local
			bpts: LINKED_LIST [BREAKPOINT];
			bp: BREAKPOINT;
		do
			Debug_info.remove_stepped_routine;
			Debug_info.add_step_breakpoints;
			bpts := debug_info.new_breakpoints;
			from
				bpts.start
			until
				bpts.after
			loop
				bp := bpts.item;
				if bp.is_continue then
					send_rqst_3 (Rqst_break, 
							bp.real_body_id - 1,
							Break_remove,
							bp.offset - 1);
				else
					send_rqst_3 (Rqst_break, 
							bp.real_body_id - 1,
							Break_set,
							bp.offset - 1);
				end;
				bpts.forth
			end			
		end;

	make (code: INTEGER) is
		do
			request_code := code
		end;

	send is
			-- Send Current request to ised, which may 
			-- relay it to the application.
		do
			send_simple_request (request_code)
		end;

	request_code: INTEGER;

feature {NONE} -- External features

	send_simple_request (i: INTEGER) is
		external
			"C"
		end

end
