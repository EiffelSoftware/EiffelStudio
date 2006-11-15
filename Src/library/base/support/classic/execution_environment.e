indexing

	description:
		"The objects available from the environment at time of execution"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class EXECUTION_ENVIRONMENT

inherit
	PLATFORM

feature -- Access

	command_line: ARGUMENTS is
			-- Command line that was used to start current execution
		once
			create Result
		end

	current_working_directory: STRING is
			-- Directory of current execution
		external
			"C use %"eif_dir.h%""
		alias
			"dir_current"
		ensure
			result_not_void: Result /= Void
		end

	default_shell: STRING is
			-- Default shell
		once
			Result := get ("SHELL")
			if Result = Void then
				Result := ""
			end
		end

	get (s: STRING): STRING is
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

	home_directory_name: STRING is
			-- Directory name corresponding to the home directory.
		require
			home_directory_supported: Operating_environment.home_directory_supported
		do
			Result := eif_home_directory_name
		end

	root_directory_name: STRING is
			-- Directory name corresponding to the root directory.
		require
			root_directory_supported: Operating_environment.root_directory_supported
		do
			Result := eif_root_directory_name
		ensure
			result_not_void: Result /= Void
		end

	environment_variables: HASH_TABLE [STRING, STRING] is
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		local
			l_ptr, l_ptr2: POINTER
			l_succ: BOOLEAN
			l_count: INTEGER
			i: INTEGER
			l_ptr_size: INTEGER
			l_managed_ptr: MANAGED_POINTER
			l_curr_var: TUPLE [value: STRING; key: STRING]
			l_is_window: BOOLEAN
			l_new_vars: like environ
			l_key_table: like variable_key_table
		do
			l_new_vars := environ
				-- Get environment variables which are set when current process starts.			
			get_environment_variables ($l_ptr, $l_count, $l_succ)
			if l_succ then
				l_is_window := is_windows
				create Result.make (l_count + l_new_vars.count)
				l_ptr_size := pointer_bytes
				create l_managed_ptr.make_from_pointer (l_ptr, l_count * l_ptr_size)
				from
					i := 0
				until
					i = l_count
				loop
					l_ptr2 := l_managed_ptr.read_pointer (i * l_ptr_size)
					l_curr_var := separated_variables (create {STRING}.make_from_c (l_ptr2))
					if l_curr_var /= Void then
						Result.force (l_curr_var.value, l_curr_var.key)
					end
					if l_is_window then
						l_ptr2.memory_free
					end
					i := i + 1
				end
				if l_is_window then
					l_ptr.memory_free
				end
			else
				create Result.make (l_new_vars.count)
			end

				-- Get environment variables set by current process.
			if not l_new_vars.is_empty then
				if is_windows then
					l_key_table := variable_key_table (Result)
				end
				from
					l_new_vars.start
				until
					l_new_vars.after
				loop
					l_curr_var := separated_variables (l_new_vars.item_for_iteration.string)
					if l_curr_var /= Void then
						if is_windows then
							check l_key_table /= Void end
							case_insensitive_put (Result, l_key_table, l_curr_var.value, l_curr_var.key)
						else
							Result.force (l_curr_var.value, l_curr_var.key)
						end
					end
				l_new_vars.forth
				end
			end
		end

feature -- Status

	return_code: INTEGER
			-- Status code set by last call to `system' or `put'

