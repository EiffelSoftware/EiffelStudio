indexing

	description:
		"The objects available from the environment at time of execution"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"


class EXECUTION_ENVIRONMENT

feature -- Access

	command_line: ARGUMENTS is
			-- Command line that was used to start current execution
		once
			create Result
		end

	current_working_directory: STRING is
			-- Directory of current execution
		do
			Result := feature {ENVIRONMENT}.current_directory
		end

	default_shell: STRING is
			-- Default shell
		once
			Result := get ("SHELL")
			if Result = Void then
				Result := create {STRING}.make (0)
			end
		end

	get (s: STRING): STRING is
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		require
			s_exists: s /= Void
		local
			cs: SYSTEM_STRING
		do
			user_environment_variables.search (s)
			if user_environment_variables.found then
				Result := user_environment_variables.found_item.twin
			else
				cs := s.to_cil
				cs := feature {ENVIRONMENT}.get_environment_variable (cs)
				if cs /= Void then
					create Result.make_from_cil (cs)
				end
			end
		end

	home_directory_name: STRING is
			-- Directory name corresponding to the home directory.
		require
			home_directory_supported: Operating_environment.home_directory_supported
		do
		end

	root_directory_name: STRING is
			-- Directory name corresponding to the root directory.
		require
			root_directory_supported: Operating_environment.root_directory_supported
		do
			Result := "/"
		ensure
			result_not_void: Result /= Void
		end

feature -- Status

	return_code: INTEGER
			-- Status code set by last call to `system' or `put'

feature -- Status setting

	change_working_directory (path: STRING) is
			-- Set the current directory to `path'
		do
			feature {ENVIRONMENT}.set_current_directory (path)
		end

	put (value, key: STRING) is
			-- Set the environment variable `key' to `value'.
		require
			key_exists: key /= Void
			key_meaningful: key.count > 0
			value_exists: value /= Void
		do
			user_environment_variables.force (value, key)
			return_code := 0
		ensure
			variable_set: (return_code = 0) implies (value.is_equal (get (key)))
		end

	system (s: STRING) is
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		do
			internal_launch (s, True)
		end

	launch (s: STRING) is
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		do
			internal_launch (s, False)
		end

feature {NONE} -- Implementation

	last_process: SYSTEM_DLL_PROCESS
			-- Handle to last launched process through `launch'. Used by `system'
			-- to wait until process is finished.

	internal_launch (s: STRING; should_wait: BOOLEAN) is
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
			l_cmd, l_args: STRING
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
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
					merge_env_vars (l_si.environment_variables)
					l_si.set_redirect_standard_error (True)
					l_si.set_redirect_standard_output (True)
					last_process := feature {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si)
					if should_wait then
						last_process.wait_for_exit
						return_code := last_process.exit_code
					end
				end
			end
		end

	internal_launch_from_local_volume (s: STRING; should_wait: BOOLEAN) is
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
			-- If should_wait is true, then wait for the child to exit
			-- before returning to the caller.
		require
			s_not_void: s /= Void
		local
			l_comspec: STRING
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
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
			merge_env_vars (l_si.environment_variables)
			last_process := feature {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si)
			if should_wait then
				last_process.wait_for_exit
				return_code := last_process.exit_code
			end
		end

	fully_qualified_program_name (a_cmd: STRING): STRING is
			-- If `a_cmd' can be found, then return a fully qualified
			-- path to it. Otherwise returns a Void string
		require
			a_cmd_not_void: a_cmd /= Void
		local
			l_ext, l_paths: ARRAYED_LIST [STRING]
			l_program_name: STRING
		do
			if feature {SYSTEM_FILE}.exists (a_cmd) then
				Result := feature {PATH}.get_full_path (a_cmd)
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
						l_program_name.extend (feature {PATH}.directory_separator_char)
						l_program_name.append (a_cmd + l_ext.item)
						if feature {SYSTEM_FILE}.exists (l_program_name) then
							Result := l_program_name
						end
						l_paths.forth
					end
					l_ext.forth
				end
			end
		end

	executable_extensions: ARRAYED_LIST [STRING] is
			-- List of legal executable extensions
		local
			l_extensions: STRING
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
		
	search_directories: ARRAYED_LIST [STRING] is
			-- While it would be more efficient to make this a
			-- "once" feature, it's also possible that the caller
			-- could manually modify environment variables between
			-- calls. Plus the relative cost of repeating this code
			-- with starting a windows process makes this operation cheap.
		local
			l_path: STRING
		do
			create Result.make (100)
			Result.extend (feature {PATH}.get_directory_name (
				(feature {ASSEMBLY}.get_entry_assembly).location))
			Result.extend (current_working_directory)
			l_path := get ("PATH")
			if l_path /= Void then
				Result.append (l_path.split (';'))
			end
		end

	merge_env_vars (evsd: SYSTEM_DLL_STRING_DICTIONARY) is
			-- Merge user environment variable set in `user_environment_variables'
			-- to the system one.
		require
			evsd_not_void: evsd /= Void
		local
			l_vars: like user_environment_variables
		do
			from
				l_vars := user_environment_variables
				l_vars.start
			until
				l_vars.off
			loop
				evsd.set_item (l_vars.key_for_iteration, l_vars.item_for_iteration)
				l_vars.forth
			end
		end
						
	user_environment_variables: HASH_TABLE [STRING, STRING] is
			-- User-defined environment variables.
		once
			create Result.make (10)
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class EXECUTION_ENVIRONMENT



