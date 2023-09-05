note

	description:
		"The objects available from the environment at time of execution"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXECUTION_ENVIRONMENT

feature -- Access

	arguments: ARGUMENTS_32
			-- Arguments that were used to start current execution.
		once
			create Result
		ensure
			instance_free: class
		end

	command_line: ARGUMENTS
			-- Command line that was used to start current execution
		obsolete
			"Use `arguments' instead for handling Unicode command lines. [2017-05-31]"
		once
			create Result
		ensure
			instance_free: class
		end

	current_working_path: PATH
			-- Directory of current execution.
		do
			if attached {ENVIRONMENT}.current_directory as l_dir then
				create Result.make_from_string (create {STRING_32}.make_from_cil (l_dir))
			else
				create Result.make_current
			end
		ensure
			instance_free: class
			result_not_void: Result /= Void
		end

	current_working_directory: STRING
			-- Directory of current execution
		obsolete
			"Use `current_working_path' instead to support Unicode path. [2017-05-31]"
		do
			if attached {ENVIRONMENT}.current_directory as l_dir then
				Result := l_dir
			else
				Result := "."
			end
		ensure
			instance_free: class
			result_not_void: Result /= Void
		end

	default_shell: STRING_32
			-- Default shell
		once
			if attached item ("SHELL") as l_shell then
				Result := l_shell
			else
				create Result.make_empty
			end
		ensure
			instance_free: class
		end

	get (s: STRING): detachable STRING
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		obsolete
			"Use `item' instead to retrieve Unicode environment variables. [2017-05-31]"
		require
			s_exists: s /= Void
		do
			if attached {ENVIRONMENT}.get_environment_variable (s.to_cil) as cs then
				create Result.make_from_cil (cs)
			end
		ensure
			instance_free: class
		end

	item (s: READABLE_STRING_GENERAL): detachable STRING_32
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		require
			s_exists: s /= Void
			not_has_null_character: not s.has ('%U')
		do
			if attached {ENVIRONMENT}.get_environment_variable (s.to_cil) as cs then
				create Result.make_from_cil (cs)
			end
		ensure
			instance_free: class
		end

	home_directory_path: detachable PATH
			-- Directory name corresponding to the home directory.
		require
			home_directory_supported: Operating_environment.home_directory_supported
		do
			if attached {ENVIRONMENT}.get_folder_path ({SPECIAL_FOLDER_IN_ENVIRONMENT}.local_application_data) as l_home then
				create Result.make_from_string (create {STRING_32}.make_from_cil (l_home))
			elseif attached item ("HOMEPATH") as l_home then
				create Result.make_from_string (l_home)
			else
				create Result.make_empty
			end
		ensure
			instance_free: class
		end

	user_directory_path: detachable PATH
			-- Directory name corresponding to the user directory
			-- On Windows: C:\Users\manus\Documents
			-- On Unix & Mac: $HOME
			-- Otherwise Void
		once
			if attached {ENVIRONMENT}.get_folder_path ({SPECIAL_FOLDER_IN_ENVIRONMENT}.personal) as l_home then
				create Result.make_from_string (create {STRING_32}.make_from_cil (l_home))
			elseif
				operating_environment.home_directory_supported and then
				attached home_directory_path as l_home
			then
					-- We use $HOME.
				Result := l_home
			else
					-- No possibility of a user directory, we let the caller handle that.
				Result := Void
			end
		ensure
			instance_free: class
		end

	home_directory_name: STRING
			-- Directory name corresponding to the home directory.
		obsolete
			"Use `home_directory_path' instead to support Unicode path. [2017-05-31]"
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
		ensure
			instance_free: class
		end

	root_directory_name: STRING
			-- Directory name corresponding to the root directory.
		require
			root_directory_supported: Operating_environment.root_directory_supported
		once
			if {PLATFORM}.is_windows then
				Result := "\"
			elseif {PLATFORM}.is_vms then
				Result := "[000000]"
			else
				Result := "/"
			end
		ensure
			instance_free: class
			result_not_void: Result /= Void
		end

	starting_environment_variables: HASH_TABLE [STRING_8, STRING_8]
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		obsolete
			"Use starting_environment which support unicode. [2017-05-31]"
		do
			if 
				attached {IDICTIONARY} {ENVIRONMENT}.get_environment_variables as l_dic and then
				attached {IENUMERATOR} l_dic.get_enumerator as l_enumerator 
			then
				create Result.make (l_dic.count)
				from
				until
					not l_enumerator.move_next
				loop
					if
						attached {DICTIONARY_ENTRY} l_enumerator.current_ as l_entry and then
						attached {SYSTEM_STRING} l_entry.key as l_key and then
						attached {SYSTEM_STRING} l_entry.value as l_value
					then
						Result.force (create {STRING_8}.make_from_cil (l_value), create {STRING_8}.make_from_cil (l_key))
					end
				end
			else
				create Result.make (0)
			end
		ensure
			instance_free: class
		end

	starting_environment: HASH_TABLE [STRING_32, STRING_32]
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		do
			if 
				attached {IDICTIONARY} {ENVIRONMENT}.get_environment_variables as l_dic and then
				attached {IENUMERATOR} l_dic.get_enumerator as l_enumerator 
			then
				create Result.make (l_dic.count)
				from
				until
					not l_enumerator.move_next
				loop
					if
						attached {DICTIONARY_ENTRY} l_enumerator.current_ as l_entry and then
						attached {SYSTEM_STRING} l_entry.key as l_key and then
						attached {SYSTEM_STRING} l_entry.value as l_value
					then
						Result.force (create {STRING_32}.make_from_cil (l_value), create {STRING_32}.make_from_cil (l_key))
					end
				end
			else
				create Result.make (0)
			end
		ensure
			instance_free: class
			result_attached: Result /= Void
		end

	available_cpu_count: NATURAL_32
			-- Number of available CPUs.		
		do
			Result := {ENVIRONMENT}.processor_count.to_natural_32
		ensure
			instance_free: class
		end

