-- General request from workbench to ised.

class EWB_REQUEST 

inherit

	DEBUG_EXT;
	IPC_SHARED;
	SHARED_DEBUG;
	EXEC_MODES;

creation

	make 

feature -- Update

	send_byte_code: BOOLEAN is
			-- Send the byte code of routines which have
			-- been dynamicaly melted.
		local
			deb: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], BODY_ID];
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
							deb_l.item.real_body_index.id - 1,
							deb_l.item.real_body_id.id - 1);
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
			routine: E_FEATURE;
			status: APPLICATION_STATUS
		do
			Debug_info.remove_all_breakpoints;
			inspect Application.execution_mode
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
				status := Application.status;
				if status /= Void then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := status.e_feature;
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
				status := Application.status;
				if status /= Void then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := status.e_feature;
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
				status := Application.status;
				if status /= Void then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := status.e_feature;
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
				status := Application.status;
				if status /= Void then
						-- If the application is not running, there is no 
						-- current routine ...
					routine := status.e_feature;
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
				status := Application.status;
				if status /= Void then
					routine := status.e_feature;
					if routine /= Void then 
						Debug_info.set_out_of_routine_breakables (routine)
					else
						Debug_info.set_all_breakables
					end
				end
			else
					-- Unknown execution mode. Do nothing.
			end;

			bpts := debug_info.new_breakpoints;
			from
				bpts.start
			until
				bpts.after
			loop
				bp := bpts.item_for_iteration;
				if bp.is_continue then
					send_rqst_3 (Rqst_break, 
							bp.real_body_id.id - 1,
							Break_remove,
							bp.offset - 1);
				else
					send_rqst_3 (Rqst_break, 
							bp.real_body_id.id - 1,
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
			send_rqst_0 (request_code)
		end;

	request_code: INTEGER;

end
