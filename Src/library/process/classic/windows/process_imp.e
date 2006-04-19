indexing
	description: "Process launcher on Win32"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS

	THREAD_CONTROL
		export
			{NONE} all
		end

	WEL_PROCESS_LAUNCHER
		rename
			hidden as wel_hidden,
			launch as wel_launch
		export
			{NONE}all
		end

	WEL_TOOLHELP
		export
			{NONE}all
		undefine
			cwin_close_handle

		end

create
	make,
	make_with_command_line

feature{NONE} -- Initialization

	make (a_exec_name: STRING; args: LIST[STRING]; a_working_directory: STRING) is
		do
			create arguments.make
			create command_line.make_from_string (a_exec_name)

			if args /= Void then
				from
					args.start
				until
					args.after
				loop
					command_line.append (" ")
					command_line.append (args.item)
					arguments.extend (args.item)
					args.forth
				end
			end
			initialize_working_directory (a_working_directory)
			initialize_parameter
		end

	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
		do
			create command_line.make_from_string (cmd_line)
			initialize_working_directory (a_working_directory)
			initialize_parameter
		end

feature -- Control

	launch is
			-- Launch process.	
		local
			l_timeout: BOOLEAN
		do
				-- For repeated process launch, make sure all listening threads have exited.				
			if timer.has_started then
				l_timeout := timer.wait (0)
			end
			on_start
			initialize_child_process
				-- Launch process.
			child_process.launch (command_line, working_directory, separate_console)
			launched := child_process.launched
			if launched then
				initialize_after_launch
				on_launch_successed
			else
				on_launch_failed
			end
		end

	terminate is
			-- Terminate launched process.
		do
			try_terminate_process (child_process.process_info.process_handle)
			force_terminated := last_termination_successful
		end

	terminate_tree is
			-- Terminate process tree starting from current launched process.
		local
			l_pri, l_pri2: INTEGER
			l_pri_success: BOOLEAN
		do
				-- Enable debug privilege so we can open child process with termination right.
			adjust_debug_privilege ($debug_privilege_enabled, cwin_se_privilege_enabled, $l_pri)
				-- Terminate child process tree.
			terminate_sub_tree (id, False)
			if debug_privilege_enabled then
				adjust_debug_privilege ($l_pri_success, l_pri, $l_pri2)
			end
				-- Terminate launched process.
			if last_termination_successful or else not abort_termination_when_failed then
				terminate
			else
				last_termination_successful := False
				force_terminated := False
			end
		end

	wait_for_exit is
			-- Wait until process has exited.
		local
			l_wait: BOOLEAN
		do
			l_wait := timer.wait (0)
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER) is
			-- Wait launched process to exit for at most `a_timeout' milliseconds.
			-- Check `has_exited' after to see if launched process has exited.
		local
			l_timeout: BOOLEAN
		do
			l_timeout := not timer.wait (a_timeout)
		end

feature -- Interprocess data transmission

	put_string (s: STRING) is
			-- Send `s' into launched process as its input data.
		do
			append_input_buffer (s)
		end

feature -- Status reporting

	id: INTEGER is
		do
			Result := internal_id
		end

	has_exited: BOOLEAN is
		do
			Result := has_cleaned_up
		end

	exit_code: INTEGER is
		do
			if child_process /= Void then
				Result := child_process.last_process_result
			end
		end

feature{PROCESS_TIMER} -- Process status checking

	check_exit is
			-- Check if process has exited.
		local
			l_threads_exited: BOOLEAN
		do
			if not has_exited then
				if not process_has_exited then
					process_has_exited := child_process.has_exited
						-- If launched process exited, send signal to all listenning threads.
					if process_has_exited then
						if in_thread /= Void then
							in_thread.set_exit_signal
						end
						if out_thread /= Void then
							out_thread.set_exit_signal
						end
						if err_thread /= Void then
							err_thread.set_exit_signal
						end
					end
				else
					l_threads_exited := ((in_thread /= Void) implies in_thread.terminated) and
							  ((out_thread /= Void) implies out_thread.terminated) and
							  ((err_thread /= Void) implies err_thread.terminated)
							  -- If all listenning threads exited, perform clean up.
					if l_threads_exited then
						if not has_cleaned_up then
							timer.destroy
							if input_buffer /= Void then
								input_buffer.clear_all
							end
							child_process.close_process_handle
							child_process.close_io
							has_cleaned_up := True
								-- Call registered actions.
							if force_terminated then
								on_terminate
							else
								on_exit
							end
						end
					end
				end
			end
		end

feature{NONE} -- Interprocess IO

	input_buffer: STRING
			-- Buffer used to store input data of process
			-- This buffer is used temporarily to store data that can not be
			-- consumed by launched process.

	append_input_buffer (a_input:STRING) is
			-- Append `a_input' to `input_buffer'.
		require
			a_input_not_void: a_input /= Void
		do
			input_mutex.lock
			input_buffer.append (a_input)
			input_mutex.unlock
		end