feature -- Status

	return_code: INTEGER
			-- Status code set by last call to `system' or `put'

feature -- Status setting

	change_working_directory (path: STRING)
			-- Set the current directory to `path'
		obsolete
			"Use `change_working_path' instead to support Unicode path. [2017-05-31]"
		do
			{ENVIRONMENT}.set_current_directory (path)
		end

	change_working_path (path: PATH)
			-- Set the current directory to `path'
		do
			{ENVIRONMENT}.set_current_directory (path.name)
		end

	put (value, key: READABLE_STRING_GENERAL)
			-- Set the environment variable `key' to `value'.
		require
			key_exists: key /= Void
			key_meaningful: not key.is_empty
			not_key_has_null_character: not key.has ('%U')
			value_exists: value /= Void
			not_value_has_null_character: not value.has ('%U')
		do
			{ENVIRONMENT}.set_environment_variable (key.to_cil, value.to_cil)
			return_code := 0
		ensure
			variable_set: return_code = 0 implies
				((value.is_empty and then item (key) = Void) or else
				not value.is_empty and then attached item (key) as k and then k.same_string_general (value))
		end

	system (s: READABLE_STRING_GENERAL)
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		do
			internal_launch (s.to_string_32, True)
		end

	launch (s: READABLE_STRING_GENERAL)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		do
			internal_launch (s.to_string_32, False)
		end

	sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		require
			non_negative_nanoseconds: nanoseconds >= 0
		do
			{SYSTEM_THREAD}.sleep_time_span
				({TIME_SPAN}.from_ticks (nanoseconds // 100))
		ensure
			instance_free: class
		end

feature {NONE} -- Implementation

			-- Handle to last launched process through `launch'. Used by `system'
			-- to wait until process is finished.

	internal_launch (s: STRING_32; should_wait: BOOLEAN)
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
			l_cmd, l_args: detachable STRING_32
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
		do
			if current_working_path.name [2] = ':' then -- assume a volume
				internal_launch_from_local_volume (s, should_wait)
			else
				l_pos := s.index_of (' ', 1)
				if l_pos /= 0 and l_pos < s.count then
					l_cmd := s.substring (1, l_pos - 1)
					l_args := s.substring (l_pos + 1, s.count)
				else
					l_cmd := s
					l_args := {STRING_32} ""
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
					check attached {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si) as last_process then
						if should_wait then
							last_process.wait_for_exit
							return_code := last_process.exit_code
						end
					end
				end
			end
		end

	internal_launch_from_local_volume (s: READABLE_STRING_GENERAL; should_wait: BOOLEAN)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
			-- If should_wait is true, then wait for the child to exit
			-- before returning to the caller.
		require
			s_not_void: s /= Void
		local
			l_comspec: detachable STRING_32
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
		do
			if should_wait then
				l_comspec := item ("COMSPEC")
				if l_comspec = Void then
					l_comspec := {STRING_32} "cmd.exe"
				end
				if s.is_empty then
					create l_si.make_from_file_name (l_comspec.to_cil)
				else
					create l_si.make_from_file_name_and_arguments (l_comspec.to_cil, ({STRING_32} "/c " + s.to_string_32).to_cil)
				end
			else
					-- Let's split up the argument into `executable' and `arguments'.
				l_comspec := s.to_string_32.twin
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
			check attached {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si) as last_process then
				if should_wait then
					last_process.wait_for_exit
					return_code := last_process.exit_code
				end
			end
		end

	fully_qualified_program_name (a_cmd: STRING_32): detachable STRING_32
			-- If `a_cmd' can be found, then return a fully qualified
			-- path to it. Otherwise returns a Void string
		require
			a_cmd_not_void: a_cmd /= Void
		local
			l_ext, l_paths: ARRAYED_LIST [READABLE_STRING_32]
			l_program_name: PATH
		do
			if {SYSTEM_FILE}.exists (a_cmd) and then attached {SYSTEM_PATH}.get_full_path (a_cmd) as l_path then
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
						create l_program_name.make_from_string (l_paths.item)
						l_program_name := l_program_name.extended (a_cmd).appended (l_ext.item)
						if (create {RAW_FILE}.make_with_path (l_program_name)).exists then
							create Result.make_from_string_general (l_program_name.name)
						end
						l_paths.forth
					end
					l_ext.forth
				end
			end
		end

	executable_extensions: ARRAYED_LIST [STRING_32]
			-- List of legal executable extensions
		local
			l_extensions: detachable STRING_32
		do
			l_extensions := item ("PATHEXT")
			if l_extensions = Void then
				l_extensions := {STRING_32} ".COM;.EXE;.BAT;.CMD"
			end
			create Result.make (10)
			Result.append (l_extensions.split (';'))
		ensure
			executable_extensions_not_void: Result /= Void
		end

	search_directories: ARRAYED_LIST [READABLE_STRING_32]
			-- While it would be more efficient to make this a
			-- "once" feature, it's also possible that the caller
			-- could manually modify environment variables between
			-- calls. Plus the relative cost of repeating this code
			-- with starting a windows process makes this operation cheap.
		do
			create Result.make (100)
			if
				attached {ASSEMBLY}.get_entry_assembly as l_assembly and then
				attached {SYSTEM_PATH}.get_directory_name (l_assembly.location) as l_location
			then
				Result.extend (create {STRING_32}.make_from_cil (l_location))
			end
			Result.extend (current_working_path.name)
			if attached item ("PATH") as l_path then
				Result.append (l_path.split (';'))
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
