note
	description: "Process launcher on Windows."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASE_PROCESS_IMP

inherit
	BASE_PROCESS
		redefine
			wait_for_exit_with_timeout
		end

	PROCESS_UTILITY
		export
			{NONE} all
		end

create
	make,
	make_with_command_line

feature {NONE} -- Creation

	make (executable_name: READABLE_STRING_GENERAL; argument_list: detachable ITERABLE [READABLE_STRING_GENERAL]; work_directory: detachable READABLE_STRING_GENERAL)
		do
			make_with_command_line (command_line_from_arguments (executable_name, argument_list), work_directory)
		end

	make_with_command_line (cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
		do
			create child_process.make
			create command_line.make_from_string_general (cmd_line)
			initialize_working_directory (a_working_directory)
			initialize_parameter
		end

feature {NONE} -- Initialization

	command_line_from_arguments (executable_name: READABLE_STRING_GENERAL; argument_list: detachable ITERABLE [READABLE_STRING_GENERAL]): STRING_32
		require
			executable_name_attached: attached executable_name
			arguments_attached: attached argument_list as args implies ∀ a: args ¦ attached a
		do
			create Result.make (executable_name.count)
			Result.append_string_general (executable_name)
			if attached argument_list then
				across
					argument_list as args
				loop
					if attached args as a then
						Result.append_character (' ')
						if a.is_empty or else separated_words (a).count > 1 then
							Result.append_character ('"')
							Result.append_string_general (a)
							Result.append_character ('"')
						else
							Result.append_string_general (a)
						end
					end
				end
			end
		end

feature -- Control

	terminate
			-- <Precursor>
		do
			if attached child_process.process_handle as h and then h.is_open then
				try_terminate_process (h.item)
				force_terminated := last_termination_successful
			else
				last_termination_successful := False
				force_terminated := False
			end
		end

	terminate_tree
			-- <Precursor>
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

	wait_for_exit
			-- <Precursor>
		do
			check
				from_precondition_process_launched: attached child_process.process_handle as h
			then
				{WEL_API}.wait_for_single_object (h.item, {WEL_API}.infinite).do_nothing
			end
			check_exit
		end

	wait_for_exit_with_timeout (timeout: INTEGER)
			-- <Precursor>
		local
			w: INTEGER
		do
			check
				from_precondition_process_launched: attached child_process.process_handle as h
			then
				w := {WEL_API}.wait_for_single_object (h.item, timeout)
				if w = {WEL_API}.wait_object_0 then
						-- The process has terminated.
				elseif w = {WEL_API}.wait_timeout then
						-- Timeout has elapsed.
					is_last_wait_timeout := True
				elseif w = {WEL_API}.wait_failed then
						-- Error during wait.
					debug ("to_implement")
						(create {REFACTORING_HELPER}).to_implement ("Support error handling for wait_for_exit_with_timeout.")
					end
				end
			end
			check_exit
		end

	wait_for_input
			-- Wait launched process to start receiving events.
		require
			process_launched: launched
		do
			if attached child_process.process_handle as h then
				{WEL_API}.wait_for_input_idle (h.item, {WEL_API}.infinite).do_nothing
			end
		end

	close
			-- <Precursor>
		do
			child_process.close_process_handle
			child_process.close_io
		end

feature {NONE} -- Control

	platform_launch
			-- <Precursor>
		do
			initialize_child_process
			child_process.launch (command_line, working_directory, separate_console, detached_console)
			launched := child_process.launched
		end

	initialize_after_launch
			-- <Precursor>
		do
			if attached child_process.process_handle then
				id := child_process.process_id.as_integer_32
			else
				last_termination_successful := False
			end
		end

feature -- Interprocess data transmission

	put_string (s: READABLE_STRING_8)
			-- <Precursor>
		local
			h: like input_file_handle
			n: like {FILE_HANDLE}.last_written_bytes
		do
			h := input_file_handle
			from
				h.put_string (child_process.std_input, s)
				has_input_error := not h.last_write_successful
				n := h.last_written_bytes
			until
				has_input_error or n = s.count
			loop
				h.put_string (child_process.std_input, s.tail (s.count - n + 1))
				has_input_error := not h.last_write_successful
				n := n + h.last_written_bytes
			end
		end

--	output_reader: separate BASE_PROCESS_READER
--		do
--			create Result.make ()
--		end

	read_output_to_special (buffer: SPECIAL [NATURAL_8])
			-- <Precursor>
		local
			number_of_bytes_read: NATURAL_32
			last_error: NATURAL_32
		do
			if {WEL_API}.cwin_read_file_with_error (child_process.std_output, $buffer, buffer.count.as_natural_32, $number_of_bytes_read, default_pointer, $last_error) then
					-- There was no error.
				has_output_stream_error := False
					-- Update `buffer.count` with actual bytes read.
				buffer.keep_head (number_of_bytes_read.as_integer_32)
			elseif last_error = {WEL_WINDOWS_ERROR_MESSAGES}.error_broken_pipe_value.as_natural_32 then
					-- The other end of the pipe has been closed.
				has_output_stream_closed := True
				has_output_stream_error := False
					-- Update `buffer.count` with actual bytes read.
				buffer.keep_head (number_of_bytes_read.as_integer_32)
			else
				has_output_stream_error := True
					-- Update `buffer.count` with actual bytes read.
				buffer.wipe_out
				check
					buffer_is_empty: buffer.count = 0
				end
			end
		end

	read_error_to_special (buffer: SPECIAL [NATURAL_8])
			-- <Precursor>
		local
			number_of_bytes_read: NATURAL_32
			last_error: NATURAL_32
		do
			if {WEL_API}.cwin_read_file_with_error (child_process.std_error, $buffer, buffer.count.as_natural_32, $number_of_bytes_read, default_pointer, $last_error) then
					-- There was no error.
				has_error_stream_error := False
					-- Update `buffer.count` with actual bytes read.
				buffer.keep_head (number_of_bytes_read.as_integer_32)
			elseif last_error = {WEL_WINDOWS_ERROR_MESSAGES}.error_broken_pipe_value.as_natural_32 then
					-- The other end of the pipe has been closed.
				has_error_stream_closed := True
				has_error_stream_error := False
					-- Update `buffer.count` with actual bytes read.
				buffer.keep_head (number_of_bytes_read.as_integer_32)
			else
				has_error_stream_error := True
					-- Update `buffer.count` with actual bytes read.
				buffer.wipe_out
				check
					buffer_is_empty: buffer.count = 0
				end
			end
		end

feature {NONE} -- Interprocess data transmission

	input_file_handle: FILE_HANDLE
			-- File handle operations accessor.
		once
			create Result
		end

feature -- Status report

	exit_code: INTEGER
			-- <Precursor>
		do
			Result := child_process.last_process_result
		end

	is_last_wait_timeout: BOOLEAN
			-- Did the last `wait_for_exit_with_timeout' time out?

feature {NONE} -- Status update

	update_process_state
			-- <Precursor>
		do
			has_process_exited := child_process.has_exited
		end

	close_process
			-- <Precursor>
		do
			close
		end

feature {NONE} -- Implementation

	initialize_child_process
			-- Initialize `child_process'.
		do
			if hidden then
				child_process.run_hidden
			end
			child_process.set_input_direction (input_direction)
			child_process.set_output_direction (output_direction)
			child_process.set_error_direction (error_direction)
			child_process.set_environment_variables (environment_variable_table)
			if input_direction = {BASE_REDIRECTION}.to_file then
				check attached input_file_name as l_input_file_name then
					child_process.set_input_file_name (l_input_file_name)
				end
			end
			if output_direction = {BASE_REDIRECTION}.to_file then
				check attached output_file_name as l_output_file_name then
					child_process.set_output_file_name (l_output_file_name)
				end
			end
			if error_direction = {BASE_REDIRECTION}.to_file then
				check attached error_file_name as l_error_file_name then
					child_process.set_error_file_name (l_error_file_name)
				end
			end
		end

feature {NONE} -- Termination

	try_terminate_process (handle: POINTER)
			-- Try to terminate process `handle'.
			-- Set `last_termination_successful' with True if succeeded.
		require
			handle_not_void: handle /= default_pointer
		local
			l_prc_result: INTEGER
		do
			last_termination_successful := {WEL_API}.get_exit_code_process (handle, $l_prc_result)
			if
				last_termination_successful and then
				l_prc_result = {WEL_API}.still_active
			then
				last_termination_successful := {WEL_API}.terminate_process (handle, 0)
			end
		end

	terminate_process_by_id (pid: INTEGER)
			-- Try to terminate process indicated by process id `pid'.
			-- Set `last_termination_successful' with True if succeeded.
		require
			pid_not_negative: pid >= 0
		local
			handle: POINTER
		do
			if debug_privilege_enabled then
					-- If debug privilege enabled, we try to open process with terminate and query rights.
				handle := cwin_open_process (cwin_process_terminate.bit_or (cwin_process_query_information), False, pid)
			else
					-- If debug privilege not enabled, we try to open process with all possible rights.
				handle := cwin_open_process (cwin_process_all_access, False, pid)
			end
			if handle = default_pointer then
				last_termination_successful := False
			else
				try_terminate_process (handle)
				{WEL_API}.close_handle (handle).do_nothing
			end
		end

	direct_subprocess_list (parent_id: INTEGER): LIST [INTEGER]
			-- List of direct subprocess ids of process indicated by id `parent_id'.
		do
			create {ARRAYED_LIST [INTEGER]} Result.make (0)
			if attached process_id_pair_list as p_tbl then
				across
					p_tbl as p
				loop
					if p.parent_id = parent_id then
						Result.extend (p.process_id)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	terminate_sub_tree (pid: INTEGER; is_self: BOOLEAN)
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
			if
				(l_success or else not abort_termination_when_failed) and then
				is_self
			then
				terminate_process_by_id (pid)
			end
		end

	adjust_debug_privilege (a_success: TYPED_POINTER [BOOLEAN]; a_privilege: INTEGER; a_previous: TYPED_POINTER [INTEGER])
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

	cwin_se_privilege_enabled: INTEGER
			-- Enable privilege constant
		external
			"C macro use <windows.h>"
		alias
			"SE_PRIVILEGE_ENABLED"
		end

	debug_privilege_enabled: BOOLEAN
			-- Is debug privilege enabled?

feature {NONE} -- Access

	child_process: WEL_PROCESS
			-- Child process.
		attribute end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