feature{PROCESS_IO_LISTENER_THREAD} -- Interprocess IO

	last_output_bytes: INTEGER
			-- Number of bytes of data read from output of process

	last_error_bytes: INTEGER
			-- Number of bytes of data read from error of process

	last_input_bytes: INTEGER
			-- Number of bytes in `input_buffer' wrote to process the last time

	write_input_stream is
			-- Write at most `buffer_size' bytes of data in `input_buffer' into launched process.
			--|Note: This feature will be used in input listening thread.
		require
			process_running: is_running
			input_redirected_to_stream: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			l_cnt: INTEGER
			l_left: INTEGER
			l_str: STRING
		do
			input_mutex.lock
			l_cnt := input_buffer.count
			if l_cnt > 0 then
				last_input_bytes := l_cnt.min (buffer_size)
				create l_str.make (last_input_bytes)
				l_left := l_cnt - last_input_bytes
				l_str.append (input_buffer.substring (1, last_input_bytes))
				input_buffer.keep_tail (l_left)
			else
				last_input_bytes := 0
			end
			input_mutex.unlock
			if l_str /= Void then
				input_file_handle.put_string (child_process.std_input, l_str)
			end
		end

	read_output_stream is
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in output listening thread.
		require
			process_running: is_running
			output_redirected_to_agent: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			output_handler_not_void: output_handler /= Void
		local
			succ: BOOLEAN
			bytes_avail: INTEGER
		do
			succ := cwin_peek_named_pipe (child_process.std_output, default_pointer, 0, default_pointer, $bytes_avail, default_pointer)
			if succ and bytes_avail > 0 then
				output_file_handle.read_stream (child_process.std_output, buffer_size.min (bytes_avail))
				succ := output_file_handle.last_read_successful
				if succ then
					last_output_bytes := output_file_handle.last_read_bytes
					output_handler.call ([output_file_handle.last_string])
				end
			else
				last_output_bytes := 0
			end
		end

	read_error_stream is
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in error listening thread.			
		require
			process_running: is_running
			error_redirected_to_agent: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			error_hander_not_viod: error_handler /= Void
		local
			succ: BOOLEAN
			bytes_avail: INTEGER
		do
			succ := cwin_peek_named_pipe (child_process.std_output, default_pointer, 0, default_pointer, $bytes_avail, default_pointer)
			if succ and bytes_avail > 0 then
				error_file_handle.read_stream (child_process.std_output, buffer_size.min (bytes_avail))
				succ := error_file_handle.last_read_successful
				if succ then
					last_error_bytes := error_file_handle.last_read_bytes
					error_handler.call ([error_file_handle.last_string])
				end
			else
				last_error_bytes := 0
			end
		end

