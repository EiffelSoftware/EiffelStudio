note
	description: "Same as {EXECUTION_ENVIRONMENT} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTION_ENVIRONMENT_32

inherit
	EXECUTION_ENVIRONMENT
		rename
			current_working_directory as current_working_directory_8,
			get as get_8,
			home_directory_name as home_directory_name_8,
			user_directory_name as user_directory_name_8,
			launch as launch_8,
			put as put_8,
			system as system_8
		end

feature -- Access

	current_working_directory: STRING_32
			-- Directory of current execution
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
					Result := file_info.pointer_to_file_name_32 (l_managed.item)
				else
						-- Something went wrong.
					Result := "."
					check False end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	home_directory_name: detachable STRING_32
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
				Result := file_info.pointer_to_file_name_32 (l_managed.item)
			end
		end

	user_directory_name: detachable STRING_32
			-- Directory name corresponding to the user directory
			-- On Windows: C:\Users\manus\Documents
			-- On Unix & Mac: $HOME
			-- Otherwise Void
		local
			l_count, l_nbytes: INTEGER
			l_managed: MANAGED_POINTER
		once
			l_count := 50
			create l_managed.make (50)
			l_nbytes := eif_user_directory_name_ptr (l_managed.item, l_count)
			if l_nbytes > l_count then
				l_count := l_nbytes
				l_managed.resize (l_count)
				l_nbytes := eif_user_directory_name_ptr (l_managed.item, l_count)
			end
			if l_nbytes > 0 and l_nbytes <= l_count then
				Result := file_info.pointer_to_file_name_32 (l_managed.item)
			end
			if Result /= Void and then not Result.is_empty then
					-- Nothing to do here, we take what we got from the OS.
			elseif
				operating_environment.home_directory_supported and then
				attached (create {EXECUTION_ENVIRONMENT}).home_directory_name as l_home
			then
					-- We use $HOME.
				Result := l_home
			else
					-- No possibility of a user directory, we let the caller handle that.
				Result := Void
			end
		end

	get (s: READABLE_STRING_GENERAL): detachable STRING_32
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		require
			s_exists: s /= Void
			not_has_null_character: not s.has_code (0)
		local
			u: UTF_CONVERTER
			n16: SPECIAL [NATURAL_16]
		do
			if {PLATFORM}.is_windows then
				n16 := u.string_32_to_utf_16_0 (s.as_string_32)
				if attached eif_getenv_16 ($n16) as v16 then
					Result := u.utf_16le_string_8_to_string_32 (v16)
				end
			else
				if attached get_8 (u.string_32_to_utf_8_string_8 (s.as_string_32)) as v8 then
					Result := u.utf_8_string_8_to_string_32 (v8)
				end
			end
		end

feature -- Modification

	put (value, key: READABLE_STRING_GENERAL)
			-- Set the environment variable `key' to `value'.
		require
			key_exists: key /= Void
			key_meaningful: not key.is_empty
			not_key_has_null_character: not key.has_code (0)
			value_exists: value /= Void
			not_value_has_null_character: not value.has_code (0)
		local
			u: UTF_CONVERTER
			v: SPECIAL [NATURAL_16]
			p: MANAGED_POINTER
		do
			if not attached {READABLE_STRING_32} key and then not attached {READABLE_STRING_32} value then
					-- Use values without any encoding.
				put_8 (value.as_string_8, key.as_string_8)
			elseif not {PLATFORM}.is_windows then
					-- Encode values in UTF-8.
				put_8 (u.string_32_to_utf_8_string_8 (key.as_string_32), u.string_32_to_utf_8_string_8 (value.as_string_32))
			else
					-- Encode values in UTF-16.
				v := u.string_32_to_utf_16_0 (key.as_string_32 + {STRING_32} "=" + value.as_string_32 + {STRING_32} "%U")
					-- Make sure the memory with the data stays in memory
					-- because some implementations of `putenv' may use it
					-- directly instead of creating a copy.
				create p.make_from_pointer ($v, v.count * 2)
				return_code := eif_putenv_16 (p.item)
					-- Use a copy for the key to avoid problems with keys changed by the client.
				env32.force (p, key.as_string_32.string)
			end
		ensure
			variable_set: return_code = 0 implies
				(value.is_empty and then get (key) = Void or else
				not value.is_empty and then attached get (key) as k and then k.same_string_general (value))
		end

feature -- Execution

	launch (s: READABLE_STRING_GENERAL)
			-- Pass to the operating system an asynchronous request to
			-- execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_not_void: s /= Void
		local
			p: READABLE_STRING_32
			v: SPECIAL [NATURAL_16]
			u: UTF_CONVERTER
		do
			if attached {READABLE_STRING_32} s as s32 then
				if {PLATFORM}.is_windows then
					if s.is_empty then
						p := default_shell
					else
						p := s32
					end
						-- Make sure there is a terminating zero.
					v := u.string_32_to_utf_16_0 (p)
					asynchronous_system_call_16 ($v)
				else
					launch_8 (u.string_32_to_utf_8_string_8 (s32))
				end
			else
				launch_8 (s.as_string_8)
			end
		end

	system (s: READABLE_STRING_GENERAL)
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		local
			q: READABLE_STRING_GENERAL
			n: SPECIAL [NATURAL_16]
			u: UTF_CONVERTER
		do
			if s.is_empty then
				q := default_shell
			else
				q := s
			end
			if attached {READABLE_STRING_32} q as s32 then
				if {PLATFORM}.is_windows then
					n := u.string_32_to_utf_16_0 (s32)
					return_code := system_call_16 ($n)
				else
					system_8 (u.string_32_to_utf_8_string_8 (s32))
				end
			else
				system_8 (q.as_string_8)
			end
		end

feature {NONE} -- Execution

	system_call_16 (s: POINTER): INTEGER
			-- Pass to the operating system a request to execute `s' in UTF-16 encoding.
		require
			{PLATFORM}.is_windows
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_system_16"
		end

	asynchronous_system_call_16 (s: POINTER)
			-- Pass to the operating system an asynchronous request to execute `s' in UTF-16 encoding.
		require
			{PLATFORM}.is_windows
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_system_asynchronous_16"
		end

	eif_getenv_16 (s: POINTER): detachable STRING_8
			-- Value in UTF-16LE encoding of environment variable `s' in UTF-16 encoding.
		require
			{PLATFORM}.is_windows
		external
			"C inline use <stdlib.h>"
		alias
			"[
				#ifndef EIF_WINDOWS
						/* Dummy value to let the C code compile. */
					return NULL;
				#else
					wchar_t * v = _wgetenv ($s);
					if (!v) return NULL;
					return RTMS_EX ((char *) v, wcslen (v) * sizeof (wchar_t));
				#endif
			]"
		end

	eif_putenv_16 (s: POINTER): like return_code
			-- Modify environment variables with `s' in UTF-16 encoding.
		require
			{PLATFORM}.is_windows
		external
			"C inline use <stdlib.h>"
		alias
			"[
				#ifndef EIF_WINDOWS
						/* Dummy value to let the C code compile. */
					return -1;
				#else
					return _wputenv ($s);
				#endif
			]"
		end

	env32: HASH_TABLE [MANAGED_POINTER, STRING_32]
			-- Environment variable memory set by current execution,
			-- indexed by environment variable name. Needed otherwise
			-- we would corrupt memory after freeing memory passed to
			-- `eif_putenv_16' when its implementation does not copy
			-- a passed string, but use it directly.
		once
			create Result.make (10)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
