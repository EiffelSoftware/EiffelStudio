note
	description	: "Controls execution of classic debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	APPLICATION_EXECUTION_CLASSIC

inherit
	APPLICATION_EXECUTION
		redefine
			status,
			send_no_breakpoints,
			send_breakpoints_for_stepping,
			is_valid_and_known_object_address,
			update_critical_stack_depth,
			can_not_launch_system_message,
			recycle,
			clean_on_process_termination,
			make_with_debugger,
			activate_execution_replay_recording,
			request_debugger_data_update
		end

	OBJECT_ADDR
		rename
			is_dotnet as is_dotnet_platform
		export
			{NONE} all
		end

	RECV_VALUE
		export
			{NONE} all
			{RECV_VALUE} reset_recv_value
		end

	COMPILER_EXPORTER

	DEBUG_VALUE_EXPORTER

	VALUE_TYPES

create {DEBUGGER_MANAGER}
	make_with_debugger

feature {NONE} -- Initialization

	make_with_debugger (dbg: like debugger_manager)
			-- Instanciate Current with `dbg'
		local
			l_ipc: like ipc_engine
		do
			Precursor {APPLICATION_EXECUTION} (dbg)
			check debugger_manager_not_void: debugger_manager /= Void end
			l_ipc := ipc_engine
			if l_ipc = Void then
				create l_ipc.make (debugger_manager)
				ipc_engine_cell.put (l_ipc)
			else
				l_ipc.change_debugger_manager (debugger_manager)
			end
			init_recv_c
		end

feature {NONE} -- IPC implementation

	ipc_engine: IPC_ENGINE
			-- IPC engine, used to control the ecdbgd debugger daemon.
		do
			Result := Ipc_engine_cell.item
		end

	Ipc_engine_cell: CELL [IPC_ENGINE]
			-- cell containing `ipc_engine'.
		once
			create Result.put (Void)
		end

feature -- recycling data

	recycle
			-- Recycle
		do
			once_request.recycle
			Precursor
		end

