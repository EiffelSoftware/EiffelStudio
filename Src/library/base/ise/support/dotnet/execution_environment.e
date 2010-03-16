note

	description:
		"The objects available from the environment at time of execution"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class EXECUTION_ENVIRONMENT

feature -- Access

	command_line: ARGUMENTS
			-- Command line that was used to start current execution
		once
			create Result
		end

	current_working_directory: STRING
			-- Directory of current execution
		do
			if attached {ENVIRONMENT}.current_directory as l_dir then
				Result := l_dir
			else
				Result := "."
			end
		end

	default_shell: STRING
			-- Default shell
		local
			l_result: detachable STRING
		once
			l_result := get ("SHELL")
			if l_result = Void then
				create {STRING} Result.make (0)
			else
				Result := l_result
			end
		end

	get (s: STRING): detachable STRING
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		require
			s_exists: s /= Void
		do
			if attached {ENVIRONMENT}.get_environment_variable (s.to_cil) as cs then
				create Result.make_from_cil (cs)
			end
		end

	home_directory_name: STRING
			-- Directory name corresponding to the home directory.
		require
			home_directory_supported: Operating_environment.home_directory_supported
		do
			if attached {ENVIRONMENT}.get_folder_path ({SPECIAL_FOLDER_IN_ENVIRONMENT}.local_application_data) as l_home then
				Result := l_home
			elseif attached get ("HOMEPATH") as l_home then
				Result := l_home
			else
				Result := ""
			end
		end

	root_directory_name: STRING
			-- Directory name corresponding to the root directory.
		require
			root_directory_supported: Operating_environment.root_directory_supported
		do
			Result := "/"
		ensure
			result_not_void: Result /= Void
		end

	environment_variables: HASH_TABLE [STRING, STRING]
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		local
			l_key: detachable SYSTEM_STRING
			l_value: detachable SYSTEM_STRING
		do
			if attached {IDICTIONARY} {ENVIRONMENT}.get_environment_variables as l_dic and then attached {IENUMERATOR} l_dic.get_enumerator_2 as l_enumerator then
				create Result.make (l_dic.count)
				from
				until
					not l_enumerator.move_next
				loop
					if attached {DICTIONARY_ENTRY} l_enumerator.current_ as l_entry then
						l_key ?= l_entry.key
						l_value ?= l_entry.value
						check
							l_key /= Void
							l_value /= Void
						end
						Result.force (l_value, l_key)
					end
				end
			else
				create Result.make (0)
			end
		end

feature -- Status

	return_code: INTEGER
			-- Status code set by last call to `system' or `put'

