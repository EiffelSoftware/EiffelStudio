indexing
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
			is_valid_object_address,
			update_critical_stack_depth,
			can_not_launch_system_message,
			recycle,
			clean_on_process_termination,
			make_with_debugger,
			activate_execution_replay_recording, replay
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
		end

	COMPILER_EXPORTER

	DEBUG_VALUE_EXPORTER

	EB_CONSTANTS

	VALUE_TYPES

create {DEBUGGER_MANAGER}
	make_with_debugger

feature {NONE} -- Initialization

	make_with_debugger (dbg: like debugger_manager) is
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
		end

feature {NONE} -- IPC implementation

	ipc_engine: IPC_ENGINE is
			-- IPC engine, used to control the ecdbgd debugger daemon.
		do
			Result := Ipc_engine_cell.item
		end

	Ipc_engine_cell: CELL [IPC_ENGINE] is
			-- cell containing `ipc_engine'.
		once
			create Result
		end

feature -- recycling data

	recycle is
		do
			once_request.recycle
			Precursor
		end

feature {DEAD_HDLR, RUN_REQUEST} -- Status

	build_status is
		do
			create status.make (Current)
		end

feature -- Properties

	status: APPLICATION_STATUS_CLASSIC
			-- Status of the running dotnet application

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
			Result := Precursor (addr) and then is_object_kept (addr)
		end

feature -- Execution

	run_with_env_string (app, args, cwd: STRING; env: STRING_GENERAL) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		require else
			cwd_not_void: cwd /= Void
			env_not_void: env /= Void
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
					fixme ("[
						Try to use UNICODE for environment variables in debugger. 
						But for now the classic debugger would not allow that.
						]")
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

	continue_ignoring_kept_objects is
		do
			cont_request.send_breakpoints
			debugger_manager.breakpoints_manager.reset_breakpoints_changed
			status.set_is_stopped (False)
			cont_request.send_rqst_3_integer (Rqst_resume, Resume_cont, debugger_manager.interrupt_number, debugger_manager.critical_stack_depth)
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do
			ewb_request.make (Rqst_interrupt)
			ewb_request.send
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
			ewb_request.make (Rqst_new_breakpoint)
			ewb_request.send
		end

	kill is
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

	activate_execution_replay_recording (b: BOOLEAN) is
			-- Activate Execution replay recording on debuggee depending of `b'
		do
			Precursor {APPLICATION_EXECUTION} (b)
			cont_request.send_rqst_3_integer (rqst_rt_operation, rtop_exec_replay, rtdbg_op_replay_record, b.to_integer)
		end

	replay (direction: INTEGER): BOOLEAN is
			-- Replay execution in direction `direction'
		do
			Result := Precursor {APPLICATION_EXECUTION} (direction)
			if Result then
				cont_request.send_rqst_3_integer (rqst_rt_operation, rtop_exec_replay, direction, 1)
				Result := to_boolean (c_tread)
			end
		end

	query_replay_status (direction: INTEGER): INTEGER is
			-- Query exec replay status for direction `direction'
			-- Return the number of available steps.
		do
			cont_request.send_rqst_3_integer (rqst_rt_operation, rtop_exec_replay, direction, 0)
			Result := to_integer_32 (c_tread)
		end

	remote_rt_object: ABSTRACT_DEBUG_VALUE is
			-- Return the remote rt_object
		do
			ewb_request.send_rqst_1 (rqst_rt_operation, rtop_dump_object)
			ewb_request.reset_recv_value
			ewb_request.recv_value (ewb_request)
			Result := ewb_request.item
			Result.set_hector_addr
			ewb_request.reset_recv_value
		end

	remotely_store_object (oa: STRING; fn: STRING): BOOLEAN is
			-- Store remotly the debuggee's object referenced by `oa' in file `fn'
		local
			c_string: C_STRING
			b: BOOLEAN
		do
			ewb_request.send_ref_value (hex_to_pointer (oa))
			ewb_request.send_rqst_1 (rqst_rt_operation, rtop_object_storage_save)

			create c_string.make (fn)
			send_string_value (c_string.item)
			b := recv_ack
			if b then
				Result := to_boolean (c_tread)
			end
		end

	remotely_loaded_object (oa: STRING; fn: STRING): ABSTRACT_DEBUG_VALUE is
			-- Load remotly and return the debuggee's object referenced by `oa' from file `fn'.
		local
			c_string: C_STRING
			b: BOOLEAN
			p: POINTER
		do
			if oa /= Void then
				p := hex_to_pointer (oa)
			end
			ewb_request.send_ref_value (p)
			ewb_request.send_rqst_1 (rqst_rt_operation, rtop_object_storage_load)
			create c_string.make (fn)
			send_string_value (c_string.item)
			b := recv_ack
			if b then
				ewb_request.reset_recv_value
				ewb_request.recv_value (ewb_request)
				Result := ewb_request.item
				if Result /= Void then
					Result.set_hector_addr
				end
				ewb_request.reset_recv_value
			end
		end

	clean_on_process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			Precursor {APPLICATION_EXECUTION}
			release_all_objects
		end

	request_ipc_end_of_debugging is
			-- Request ipc engine end of debugging
		do
			Ipc_engine.end_of_debugging
		end