feature{NONE} -- Implementation

	cwin_peek_named_pipe (a_handle: POINTER; a_buffer:  POINTER;  buf_size: INTEGER; bytes_read: POINTER; bytes_avail: POINTER; a_integer: POINTER): BOOLEAN is
			-- Peek a pipe to see whether there is data in it.
		external
			"C blocking macro signature (HANDLE, LPVOID, DWORD, LPDWORD, LPDWORD, LPDWORD): BOOL use <windows.h>"
		alias
			"PeekNamedPipe"
		end

	initialize_child_process is
			-- Initialize `child_process'.
		do
			create child_process.make
			if hidden then
				child_process.run_hidden
			end
			child_process.set_input_direction (input_direction)
			child_process.set_output_direction (output_direction)
			child_process.set_error_direction (error_direction)
			if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
				child_process.set_input_file_name (input_file_name)
			end
			if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
				child_process.set_output_file_name (output_file_name)
			end
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
				child_process.set_error_file_name (error_file_name)
			end
		ensure
			child_process_not_void: child_process /= Void
		end

	initialize_after_launch is
			-- Initialize when process has been launched successfully.
		do
			internal_id := child_process.process_info.process_id
			process_has_exited := False
			force_terminated := False
			last_termination_successful := True
			has_cleaned_up := False
			start_listening_threads
		end

	start_listening_threads is
			-- Start listening threads.
		do
			if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create input_mutex.make
				create input_file_handle
				create input_buffer.make (4096)
				create in_thread.make (Current)
				in_thread.launch
			else
				in_thread := Void
			end
			if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
				create output_file_handle
				create out_thread.make (Current)
				out_thread.launch
			else
				out_thread := Void
			end
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
				create error_file_handle
				create err_thread.make (Current)
				err_thread.launch
			else
				err_thread := Void
			end
			check timer.destroyed end
			timer.start
		end

	try_terminate_process (handle: POINTER) is
			-- Try to terminate process `handle'.
			-- Set `last_termination_successful' with True if succeeded.
		require
			handle_not_void: handle /= default_pointer
		local
			l_prc_result: INTEGER
		do
			last_termination_successful := cwin_exit_code_process (handle, $l_prc_result)
			if last_termination_successful then
				if l_prc_result = cwin_still_active then
					last_termination_successful := cwin_terminate_process (handle, 0)
				end
			end
		end

	terminate_process_by_id (pid: INTEGER) is
			-- Try to terminate process indicated by process id `pid'.
			-- Set `last_termination_successful' with True if succeeded.
		require
			pid_not_negative: pid >= 0
		local
			handle: POINTER
			l_file_handle: FILE_HANDLE
			l_success: BOOLEAN
		do
			if debug_privilege_enabled then
					-- If debug privilege enabled, we try to open process with terminate and query rights.
				handle := cwin_open_process (cwin_process_terminate.bit_or (cwin_process_query_information), False, pid)
			else
					-- If debug privilege not enabled, we try to open process with all possible rights.
				handle := cwin_open_process (cwin_process_all_access, False, pid)
			end
			if handle /= default_pointer then
				try_terminate_process (handle)
				create l_file_handle
				l_success := l_file_handle.close (handle)
			else
				last_termination_successful := False
			end
		end

	direct_subprocess_list (parent_id: INTEGER): LIST [INTEGER] is
			-- List of direct subprocess ids of process indicated by id `parent_id'.
		local
			p_tbl: LINKED_LIST [ WEL_PROCESS_ID_PAIR ]
		do
			create {LINKED_LIST [INTEGER]}Result.make
			p_tbl := process_id_pair_list
			if p_tbl /= Void then
				from
					p_tbl.start
				until
					p_tbl.after
				loop
					if p_tbl.item.parent_id = parent_id then
						Result.extend (p_tbl.item.id)
					end
					p_tbl.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	terminate_sub_tree (pid: INTEGER; is_self: BOOLEAN) is
			-- Try to termiate all sub-processes of process `pid'.
			-- If `is_self' is True, terminate `pid' after all its child processes have
			-- been terminated.
			-- Set `last_termination_successful' to True if succeeded.
		local
			child_prc_list: LIST [INTEGER]
			child_prc_list2: LIST [INTEGER]
			l_success: BOOLEAN
			done: BOOLEAN
		do
			l_success := True
			child_prc_list := direct_subprocess_list (pid)
			if not child_prc_list.is_empty then
				from
				until
					done or (not l_success and abort_termination_when_failed)
				loop
					from
						child_prc_list.start
					until
						child_prc_list.after or not l_success
					loop
						terminate_sub_tree (child_prc_list.item, True)
						l_success := last_termination_successful
						if l_success or else not abort_termination_when_failed then
							child_prc_list.forth
						end
					end
					if l_success or not abort_termination_when_failed then
							-- Check if there is new spawned sub-process.
						child_prc_list2 := direct_subprocess_list (pid)
						if child_prc_list2.is_empty then
							done := True
						else
							from
								child_prc_list2.start
							until
								child_prc_list2.after
							loop
								if child_prc_list.has (child_prc_list2.item) then
										-- We don't terminate a process more than once.
									child_prc_list2.remove
								else
									child_prc_list2.forth
								end
							end
							if child_prc_list2.is_empty then
								done := True
							else
								child_prc_list := child_prc_list2
							end
						end
					end
				end
			end
			if l_success or else not abort_termination_when_failed then
				if is_self then
					terminate_process_by_id (pid)
				end
			end
		end

feature{NONE} -- Implementation

	adjust_debug_privilege (a_success: TYPED_POINTER [BOOLEAN]; a_privilege: INTEGER; a_previous: TYPED_POINTER [INTEGER]) is
			-- Enable debug privilege `a_privilege' for process termination.
			-- Set `a_success' to True if privilege is enabled successfully and preivous debug privilege value
			-- is stored in `a_previous'.
		external
			"C inline use <windows.h>"
		alias
			"[
				{
					HANDLE hToken;
					LUID DebugValue;
					TOKEN_PRIVILEGES tkp, ptkp;
					DWORD dwResult;
					DWORD bsize;

					if (0 == OpenProcessToken(GetCurrentProcess(),
					   TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken)) {
					   *$a_success=FALSE;
					   return;
					}
					if (0 == LookupPrivilegeValue((LPWSTR) NULL,SE_DEBUG_NAME,
					         &DebugValue)) {
					    CloseHandle(hToken);
					    *$a_success=FALSE;
					    return;
					}
					tkp.PrivilegeCount = 1;
					tkp.Privileges[0].Luid = DebugValue;
					tkp.Privileges[0].Attributes = $a_privilege;
					AdjustTokenPrivileges(hToken, FALSE, &tkp,
					      sizeof(TOKEN_PRIVILEGES),
					      &ptkp,
					      &bsize);

					dwResult = GetLastError();
					if (dwResult != ERROR_SUCCESS) {
					    *$a_success=FALSE;
					    return;
					}
					*$a_previous=ptkp.Privileges[0].Attributes;
					CloseHandle(hToken);
					*$a_success=TRUE;
				}
			]"
		end

	cwin_se_privilege_enabled: INTEGER is
			-- Enable privilege constant
		external
			"C macro use <windows.h>"
		alias
			"SE_PRIVILEGE_ENABLED"
		end

feature{NONE} -- Implementation

	out_thread: PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: PROCESS_ERROR_LISTENER_THREAD
	in_thread: PROCESS_INPUT_LISTENER_THREAD
			-- Threads to listen to output and error from child process.

	child_process: WEL_PROCESS
			-- Child process

	process_has_exited: BOOLEAN
			-- Has process exited?

	internal_has_exited: BOOLEAN
			-- Have process and all listening threads exited?

	has_cleaned_up: BOOLEAN
			-- Has clean up finished when launched exited?
			-- Clean up includes close io redirection pipes and process handle.

	debug_privilege_enabled: BOOLEAN
			-- Is debug privilege enabled?

	input_mutex: MUTEX
			-- Mutex used to synchorinze listening threads

	input_file_handle,
	output_file_handle,
	error_file_handle: FILE_HANDLE
			-- Handles used	to read and write file

	internal_id: INTEGER
			-- Internal process id

end