feature -- Status setting

	change_working_directory (path: STRING) is
			-- Set the current directory to `path'
		do
			return_code := eif_chdir (path.to_c)
		end

	put (value, key: STRING) is
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
			l_key_table: like variable_key_table
		do
			create l_env.make (value.count + key.count + 1)
			l_env.append (key)
			l_env.append_character ('=')
			l_env.append (value)
			create l_c_env.make (l_env)

			if is_windows then
				l_key_table := variable_key_table (environ)
				case_insensitive_put (environ, l_key_table, l_c_env, key)
			else
				environ.force (l_c_env, key)
			end
			return_code := eif_putenv (l_c_env.item)
		ensure
			variable_set: (return_code = 0) implies
				(equal (value, get (key)) or else (value.is_empty and then (get (key) = Void)))
		end

	system (s: STRING) is
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

	launch (s: STRING) is
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

	environ: HASH_TABLE [C_STRING, STRING] is
			-- Environment variable memory set by current execution,
			-- indexed by environment variable name. Needed otherwise
			-- we would corrupt memory after freeing memory used by
			-- C_STRING instance since not referenced anywhere else.
		once
			create Result.make (10)
		end

	get_environment_variables (a_pointers: TYPED_POINTER [POINTER]; a_count: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get environment variables associated with current process and store them in `a_pointers'.
			-- `a_count' indicates the number of environment variables (i.e., number of pointers in `a_pointer').
			-- `a_size' is the size of a pointer.
			-- If succeeded, set `a_succ' to True, otherwise False.
		external
			"C inline use <string.h>, %"eif_main.h%""
		alias
			"[
				{
					char **buf;					
					int cnt;
					#ifdef EIF_WINDOWS
						LPVOID lpvEnv;
						LPSTR lpszVariable; 						
						int len;
						char *curr_str;
						lpvEnv = eif_environ;
						if(lpvEnv) {						
							lpszVariable = (LPTSTR)lpvEnv;	
							cnt = 0;					
							for (; *lpszVariable; lpszVariable++) { 						   
							   while (*lpszVariable) {
							      lpszVariable++;
							    }						    
							    cnt++;						    				  
							}
							*$a_count = cnt;
							buf = (LPSTR*)malloc (cnt * sizeof(LPSTR*));
							cnt = 0;						
							lpszVariable = (LPTSTR)lpvEnv;
							for (; *lpszVariable; lpszVariable++) { 
							   len = 0;				
							   curr_str = lpszVariable;						   
							   while (*lpszVariable) {						   	  
							      lpszVariable++;
							      len++;
							    }
							    if(curr_str) {
								    buf[cnt] = (char *)malloc (len + 1);
								    memcpy (buf[cnt], curr_str, len + 1);
								}
							    cnt++;						    				  
							}		
							*$a_pointers = buf;				
							*$a_succ = 1;
						} else {
							*$a_succ = 0;
						}
					#else
	    				cnt = 0;
	    				*$a_pointers = (void*)eif_environ;
	    				if(*$a_pointers) {
		    				buf = (char **)*$a_pointers;
		    				while (*buf++) {
								cnt++;
		    				}
		    				*$a_count=cnt;
		        			*$a_succ=1;
		        		} else {
		        			*$a_succ=0;
		        		}
					#endif
				}
			]"
		end

	separated_variables (a_var: STRING): TUPLE [value: STRING; key: STRING] is
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

	variable_key_table (a_table: HASH_TABLE [ANY, STRING]): HASH_TABLE [STRING, STRING] is
			-- Table contains keys in `a_table'.
			-- For an item in returned table, `value' is an original key in `a_table',
			-- `key' is the original key in lower case format.
		require
			a_table_attached: a_table /= Void
		do
			create Result.make (a_table.count)
			from
				a_table.start
			until
				a_table.after
			loop
				Result.force (a_table.key_for_iteration, a_table.key_for_iteration.as_lower)
				a_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

	case_insensitive_put (a_table: HASH_TABLE [ANY, STRING]; a_key_table: HASH_TABLE [STRING, STRING]; a_value: ANY; a_key: STRING) is
			-- Insert `a_value' with `a_key' into `a_table', and `a_key' is case insensitive.
			-- `a_key_table' is used to support case-insensitive insertion. See `variable_key_table' for more information.
		require
			a_table_attached: a_table /= Void
			a_key_table_attached: a_key_table /= Void
			a_key_attached: a_key /= Void
		local
			l_key_as_lower: STRING
		do
			l_key_as_lower := a_key.as_lower
			if a_key_table.has (l_key_as_lower) then
				a_table.remove (a_key_table.item (l_key_as_lower))
				a_table.force (a_value, a_key)
			else
				a_table.force (a_value, a_key)
			end
		end

feature {NONE} -- External

	eif_getenv (s: POINTER): POINTER is
			-- Value of environment variable `s'
		external
			"C use <stdlib.h>"
		alias
			"getenv"
		end

	eif_putenv (v: POINTER): INTEGER is
			-- Set `v' in environment.
		external
			"C use <stdlib.h>"
		alias
			"putenv"
		end

	eif_chdir (s: ANY): INTEGER is
			-- Set the current directory to `path'
		external
			"C use %"eif_dir.h%""
		end

	system_call (s: POINTER): INTEGER is
			-- Pass to the operating system a request to execute `s'.
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_system"
		end

	asynchronous_system_call (s: POINTER) is
			-- Pass to the operating system an asynchronous request to execute `s'.
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_system_asynchronous"
		end

	eif_home_directory_name: STRING is
			-- Directory name corresponding to the home directory
		external
			"C use %"eif_path_name.h%""
		end

	eif_root_directory_name: STRING is
			-- Directory name corresponding to the root directory
		external
			"C use %"eif_path_name.h%""
		end

indexing
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



