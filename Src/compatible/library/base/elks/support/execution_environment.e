note

	description:
		"The objects available from the environment at time of execution"

	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 2005-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class EXECUTION_ENVIRONMENT

inherit
	NATIVE_STRING_HANDLER

feature -- Access

	command_line: ARGUMENTS
			-- Command line that was used to start current execution
		once
			create Result
		end

	current_working_directory: STRING
			-- Directory of current execution.
			-- Execution of this query on concurrent threads will result in
			-- an unspecified behavior.
		local
			l_count, l_nbytes: INTEGER
			l_managed: MANAGED_POINTER
		do
			l_count := 50
			create l_managed.make (l_count)
			l_nbytes := eif_dir_current (l_managed.item, l_count)
			if l_nbytes = -1 then
					-- The underlying OS could not retrieve the current working directory. Most likely
					-- a case where it has been deleted under our feet. We simply return that the current
					-- directory is `.' the symbol for the current working directory.
				Result := "."
			else
				if l_nbytes > l_count then
						-- We need more space.
					l_count := l_nbytes
					l_managed.resize (l_count)
					l_nbytes := eif_dir_current (l_managed.item, l_count)
				end
				if l_nbytes > 0 and l_nbytes <= l_count then
					Result := file_info.pointer_to_file_name_8 (l_managed.item)
				else
						-- Something went wrong.
					Result := "."
					check False end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	default_shell: STRING
			-- Default shell
		local
			s: detachable STRING
		once
			s := get ("SHELL")
			if s = Void then
				Result := ""
			else
				Result := s
			end
		end

	get (s: STRING): detachable STRING
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		require
			s_exists: s /= Void
			not_has_null_character: not s.has ('%U')
		local
			ext: ANY
			c_string: POINTER
			void_pointer: POINTER
		do
			ext := s.to_c
			c_string := eif_getenv ($ext)
			if c_string /= void_pointer then
				create Result.make_from_c (c_string)
			end
		end

	home_directory_name: detachable STRING
			-- Directory name corresponding to the home directory.
		require
			home_directory_supported: Operating_environment.home_directory_supported
		local
			l_count, l_nbytes: INTEGER
			l_managed: MANAGED_POINTER
		once
			l_count := 50
			create l_managed.make (l_count)
			l_nbytes := eif_home_directory_name_ptr (l_managed.item, l_count)
			if l_nbytes > l_count then
				l_count := l_nbytes
				l_managed.resize (l_count)
				l_nbytes := eif_home_directory_name_ptr (l_managed.item, l_count)
			end
			if l_nbytes > 0 and l_nbytes <= l_count then
				Result := file_info.pointer_to_file_name_8 (l_managed.item)
			end
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
			result_not_void: Result /= Void
		end

	starting_environment_variables: HASH_TABLE [STRING, STRING]
			-- Table of environment variables when current process starts,
			-- indexed by variable name
		local
			l_ptr: POINTER
			i: INTEGER
			l_curr_var: detachable TUPLE [value: STRING; key: STRING]
		do
			create Result.make (40)
			from
				i := 0
				l_ptr := i_th_environ (i)
			until
				l_ptr = default_pointer
			loop
				l_curr_var := separated_variables (create {STRING}.make_from_c (l_ptr))
				if l_curr_var /= Void then
					Result.force (l_curr_var.value, l_curr_var.key)
				end
				i := i + 1
				l_ptr := i_th_environ (i)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status

	return_code: INTEGER
			-- Status code set by last call to `system' or `put'

feature -- Status setting

	change_working_directory (path: STRING)
			-- Set the current directory to `path'
		local
			l_ptr: MANAGED_POINTER
		do
			l_ptr := file_info.file_name_to_pointer (path, Void)
			return_code := eif_chdir (l_ptr.item)
		end

	put (value, key: STRING)
			-- Set the environment variable `key' to `value'.
		require
			key_exists: key /= Void
			key_meaningful: not key.is_empty
			not_key_has_null_character: not key.has ('%U')
			value_exists: value /= Void
			not_value_has_null_character: not value.has ('%U')
		local
			l_env: STRING
			l_c_env: C_STRING
		do
			create l_env.make (value.count + key.count + 1)
			l_env.append (key)
			l_env.append_character ('=')
			l_env.append (value)
			create l_c_env.make (l_env)
			environ.force (l_c_env, key)
			return_code := eif_putenv (l_c_env.item)
		ensure
			variable_set: (return_code = 0) implies
				((get (key) ~ value.string) or else (value.is_empty and then (get (key) = Void)))
		end

	system (s: STRING)
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		local
			l_cstr: C_STRING
		do
			if s.is_empty then
				create l_cstr.make (default_shell)
			else
				create l_cstr.make (s)
			end
			return_code := system_call (l_cstr.item)
		end

	launch (s: STRING)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		local
			l_cstr: C_STRING
		do
			if s.is_empty then
				create l_cstr.make (default_shell)
			else
				create l_cstr.make (s)
			end
			asynchronous_system_call (l_cstr.item)
		end

	sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		require
			non_negative_nanoseconds: nanoseconds >= 0
		do
			eif_sleep (nanoseconds)
		end