feature {DEAD_HDLR, RUN_REQUEST} -- Status

	build_status
			-- Build associated `status'
			-- (ie: the application is running)
		do
			create status.make (Current)
		end

feature -- Properties

	status: APPLICATION_STATUS_CLASSIC
			-- Status of the running dotnet application

	is_valid_and_known_object_address (addr: DBG_ADDRESS): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (addr) and then is_object_kept (addr)
		end

feature -- Execution

	run_with_env_string (app, args, cwd: STRING; env: detachable STRING_GENERAL)
			-- <Precursor>
		local
			l_status: APPLICATION_STATUS
			l_env_s8: STRING_8
		do
			ipc_engine.launch_ec_dbg
			if ipc_engine.ec_dbg_launched then
				run_request.set_application_name (app)
				run_request.set_arguments (args)
				run_request.set_working_directory (cwd)
				if env /= Void then
					debug ("refactor_fixme")
						fixme ("[
							Try to use UNICODE for environment variables in debugger. 
							But for now the classic debugger would not allow that.
							]")
					end
					l_env_s8 := env.as_string_8
				end
				run_request.set_environment_variables (l_env_s8)
				run_request.set_ipc_timeout (ipc_engine.ise_timeout)
				run_request.send
				l_status := status
				if l_status /= Void then
						-- Application was able to be started
					l_status.set_is_stopped (False)
				end
			end
		end

	continue_ignoring_kept_objects
			-- Continue the running of the application
			-- before any debugger's operation occurred
			-- so basically, we are sure we have the same `kept_objects'
		do
			process_before_resuming
			status.set_is_stopped (False)
			cont_request.send_rqst_3_integer (Rqst_resume, Resume_cont, debugger_manager.interrupt_number, debugger_manager.critical_stack_depth)
		end

	process_before_resuming
			-- Operation to process before resuming
		do
			send_breakpoints
		end

	interrupt
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do
			ewb_request.make (Rqst_interrupt)
			ewb_request.send
		end

	request_debugger_data_update
			-- Request the application to pause, in order to update debugger data
			-- such as new breakpoints, or other catcall detection,...
			-- mainl for classic debugging
		do
			ewb_request.make (Rqst_update_breakpoints)
			ewb_request.send
		end

	notify_breakpoints_change
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
			request_debugger_data_update
		end

	kill
			-- Ask the application to terminate itself.
		do
			ewb_request.make (Rqst_kill)
			ewb_request.send

				-- Don't wait until the next event loop to
				-- to process the actual termination of the application.
				-- `recv_dead' will process all other messages sent by
				-- the application until the application is dead.
			from
			until
				ewb_request.recv_dead
			loop
				debug ("ipc")
					print (generator + ".kill -> quit_request.recv_dead ? %N")
				end
			end

			process_termination

			Ipc_engine.end_of_debugging
		ensure then
			app_is_not_running: not is_running
		end

	clean_on_process_termination
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			Precursor {APPLICATION_EXECUTION}
			release_all_objects
		end

	request_ipc_end_of_debugging
			-- Request ipc engine end of debugging
		do
			Ipc_engine.end_of_debugging
		end


feature -- Remote access to RT_

	imp_remote_rt_object: detachable ABSTRACT_REFERENCE_VALUE
			-- Return the remote rt_object
		do
			ewb_request.send_rqst_1 (rqst_rt_operation, rtop_dump_object)
			ewb_request.reset_recv_value
			ewb_request.recv_value (ewb_request)
			if attached {like imp_remote_rt_object} ewb_request.item as ref then
				Result := ref
				Result.set_hector_addr
			else
				check ewb_request.item = Void end
			end
			ewb_request.reset_recv_value
		end

	activate_execution_replay_recording (b: BOOLEAN): BOOLEAN
			-- Activate Execution replay recording on debuggee depending of `b'
		do
			cont_request.send_rqst_3_integer (rqst_rt_operation, rtop_exec_replay, rtdbg_op_replay_record, b.to_integer)
			Result := Precursor {APPLICATION_EXECUTION} (b)
		end

	remote_current_exception_value: EXCEPTION_DEBUG_VALUE
			-- `{EXCEPTION_MANAGER}.last_exception' value.
		do
			send_rqst_0 (rqst_last_exception)
			recv_value (Current)
			if is_exception then
				Result := exception_item
				Result.set_hector_addr
			else
				check item_void: item = Void end
				create Result.make_with_value (Void)
			end
			reset_recv_value
		end

feature {NONE} -- Breakpoints implementation

	send_breakpoints_for_stepping (a_execution_mode: INTEGER; ign_bp: BOOLEAN)
			-- Send breakpoints for step operation
			-- called by `send_breakpoints'
			-- DO NOT CALL DIRECTLY
		do
			Precursor (a_execution_mode, ign_bp)
			ewb_request.send_breakpoints_for_stepping (Current, a_execution_mode)
		end

	send_no_breakpoints
			-- Application execution without any breakpoint
		local
			bps: BREAK_LIST
			loc: BREAKPOINT_LOCATION
		do
				--| Redefined to optimize using the IPC protocol
				--|
				--| clear_application_breakpoints_table
			ewb_request.send_rqst_0 (Rqst_clear_breakpoints)

			bps := Debugger_manager.breakpoints_manager.breakpoints
			from
				bps.start
			until
				bps.after
			loop
				loc := bps.item_for_iteration.location
				if loc.is_set_for_application then
					debug ("debugger_trace_breakpoint")
						print ("REMOVE APPLICATION BP :: " + loc.debug_output + "%N")
					end
					loc.set_application_not_set
					-- then next time we go with StopPoint enable ... we'll add them again
				end
				bps.forth
			end
		end

	set_application_breakpoint (loc: BREAKPOINT_LOCATION)
			-- enable breakpoint at `loc'
			-- if no breakpoint already exists at `loc' a breakpoint is created
		do
			ewb_request.set_classic_breakpoint (loc, True)
		end

	unset_application_breakpoint (loc: BREAKPOINT_LOCATION)
			-- remove breakpoint at `loc'
		do
			ewb_request.set_classic_breakpoint (loc, False)
		end

feature -- Catcall detection change

	set_catcall_detection_mode (a_console, a_dbg: BOOLEAN)
			-- <Precursor>
		local
			i, j: INTEGER
		do
			ewb_request.send_rqst_3_integer (Rqst_rt_operation, Rtop_set_catcall_detection, a_console.to_integer, a_dbg.to_integer)
			i := to_integer_32 (c_tread)
			j := to_integer_32 (c_tread)
		end

feature {NONE} -- Assertion change Implementation

	impl_check_assert (b: BOOLEAN): BOOLEAN
			-- `check_assert (b)' on debuggee
		local
			s: STRING
		do
			ewb_request.send_rqst_1 (Rqst_set_assertion_check, b.to_integer)
			s := c_tread
			if s /= Void and then s.is_boolean then
				Result := s.to_boolean
			end
		end

