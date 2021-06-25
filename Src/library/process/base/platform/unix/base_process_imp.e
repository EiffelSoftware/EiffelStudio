note
	description: "Process launcher on a non-windows platform."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASE_PROCESS_IMP

inherit
	BASE_PROCESS

	PROCESS_UNIX_OS
		export
			{NONE} all
		end

	PROCESS_INFO_IMP
		rename
			command_line as environment_command_line,
			launch as environment_launch
		export
			{NONE} all
		end

create
	make,
	make_with_command_line

feature {NONE} -- Initialization

	make (executable_name: READABLE_STRING_GENERAL; argument_list: detachable ITERABLE [READABLE_STRING_GENERAL]; work_directory: detachable READABLE_STRING_GENERAL)
		local
			a: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			create a.make (0)
			if attached argument_list then
				across
					argument_list as argument
				loop
					a.extend (argument)
				end
			end
			setup_command (executable_name, a, work_directory)
			create_child_process_manager (executable_name, a, working_directory)
			initialize_parameter
		end

	make_with_command_line (cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
		local
			l_exec_name: STRING_32
			l_args: detachable like separated_words
		do
			l_args := separated_words (cmd_line)
			if l_args.is_empty then
				l_exec_name := " "
				l_args := Void
			elseif l_args.count = 1 then
				l_exec_name := l_args.first
				l_args := Void
			else
				l_exec_name := l_args.first
				l_args.start
				l_args.remove
			end
			make (l_exec_name, l_args, a_working_directory)
		end

feature -- Control

	terminate
			-- <Precursor>
		do
			internal_terminate (False)
		end

	terminate_tree
			-- <Precursor>
		do
			if is_launched_in_new_process_group then
				internal_terminate (True)
			else
				internal_terminate (False)
			end
		end

	wait_for_exit
			-- <Precursor>
		do
			child_process.wait_for_process (id, True)
			has_process_exited := not child_process.is_executing
			check_exit
		end

	close
			-- <Precursor>
		do
			if is_launched_in_new_process_group and then is_terminal_control_enabled then
				attach_terminals (process_id)
			end
			child_process.close_pipes
		end

feature {NONE} -- Control

	platform_launch
			-- <Precursor>
		local
			pid: like id
		do
			initialize_child_process
			if is_launched_in_new_process_group and then is_terminal_control_enabled then
				attach_terminals (process_id)
			end
			child_process.spawn_nowait (is_terminal_control_enabled, environment_variable_table, is_launched_in_new_process_group)
			pid := child_process.process_id
			id := pid
			launched := pid /= -1
		end

	initialize_after_launch
			-- <Precursor>
		do
		end

feature -- Interprocess data transmission

	put_string (s: READABLE_STRING_8)
			-- <Precursor>
		do
			child_process.put_string (s)
			has_input_error := child_process.has_write_error
		end

	read_output_to_special (buffer: SPECIAL [NATURAL_8])
			-- <Precursor>
		do
			if buffer.count > 0 then
				child_process.read_output_to_special (buffer)
				has_output_stream_error := child_process.has_output_stream_error
				has_output_stream_closed := buffer.count = 0
			end
		end

	read_error_to_special (buffer: SPECIAL [NATURAL_8])
			-- <Precursor>
		do
			if buffer.count > 0 then
				child_process.read_error_to_special (buffer)
				has_error_stream_error := child_process.has_error_stream_error
				has_error_stream_closed := buffer.count = 0
			end
		end

feature -- Status report

	exit_code: INTEGER
			-- <Precursor>
		do
			Result := child_process.exit_code
		end

feature {NONE} -- Status update

	update_process_state
			-- <Precursor>
		do
			child_process.wait_for_process (id, False)
			has_process_exited := not child_process.is_executing
		end

	close_process
			-- <Precursor>
		do
			close
		end

feature {NONE} -- Implementation

	initialize_child_process
			-- Initialize `child_process'.
		local
			u: UTF_CONVERTER
		do
			if attached input_file_name as l_file_name then
				child_process.set_input_file_name (u.escaped_utf_32_string_to_utf_8_string_8 (l_file_name))
			else
				child_process.set_input_file_name (Void)
			end
			if attached output_file_name as l_file_name then
				child_process.set_output_file_name (u.escaped_utf_32_string_to_utf_8_string_8 (l_file_name))
			else
				child_process.set_output_file_name (Void)
			end
			if error_direction = {BASE_REDIRECTION}.to_same_as_output then
				child_process.set_error_same_as_output
			else
				if attached error_file_name as l_file_name then
					child_process.set_error_file_name (u.escaped_utf_32_string_to_utf_8_string_8 (l_file_name))
				else
					child_process.set_error_file_name (Void)
				end
			end
		end

	setup_command (a_exec_name: READABLE_STRING_GENERAL; a_args: detachable LIST [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL)
			-- Setup command line.
		require
			a_exec_name_not_void: attached a_exec_name
			a_exec_name_not_empty: not a_exec_name.is_empty
		local
			l_cmd_line: STRING_32
		do
			create l_cmd_line.make (a_exec_name.count)
			l_cmd_line.append_string_general (a_exec_name)

			initialize_working_directory (a_working_directory)

			arguments := a_args

			if attached a_args then
				across a_args as l_args loop
					l_cmd_line.append_character (' ')
					l_cmd_line.append_string_general (l_args)
				end
			end
			command_line := l_cmd_line
		ensure
			command_line_attached: attached command_line
			command_line_not_empty: not command_line.is_empty
			arguments_set:
				(attached a_args implies (attached arguments as l_args and then l_args.count = a_args.count)) and
				(a_args = Void implies arguments = Void)
		end

	create_child_process_manager (executable_name: READABLE_STRING_GENERAL; argument_list: ARRAYED_LIST [READABLE_STRING_GENERAL]; work_directory: detachable READABLE_STRING_GENERAL)
			-- Create child process manager
		require
			executable_name_attached: attached executable_name
			executable_name_not_empty: not executable_name.is_empty
		do
			create child_process.make (executable_name, argument_list, work_directory)
			child_process.set_close_nonstandard_files (True)
		end

feature {NONE} -- Termination

	internal_terminate (is_tree: BOOLEAN)
			-- Terminate current launched process.
			-- If `is_tree' is True, terminate whole process group.
		require
			process_launched: launched
		do
			child_process.terminate_hard (is_tree)
			force_terminated := True
		end

feature {NONE} -- Access

	child_process: PROCESS_UNIX_PROCESS_MANAGER
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