feature -- Status setting

	change_working_directory (path: STRING)
			-- Set the current directory to `path'
		do
			{ENVIRONMENT}.set_current_directory (path)
		end

	put (value, key: STRING)
			-- Set the environment variable `key' to `value'.
		require
			key_exists: key /= Void
			key_meaningful: key.count > 0
			value_exists: value /= Void
		do
			{ENVIRONMENT}.set_environment_variable (key, value)
			return_code := 0
		ensure
			variable_set: (return_code = 0) implies
				(equal (value, get (key)) or else (value.is_empty and then (get (key) = Void)))
		end

	system (s: STRING)
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		do
			internal_launch (s, True)
		end

	launch (s: STRING)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		do
			internal_launch (s, False)
		end

	sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		require
			non_negative_nanoseconds: nanoseconds >= 0
		do
			{SYSTEM_THREAD}.sleep_time_span
				({TIME_SPAN}.from_ticks (nanoseconds // 100))
		end

feature {NONE} -- Implementation

			-- Handle to last launched process through `launch'. Used by `system'
			-- to wait until process is finished.

	internal_launch (s: STRING; should_wait: BOOLEAN)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If the current directory is a volume, then use the old
			-- style of launch. Otherwise try to convert the command
			-- into a fully qualified path name and launch it that way.
			--
			-- If `s' is empty, use the default shell as command.
			-- If should_wait is true, then wait for the child to exit
			-- before returning to the caller.
		require
			s_not_void: s /= Void
		local
			l_cmd, l_args: detachable STRING
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
			last_process: detachable SYSTEM_DLL_PROCESS
		do
			if (current_working_directory @ 2) = ':' then -- assume a volume
				internal_launch_from_local_volume (s, should_wait)
			else
				l_pos := s.index_of (' ', 1)
				if l_pos /= 0 and l_pos < s.count then
					l_cmd := s.substring (1, l_pos - 1)
					l_args := s.substring (l_pos + 1, s.count)
				else
					l_cmd := s
					l_args := ""
				end
				l_cmd := fully_qualified_program_name (l_cmd)
				if l_cmd = Void then
					if should_wait then
							-- We only set `return_code' when wait is required as done in
							-- classic mode.
						return_code := 1
					end
				else
					create l_si.make (l_cmd.to_cil, l_args.to_cil)
					l_si.set_create_no_window (True)
					l_si.set_use_shell_execute (False)
					l_si.set_redirect_standard_error (True)
					l_si.set_redirect_standard_output (True)
					last_process := {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si)
					check last_process_attached: last_process /= Void end
					if should_wait then
						last_process.wait_for_exit
						return_code := last_process.exit_code
					end
				end
			end
		end

	internal_launch_from_local_volume (s: STRING; should_wait: BOOLEAN)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
			-- If should_wait is true, then wait for the child to exit
			-- before returning to the caller.
		require
			s_not_void: s /= Void
		local
			l_comspec: detachable STRING
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
			last_process: detachable SYSTEM_DLL_PROCESS
		do
			if should_wait then
				l_comspec := get ("COMSPEC")
				if l_comspec = Void then
					l_comspec := "cmd.exe"
				end
				if s.is_empty then
					create l_si.make_from_file_name (l_comspec.to_cil)
				else
					create l_si.make_from_file_name_and_arguments (l_comspec.to_cil, ("/c " + s).to_cil)
				end
			else
					-- Let's split up the argument into `executable' and `arguments'.
				l_comspec := s.twin
				l_comspec.left_adjust
				l_pos := l_comspec.index_of (' ', 1)
				if l_pos > 0 then
					create l_si.make_from_file_name_and_arguments (
						l_comspec.substring (1, l_pos).to_cil,
						l_comspec.substring (l_pos + 1, l_comspec.count).to_cil)
				else
					create l_si.make_from_file_name (l_comspec.to_cil)
				end
			end
			l_si.set_use_shell_execute (False)
			last_process := {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si)
			check last_process_attached: last_process /= Void end
			if should_wait then
				last_process.wait_for_exit
				return_code := last_process.exit_code
			end
		end

	fully_qualified_program_name (a_cmd: STRING): detachable STRING
			-- If `a_cmd' can be found, then return a fully qualified
			-- path to it. Otherwise returns a Void string
		require
			a_cmd_not_void: a_cmd /= Void
		local
			l_ext, l_paths: ARRAYED_LIST [STRING]
			l_program_name: STRING
		do
			if {SYSTEM_FILE}.exists (a_cmd) and then attached {PATH}.get_full_path (a_cmd) as l_path then
				Result := l_path
			else
				l_ext := executable_extensions
				l_paths:= search_directories
				from
					l_ext.start
				until
					Result /= Void or l_ext.off
				loop
					from
						l_paths.start
					until
						Result /= Void or l_paths.off
					loop
						l_program_name := l_paths.item.twin
						l_program_name.extend ({PATH}.directory_separator_char)
						l_program_name.append (a_cmd + l_ext.item)
						if {SYSTEM_FILE}.exists (l_program_name) then
							Result := l_program_name
						end
						l_paths.forth
					end
					l_ext.forth
				end
			end
		end

	executable_extensions: ARRAYED_LIST [STRING]
			-- List of legal executable extensions
		local
			l_extensions: detachable STRING
		do
			l_extensions := get ("PATHEXT")
			if l_extensions = Void then
				l_extensions := ".COM;.EXE;.BAT;.CMD"
			end
			create Result.make (10)
			Result.append (l_extensions.split (';'))
		ensure
			executable_extensions_not_void: Result /= Void
		end

	search_directories: ARRAYED_LIST [STRING]
			-- While it would be more efficient to make this a
			-- "once" feature, it's also possible that the caller
			-- could manually modify environment variables between
			-- calls. Plus the relative cost of repeating this code
			-- with starting a windows process makes this operation cheap.
		do
			create Result.make (100)
			if
				attached {ASSEMBLY}.get_entry_assembly as l_assembly and then
				attached {PATH}.get_directory_name (l_assembly.location) as l_location
			then
				Result.extend (l_location)
			end
			Result.extend (current_working_directory)
			if attached get ("PATH") as l_path then
				Result.append (l_path.split (';'))
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class EXECUTION_ENVIRONMENT