feature {NONE} -- Assertion change Implementation

	impl_check_assert (b: BOOLEAN): BOOLEAN is
			-- `check_assert (b)' on debuggee
		local
			s: STRING
		do
			ewb_request.make (Rqst_set_assertion_check)
			ewb_request.send_integer (b.to_integer)
			s := c_tread
			if s /= Void and then s.is_boolean then
				Result := s.to_boolean
			end
		end

feature -- Change

	update_critical_stack_depth (d: INTEGER) is
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		do
			if status /= Void and then status.is_stopped then
				send_rqst_3_integer (Rqst_overflow_detection, 0, 0, d)
			end
		end

feature -- Query

	onces_values (flist: LIST [E_FEATURE]; a_addr: STRING; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE] is
		local
			i: INTEGER
			err_dv: DUMMY_MESSAGE_DEBUG_VALUE
			odv: ABSTRACT_DEBUG_VALUE
			l_feat: FEATURE_I
			l_addr: STRING
			l_class: CLASS_C
			once_r: ONCE_REQUEST
		do
			l_addr := a_addr
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

	dump_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): DUMP_VALUE is
		do
			Result := Debugger_manager.Dump_value_factory.new_object_value (a_addr, a_cl)

		end

	debug_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE is
		do
--			debugged_object_manager.classic_debugged_object_with_class (a_addr, a_cl)
--			Result := dump_value_at_address_with_class (a_addr, a_cl).
			to_implement ("Need to be implemented, but for now this is not used.")
			check False end
		end

--feature {RUN_REQUEST} -- Implementation
--
--	invoke_launched_command (successful: BOOLEAN) is
--			-- Process after the launch of the application according
--			-- to `successful' and the execute `application_launch_command'.
--		do
--		end

feature {APPLICATION_EXECUTION} -- Launching status

	can_not_launch_system_message: STRING is
			-- Message displayed when estudio is unable to launch the system
		local
			env_var_str: STRING_8
		do
			Result := debugger_names.w_Cannot_launch_system.as_string_8

			if ipc_engine.is_vms then
				env_var_str := "logical name"
			else
				env_var_str := "environment variable"
			end
			Result.append_character ('%N')
			if not ipc_engine.valid_ise_ecdbgd_executable then
				Result.append_string_general (
						debugger_names.w_Cannot_find_valid_ecdbgd (
								ipc_engine.ise_ecdbgd_path,
								env_var_str,
								ipc_engine.ise_ecdbgd_varname
							)
					)
			else
				Result.append_string_general (
						debugger_names.w_Cannot_launch_in_allotted_time (
								ipc_engine.ise_timeout,
								env_var_str,
								ipc_engine.ise_timeout_varname
							)
					)
			end
		end

feature {APPLICATION_STATUS}

	once_request: ONCE_REQUEST is
		once
			create Result.make
		end

	ewb_request: EWB_REQUEST is
		once
			create Result.make (Rqst_quit)
		end

	run_request: RUN_REQUEST is
		once
			create Result.make (Rqst_application)
		end

	cont_request: EWB_REQUEST is
		once
			create Result.make (Rqst_cont)
		end

invariant

	ipc_engine_not_void: ipc_engine /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