feature {NONE} -- Implementation

	environ: HASH_TABLE [C_STRING, STRING]
			-- Environment variable memory set by current execution,
			-- indexed by environment variable name. Needed otherwise
			-- we would corrupt memory after freeing memory used by
			-- C_STRING instance since not referenced anywhere else.
		once
			create Result.make (10)
		end

	i_th_environ (i: INTEGER): POINTER
			-- Environment variable at `i'-th position of `eif_environ'.
		require
			i_valid: i >=0
		external
			"C inline use <string.h>"
		alias
			"[
				if (eif_environ) {
					#ifdef EIF_WINDOWS
						LPSTR vars = (LPSTR) eif_environ;
						int cnt = 0;
						for (; *vars; vars++) {
						   if ($i==cnt) return vars;
						   while (*vars) { vars++; }
						   cnt++;
						}
						return NULL;
					#else
						return ((char **)eif_environ)[$i];
					#endif
				} else {
					return NULL;
				}
			]"
		end

	separated_variables (a_var: STRING): detachable TUPLE [value: STRING; key: STRING]
			-- Given an environment variable `a_var' in form of "key=value",
			-- return separated key and value.
			-- Return Void if `a_var' is in incorrect format.
		require
			a_var_attached: a_var /= Void
		local
			i, j: INTEGER
			done: BOOLEAN
		do
			j := a_var.count
			from
				i := 1
			until
				i > j or done
			loop
				if a_var.item (i) = '=' then
					done := True
				else
					i := i + 1
				end
			end
			if i > 1 and then i < j then
				Result := [a_var.substring (i + 1, j), a_var.substring (1, i - 1)]
			end
		end

	file_info: FILE_INFO
			-- Platform specific helper of filenames.
		once
			create Result.make
		end

feature {NONE} -- External

	eif_dir_current (a_ptr: POINTER; a_count: INTEGER): INTEGER
			-- Store platform specific path of current working directory in `a_ptr' with `a_count' bytes. If
			-- there is a need for more bytes than `a_count', or if `a_ptr' is the default_pointer, nothing is done with `a_ptr'.
			-- We always return the number of bytes required including the null-terminating character, or -1 on error.
		external
			"C signature (EIF_FILENAME, EIF_INTEGER): EIF_INTEGER use %"eif_dir.h%""
		end

	eif_getenv (s: POINTER): POINTER
			-- Value of environment variable `s'
		external
			"C use <stdlib.h>"
		alias
			"getenv"
		end

	eif_putenv (v: POINTER): INTEGER
			-- Set `v' in environment.
		external
			"C use <stdlib.h>"
		alias
			"putenv"
		end

	eif_chdir (path: POINTER): INTEGER
			-- Set the current directory to `path'
		external
			"C signature (EIF_FILENAME): EIF_INTEGER use %"eif_dir.h%""
		end

	system_call (s: POINTER): INTEGER
			-- Pass to the operating system a request to execute `s'.
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_system"
		end

	asynchronous_system_call (s: POINTER)
			-- Pass to the operating system an asynchronous request to execute `s'.
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_system_asynchronous"
		end

	eif_home_directory_name_ptr (a_ptr: POINTER; a_count: INTEGER): INTEGER
			-- Stored directory name corresponding to the home directory in `a_ptr' with `a_count' bytes. If
			-- there is a need for more bytes than `a_count', or if `a_ptr' is the default_pointer, nothing is done with `a_ptr'.
			-- We always return the number of bytes required including the null-terminating character.
		external
			"C signature (EIF_FILENAME, EIF_INTEGER): EIF_INTEGER use %"eif_path_name.h%""
		end

	eif_sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		require
			non_negative_nanoseconds: nanoseconds >= 0
		external
			"C blocking use %"eif_misc.h%""
		end

end
