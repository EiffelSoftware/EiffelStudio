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
		external
			"C use %"eif_dir.h%""
		alias
			"dir_current"
		ensure
			result_not_void: Result /= Void
		end

	default_shell: STRING
			-- Default shell
		once
			Result := get ("SHELL")
			if Result = Void then
				Result := ""
			end
		end

	get (s: STRING): STRING
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

	home_directory_name: STRING
			-- Directory name corresponding to the home directory.
		require
			home_directory_supported: Operating_environment.home_directory_supported
		do
			Result := eif_home_directory_name
		end

	root_directory_name: STRING
			-- Directory name corresponding to the root directory.
		require
			root_directory_supported: Operating_environment.root_directory_supported
		do
			Result := eif_root_directory_name
		ensure
			result_not_void: Result /= Void
		end

	starting_environment_variables: HASH_TABLE [STRING, STRING]
			-- Table of environment variables when current process starts,
			-- indexed by variable name
		local
			l_ptr: POINTER
			i: INTEGER
			l_curr_var: TUPLE [value: STRING; key: STRING]
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
			l_ext: ANY
		do
			l_ext := path.to_c
			return_code := eif_chdir ($l_ext)
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
				(equal (value, get (key)) or else (value.is_empty and then (get (key) = Void)))
		end

	system (s: STRING)
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		local
			ext: ANY
		do
			if s.is_empty then
				ext := default_shell.to_c
			else
				ext := s.to_c
			end
			return_code := system_call ($ext)
		end

	launch (s: STRING)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		local
			ext: ANY
		do
			if s.is_empty then
				ext := default_shell.to_c
			else
				ext := s.to_c
			end
			asynchronous_system_call ($ext)
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

	separated_variables (a_var: STRING): TUPLE [value: STRING; key: STRING]
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

feature {NONE} -- External

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

	eif_chdir (s: POINTER): INTEGER
			-- Set the current directory to `path'
		external
			"C use %"eif_dir.h%""
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

	eif_home_directory_name: STRING
			-- Directory name corresponding to the home directory
		external
			"C use %"eif_path_name.h%""
		end

	eif_root_directory_name: STRING
			-- Directory name corresponding to the root directory
		external
			"C use %"eif_path_name.h%""
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

end