feature {NONE} -- Assertion violation processing		

	impl_ignore_current_assertion_violation (a_boolean: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			ewb_request.send_rqst_1 (Rqst_ignore_assertion_violation, a_boolean.to_integer)
		end

feature -- Change

	update_critical_stack_depth (d: INTEGER)
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		do
			if status /= Void and then status.is_stopped then
				send_rqst_3_integer (Rqst_overflow_detection, 0, 0, d)
			end
		end

feature -- Query

	onces_values (flist: LIST [E_FEATURE]; a_addr: DBG_ADDRESS; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE]
		local
			i: INTEGER
			err_dv: DUMMY_MESSAGE_DEBUG_VALUE
			odv: ABSTRACT_DEBUG_VALUE
			l_feat: FEATURE_I
			l_class: CLASS_C
			once_r: ONCE_REQUEST
		do
			l_class := a_cl
			from
				once_r := Once_request
				i := 1
				create Result.make (i, i + flist.count - 1)
				flist.start
			until
				flist.after
			loop
				l_feat := flist.item.associated_feature_i
				if once_r.already_called (l_feat) then
					odv := once_r.once_result (l_feat)
					if odv /= Void then
						odv.set_name (l_feat.feature_name)
					else
						create err_dv.make_with_name  (l_feat.feature_name)
						err_dv.set_message (debugger_names.m_Could_not_retrieve_once_information)
						odv := err_dv
					end
				else
					create err_dv.make_with_name  (l_feat.feature_name)
					err_dv.set_message (debugger_names.m_Not_yet_called)
					if l_feat.is_function then
						err_dv.set_display_kind (Void_value)
					else
						err_dv.set_display_kind (Procedure_return_message_value)
					end
					odv := err_dv
				end
				Result.put (odv, i)
				i := i + 1
				flist.forth
			end
		end

	dump_value_at_address_with_class (a_addr: DBG_ADDRESS; a_cl: CLASS_C): DUMP_VALUE
		do
			Result := Debugger_manager.Dump_value_factory.new_object_value (a_addr, a_cl)
		end

	debug_value_at_address_with_class (a_addr: DBG_ADDRESS; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE
		do
--			debugged_object_manager.classic_debugged_object_with_class (a_addr, a_cl)
--			Result := dump_value_at_address_with_class (a_addr, a_cl).
			to_implement ("Need to be implemented, but for now this is not used.")
			check False end
		end

	get_exception_value_details	(e: EXCEPTION_DEBUG_VALUE; a_details_level: INTEGER)
			-- Code, Tag, Message from `val'.
		local
			cl: CLASS_C
			dv: DUMP_VALUE
			edv: DUMP_VALUE
			val: ABSTRACT_REFERENCE_VALUE
		do
			val := e.debug_value
			if val /= Void then
				cl := val.dynamic_class
				if cl = Void then
					cl := debugger_manager.compiler_data.exception_class_c
				end
				if cl = Void then
					if e.exception_type_name = Void then
						e.set_exception_type_name ("NONE")
					end
				else
						--| Type name
					if e.exception_type_name = Void then
						e.set_exception_type_name (cl.name_in_upper)
					end
						--| Exception code
					if e.exception_code <= 0 then
						dv := query_evaluation_on (val, edv, cl, "code", Void)
						if dv /= Void and then dv.is_basic then
							e.set_exception_code (dv.as_dump_value_basic.value_integer_32)
						end
					end

					if a_details_level > 0 then
						if edv = Void then
							edv := val.dump_value
						end
							--| Exception meaning					
						if e.exception_meaning = Void then
							e.set_exception_meaning (string_field_evaluation_on (val, edv, cl, "meaning"))
						end
							--| Exception message					
						if e.exception_message = Void then
							e.set_exception_message (string_field_evaluation_on (val, edv, cl, "message"))
						end
						if a_details_level > 1 then
							if e.exception_text = Void then
								e.set_exception_text (string_field_evaluation_on (val, edv, cl, "exception_trace"))
							end
						end
					end
				end
			end
		end

--feature {RUN_REQUEST} -- Implementation
--
--	invoke_launched_command (successful: BOOLEAN) is
--			-- Process after the launch of the application according
--			-- to `successful' and the execute `application_launch_command'.
--		do
--		end

feature {APPLICATION_EXECUTION} -- Launching status

	can_not_launch_system_message: STRING_32
			-- Message displayed when estudio is unable to launch the system
		do
			Result := debugger_names.w_Cannot_launch_system
			Result.append_character ('%N')
			if not ipc_engine.valid_ise_ecdbgd_executable then
				if ipc_engine.is_vms then
					Result.append_string_general (
							debugger_names.w_Cannot_find_valid_ecdbgd_vms (
									ipc_engine.ise_ecdbgd_path,
									ipc_engine.ise_ecdbgd_varname
								)
						)
				else
					Result.append_string_general (
							debugger_names.w_Cannot_find_valid_ecdbgd_non_vms (
									ipc_engine.ise_ecdbgd_path,
									ipc_engine.ise_ecdbgd_varname
								)
						)
				end
			else
				if ipc_engine.is_vms then
					Result.append_string_general (
							debugger_names.w_Cannot_launch_in_allotted_time_vms (
									ipc_engine.ise_timeout,
									ipc_engine.ise_timeout_varname
								)
						)
				else
					Result.append_string_general (
							debugger_names.w_Cannot_launch_in_allotted_time_non_vms (
									ipc_engine.ise_timeout,
									ipc_engine.ise_timeout_varname
								)
						)
				end
			end
		end

feature {APPLICATION_STATUS}

	once_request: ONCE_REQUEST
		once
			create Result.make
		end

	ewb_request: EWB_REQUEST
		once
			create Result.make (Rqst_quit)
		end

	run_request: RUN_REQUEST
		once
			create Result.make (Rqst_application)
		end

	cont_request: EWB_REQUEST
		once
			create Result.make (Rqst_cont)
		end

invariant

	ipc_engine_not_void: ipc_engine /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
