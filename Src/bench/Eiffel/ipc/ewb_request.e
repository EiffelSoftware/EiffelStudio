-- General request from workbench to ised.

class EWB_REQUEST 

inherit

	DEBUG_EXT;
	IPC_SHARED;
	SHARED_DEBUG;
	SHARED_WORKBENCH;
	EXEC_MODES

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
					deb.after or else
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
			bpts: BREAK_LIST;
			bp: BREAKPOINT;
			routine: FEATURE_I
		do
			Debug_info.remove_all_breakpoints;
			inspect Run_info.execution_mode
			when No_stop_points then
					-- Do not send new stop points.
			when User_stop_points then
					-- Execution with no stop points set.
				Debug_info.set_all_breakpoints
			when All_breakable_points then
					-- Execution with all breakable points set.
				Debug_info.set_all_breakables
			when Routine_breakables then
					-- Execution with only breakable points of current 
					-- routine set.
				if Run_info.is_running then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := Run_info.feature_i;
					if 
						routine /= Void and then 
						Debug_info.has_feature (routine) 
					then
						Debug_info.set_routine_breakables (routine)
					end
				end
			when Routine_breakables_and_user_stop_points then
					-- Execution with breakable points of current routine
					-- and user-defined stop points set.
				Debug_info.set_all_breakpoints;
				if Run_info.is_running then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := Run_info.feature_i;
					if 
						routine /= Void and then 
						Debug_info.has_feature (routine) 
					then
						Debug_info.set_routine_breakables (routine)
					end
				end
			when Routine_stop_points then
					-- Execution with only user-defined stop points of
					-- current routine set.
				if Run_info.is_running then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := Run_info.feature_i;
					if 
						routine /= Void and then 
						Debug_info.has_feature (routine) 
					then
						Debug_info.set_routine_breakpoints (routine)
					end
				end
			when Last_routine_breakable then
					-- Execution with only the last breakable point of
					-- current routine set.
				if Run_info.is_running then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := Run_info.feature_i;
					if 
						routine /= Void and then 
						Debug_info.has_feature (routine) 
					then
						Debug_info.set_routine_last_breakable (routine)
					end
				end
			when Out_of_routine then
					-- Execution with all breakable points set except
					-- those of the current routine.
				routine := Run_info.feature_i;
				if Run_info.is_running and then routine /= Void then 
					Debug_info.set_out_of_routine_breakables (routine)
				else
					Debug_info.set_all_breakables
				end
			else
					-- Unknown execution mode. Do nothing.
			end;

			bpts := debug_info.new_breakpoints;
			from
				bpts.start
			until
				bpts.off
			loop
				bp := bpts.item_for_iteration;
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
				debug_info.sent_breakpoints.extend (bp);
				bpts.forth
			end;
			bpts.wipe_out
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
