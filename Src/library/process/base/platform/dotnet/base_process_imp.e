note
	description: "Process launcher on .NET"
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

create
	make,
	make_with_command_line

feature {NONE} -- Creation

	make (executable_path: READABLE_STRING_GENERAL; argument_list: detachable ITERABLE [READABLE_STRING_GENERAL]; work_directory: detachable READABLE_STRING_GENERAL)
		do
			make_with_executable_and_arguments (executable_path, argument_line_from_arguments (argument_list), work_directory)
		ensure then
			executable_set: executable_path.same_string (executable)
		end

	make_with_command_line (cmd_line: READABLE_STRING_GENERAL; work_directory: detachable READABLE_STRING_GENERAL)
			-- If directory name or file name in `cmd_line' includes space, use double quotes around
			-- those names.
		local
			cmd_arg: LIST [READABLE_STRING_32]
			executable_path: READABLE_STRING_32
		do
			cmd_arg := separated_words (cmd_line)
			check not cmd_arg.is_empty end
			executable_path := cmd_arg [1]
			cmd_arg.start
			cmd_arg.remove
			make_with_executable_and_arguments (executable_path, argument_line_from_arguments (cmd_arg), work_directory)
		end

feature {NONE} -- Initialization

	make_with_executable_and_arguments (executable_path, argument_string: READABLE_STRING_GENERAL; work_directory: detachable READABLE_STRING_GENERAL)
		local
			c: STRING_32
		do
			create child_process.make
			create executable.make_from_string_general (executable_path)
			create argument_line.make_from_string_general (argument_string)
			c := argument_line_from_arguments (<<executable_path>>)
			if not argument_line.is_empty then
				c.append_character (' ')
				c.append (argument_line)
			end
			command_line := c
			initialize_working_directory (work_directory)
			initialize_parameter
		end

	argument_line_from_arguments (argument_list: detachable ITERABLE [READABLE_STRING_GENERAL]): STRING_32
		require
			arguments_attached: attached argument_list as args implies ∀ a: args ¦ attached a
		local
			is_next: BOOLEAN
		do
			create Result.make_empty
			if attached argument_list then
				across
					argument_list as args
				loop
					if attached args as a then
						if is_next then
							Result.append_character (' ')
						else
							is_next := True
						end
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
		local
			retried: BOOLEAN
		do
			if
				not retried and then
				not has_exited
			then
				child_process.kill
				last_termination_successful := True
				force_terminated := True
			end
		rescue
			last_termination_successful := False
			force_terminated := False
			retried := True
			retry
		end

	terminate_tree
			-- <Precursor>
		local
			retried: BOOLEAN
			l_prc: SYSTEM_DLL_PROCESS
		do
			if
				not retried and then
				not has_exited
			then
				create l_prc.make
				l_prc.enter_debug_mode
				terminate_sub_tree (id, False)
				l_prc.leave_debug_mode
				if last_termination_successful or else not abort_termination_when_failed then
					child_process.kill
					last_termination_successful := True
					force_terminated := True
				end
			end
		rescue
			last_termination_successful := False
			force_terminated := False
			retried := True
			retry
		end

	wait_for_exit
			-- <Precursor>
		do
			child_process.wait_for_exit
			check_exit
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER)
			-- <Precursor>
		do
			is_last_wait_timeout := not child_process.wait_for_exit (a_timeout)
			check_exit
		end

	close
			-- <Precursor>
		do
			child_process.close
		end

feature {NONE} -- Control

	platform_launch
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			if not retried then
				child_process.set_start_info (start_info)
				launched := child_process.start
			end
		rescue
			retried := True
			retry
		end

	initialize_after_launch
			-- <Precursor>
		do
			if not child_process.has_exited then
				id := child_process.id
			end
		end

feature -- Interprocess data transmission

	put_string (s: READABLE_STRING_8)
			-- Send `s' into launched process as its input data.
		local
			retried: BOOLEAN
		do
			if retried then
				has_input_error := True
			else
				has_input_error := False
				if attached child_process.standard_input as w then
					w.write_string (s)
				end
			end
		rescue
			retried := True
			retry
		end

	read_output_to_special (buffer: SPECIAL [NATURAL_8])
			-- <Precursor>
		local
			number_of_bytes_read: INTEGER_32
			retried: BOOLEAN
		do
			if retried then
				has_output_stream_error := True
					-- Update `buffer.count` with actual bytes read.
				buffer.keep_head (number_of_bytes_read)
			else
				has_output_stream_error := False
				if
					attached child_process.standard_output as r and then
					attached r.base_stream as s
				then
					number_of_bytes_read := s.read (buffer.native_array, 0, buffer.count)
					if number_of_bytes_read > 0 then
							-- Update `buffer.count` with actual bytes read.
						buffer.keep_head (number_of_bytes_read)
					elseif number_of_bytes_read = 0 then
						has_output_stream_closed := True
							-- Update `buffer.count` with actual bytes read.
						buffer.wipe_out
						check
							buffer_is_empty: buffer.count = 0
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	read_error_to_special (buffer: SPECIAL [NATURAL_8])
			-- <Precursor>
		local
			number_of_bytes_read: INTEGER_32
			retried: BOOLEAN
		do
			if retried then
				has_error_stream_error := True
					-- Update `buffer.count` with actual bytes read.
				buffer.keep_head (number_of_bytes_read)
			else
				has_error_stream_error := False
				if
					attached child_process.standard_error as r and then
					attached r.base_stream as s
				then
					number_of_bytes_read := s.read (buffer.native_array, 0, buffer.count)
					if number_of_bytes_read > 0 then
							-- Update `buffer.count` with actual bytes read.
						buffer.keep_head (number_of_bytes_read)
					elseif number_of_bytes_read = 0 then
						has_error_stream_closed := True
							-- Update `buffer.count` with actual bytes read.
						buffer.wipe_out
						check
							buffer_is_empty: buffer.count = 0
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	exit_code: INTEGER
			-- <Precursor>

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
			exit_code := child_process.exit_code
			close
		end

