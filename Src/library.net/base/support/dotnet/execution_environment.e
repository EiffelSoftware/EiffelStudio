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
		local
			e: ENVIRONMENT
		do
			Result := create {STRING}.make_from_cil (e.current_directory)
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
			e: ENVIRONMENT
			cs: SYSTEM_STRING
		do
			user_environment_variables.search (s)
			if user_environment_variables.found then
				Result := user_environment_variables.found_item.twin
			else
				cs := s.to_cil
				cs := e.get_environment_variable (cs)
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
			user_environment_variables.put (value, key)
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
			return_code := last_process.exit_code
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
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		local
			l_comspec: STRING
			si: SYSTEM_DLL_PROCESS_START_INFO
			l_pos: INTEGER
		do
			if should_wait then
				l_comspec := get ("COMSPEC")
				if l_comspec = Void then
					l_comspec := "cmd.exe"
				end
				if s.is_empty then
					create si.make_from_file_name (l_comspec.to_cil)				
				else
					create si.make_from_file_name_and_arguments (l_comspec.to_cil, ("/c " + s).to_cil)
				end
			else
					-- Let's split up the argument into `executable' and `arguments'.
				l_comspec := s.twin
				l_comspec.left_adjust
				l_pos := l_comspec.index_of (' ', 1)
				if l_pos > 0 then
					create si.make_from_file_name_and_arguments (
						l_comspec.substring (1, l_pos).to_cil,
						l_comspec.substring (l_pos + 1, l_comspec.count).to_cil)
				else
					create si.make_from_file_name (l_comspec.to_cil)
				end
			end
			si.set_use_shell_execute (False)
			last_process := feature {SYSTEM_DLL_PROCESS}.start_process_start_info (si)
			if should_wait then
				last_process.wait_for_exit
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