feature {NONE} -- Implementation

	start_info: SYSTEM_DLL_PROCESS_START_INFO
			-- Process start information
		require
			process_not_running: not is_running
		local
			l_environ_tbl: like environment_variable_table
			l_key, l_value: SYSTEM_STRING
		do
			create Result.make_from_file_name_and_arguments (executable, argument_line)
			if attached working_directory as l_dir then
				Result.set_working_directory (l_dir)
			end
			if hidden then
				Result.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.hidden)
			else
				Result.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.normal)
			end
			if separate_console then
				Result.set_create_no_window (False)
			else
				Result.set_create_no_window (True)
			end
			l_environ_tbl := environment_variable_table
			if not is_io_redirected and then (l_environ_tbl = Void or else l_environ_tbl.is_empty) then
					-- No IO redirection and no environment variable.
				Result.set_use_shell_execute (True)
			else
				Result.set_use_shell_execute (False)
				Result.set_redirect_standard_input (input_direction /= {BASE_REDIRECTION}.no_redirection)
				Result.set_redirect_standard_output (output_direction /= {BASE_REDIRECTION}.no_redirection)
				Result.set_redirect_standard_error (error_direction /= {BASE_REDIRECTION}.no_redirection)
			end
			if l_environ_tbl /= Void and then not l_environ_tbl.is_empty and then attached Result.environment_variables as l_environ_dic then
					-- Clear previous environment table to replace with new one.
				l_environ_dic.clear
				across
					l_environ_tbl as e
				loop
					if attached @ e.key as k and then attached e as i then
						l_key := k.to_cil
						l_value := i.to_cil
						if l_environ_dic.contains_key (l_key) then
								-- Remove previous variable for key `l_key', in case we have duplication
							l_environ_dic.remove (l_key)
						end
						l_environ_dic.add (l_key, l_value)
					end
				end
			end
		end

feature {NONE} -- Termination

	try_terminate_process (a_process: like child_process)
			-- Try to terminate process `a_process'.
			-- Set `last_termination_successful' with True if succeeded.
		require
			a_process_not_void: a_process /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if not a_process.has_exited then
					a_process.kill
				end
				last_termination_successful := True
			end
		rescue
			last_termination_successful := False
			retried := True
			retry
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
			l_prc: detachable SYSTEM_DLL_PROCESS
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
				l_prc := process_by_id (pid)
				if l_prc /= Void then
					try_terminate_process (l_prc)
				else
					last_termination_successful := True
				end
			end
		end

	process_by_id (pid: INTEGER): detachable SYSTEM_DLL_PROCESS
			-- Process instance whose id is `pid'
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {SYSTEM_DLL_PROCESS}.get_process_by_id (pid)
			end
		rescue
			Result := Void
			retried := True
			retry
		end

	direct_subprocess_list (parent_id: INTEGER): LIST [INTEGER]
			-- List of direct subprocess ids of process indicated by id `parent_id'.
		do
			create {LINKED_LIST [INTEGER]} Result.make
			if attached process_id_pair_list as p_tbl then
				across
					p_tbl as p
				loop
					if p.parent_id = parent_id then
						Result.extend (p.pid)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	process_id_pair_list: LINKED_LIST [TUPLE [parent_id: INTEGER; pid: INTEGER]]
			--
		local
			l_cat: SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY
			l_process_list: detachable NATIVE_ARRAY [detachable SYSTEM_STRING]
			i, l_upper: INTEGER
			l_prc_name_id_tbl: HASH_TABLE [INTEGER, STRING]
			l_performance_counter: SYSTEM_DLL_PERFORMANCE_COUNTER
		do
			create Result.make

				-- Get process snapshot and store process instance name and its process id in `l_prc_name_id_tbl'.
			create l_cat.make_from_category_name (once "Process")
			l_process_list := l_cat.get_instance_names
			if l_process_list /= Void then
				create l_prc_name_id_tbl.make (l_process_list.count)
				from
					i := l_process_list.lower
					l_upper := l_process_list.upper
				until
					i > l_upper
				loop
					if attached l_process_list.item (i) as l_process_name then
						create l_performance_counter.make_with_category_name (once "Process", once "ID Process", l_process_name, True)
						l_prc_name_id_tbl.force (l_performance_counter.raw_value.as_integer_32, l_process_name)
					end
					i := i + 1
				end
					-- Find out parent process id for each process in `l_prc_name_id_tbl'.
				across
					l_prc_name_id_tbl as p
				loop
					Result.extend ([parent_process_id (@ p.key), p])
				end
			end
		end

	parent_process_id (a_process_instance_name: SYSTEM_STRING): INTEGER
			-- Parent process id of process named `a_process_instance_name'
		require
			a_process_instance_name_attached: a_process_instance_name /= Void
		local
			l_performance_counter: SYSTEM_DLL_PERFORMANCE_COUNTER
		do
			create l_performance_counter.make_from_category_name_and_counter_name_and_instance_name (once "Process", once "Creating Process ID", a_process_instance_name)
			Result := l_performance_counter.raw_value.as_integer_32
		end

feature {NONE} -- Access

	child_process: SYSTEM_DLL_PROCESS
			-- Child process.

	is_io_redirected: BOOLEAN
			-- Is input, output or error redirected?
		do
			Result :=
				input_direction /= {BASE_REDIRECTION}.no_redirection or
				output_direction /= {BASE_REDIRECTION}.no_redirection or
				error_direction /= {BASE_REDIRECTION}.no_redirection
		end

	executable: STRING_32
			-- Program which will be launched

	argument_line: STRING_32
			-- Argument list of `executable'
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
