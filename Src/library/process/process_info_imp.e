indexing
	description: "Implementation of PROCESS_INFO"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		external
			"C inline"
		alias
			"GetCurrentProcessId ()"
		end


	process_module: STRING is
			-- Module (full path) of current process
			-- Return Void if failed.
		local
			l_ptr: POINTER
			l_count: INTEGER
			l_wel_str: WEL_STRING
			l_succ: BOOLEAN
		do
			get_process_module ($l_ptr, $l_count, $l_succ)
			if l_succ then
				check l_ptr /= default_pointer end
				create l_wel_str.share_from_pointer_and_count (l_ptr, l_count)
				Result := l_wel_str.string
				cwin_free_pointer (l_ptr)
			else
				Result := ""
			end
		end

	environment_variables: HASH_TABLE [STRING, STRING] is
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		local
			l_ptr: POINTER
			l_succ: BOOLEAN
			l_count: INTEGER
			l_managed_ptr: MANAGED_POINTER
			l_managed_ptr2: MANAGED_POINTER
			l_str: STRING
			l_str_list: LIST [STRING]
			l_ver_len: POINTER
			l_ver_len_size: INTEGER
			i: INTEGER
			l_list: ARRAYED_LIST [INTEGER_64]
			i_16: INTEGER_16
			i_32: INTEGER_32
			i_64: INTEGER_64
			l_pos: INTEGER
			l_whole_len: INTEGER
			l_cnt: INTEGER
			l_wel_str: WEL_STRING
		do
			get_environment_variables ($l_ptr, $l_whole_len, $l_count, $l_ver_len_size, $l_ver_len, $l_succ)
			if l_succ then
				create l_managed_ptr.make_from_pointer (l_ver_len, l_ver_len_size * l_count)
				create l_list.make (l_count)
				from
					i := 0
					l_pos := 0
				until
					i = l_count
				loop
					inspect
						l_ver_len_size
					when 2 then
						i_16 := l_managed_ptr.read_integer_16 (l_pos)
						l_list.extend (i_16.as_integer_64)
					when 4 then
						i_32 := l_managed_ptr.read_integer_32 (l_pos)
						l_list.extend (i_32.as_integer_64)
					when 8 then
						i_64 := l_managed_ptr.read_integer_64 (l_pos)
						l_list.extend (i_64)
					else
						check False end
					end
					l_pos := l_pos + l_ver_len_size
					i := i + 1
				end
				cwin_free_pointer ($l_ver_len)
				create Result.make (l_list.count)
				create l_managed_ptr.make_from_pointer (l_ptr, l_whole_len)
				from
					l_list.start
					l_pos := 0
				until
					l_list.after
				loop
					l_cnt := l_list.item.as_integer_32
					create l_managed_ptr2.make (l_cnt)
					from
						i := 0
					until
						i = l_cnt
					loop
						l_managed_ptr2.put_character (l_managed_ptr.read_character (l_pos + i), i)
						i := i + 1
					end
					create l_wel_str.make_by_pointer_and_count (l_managed_ptr2.item, l_cnt)
					l_str := l_wel_str.string
					l_str_list := l_str.split ('=')
					if l_str_list.count = 2 then
						Result.put (l_str_list.i_th (2), l_str_list.i_th (1))
					end
					l_pos := l_pos + l_list.item.as_integer_32
					l_list.forth
				end
				cwin_free_environment_strings (l_ptr)
			else
				create Result.make (0)
			end
		end

feature{NONE} -- Implementation

	get_process_module (a_module: TYPED_POINTER [POINTER]; a_count: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get module of current process and store it in `a_module'.
			-- Length of `a_module' in bytes is stored in `a_count'.
			-- If succeeded, set `a_succ' to True, otherwise False.
			-- Free `a_module' after use.
		external
			"C inline"
		alias
			"[
				{										
					TCHAR *buffer;
					int returnedSize;					
					buffer = (TCHAR *)malloc (MAX_PATH *sizeof(TCHAR));
					returnedSize = GetModuleFileName (NULL, buffer, MAX_PATH);
					if(returnedSize) {
						*$a_succ = 1;
						*$a_count = MAX_PATH * sizeof(TCHAR);
						*$a_module = buffer;
					} else {
						*$a_succ = 0;
					}				
				}
			]"
		end

	get_environment_variables (a_pointer: TYPED_POINTER [POINTER]; a_len: TYPED_POINTER [INTEGER]; a_count: TYPED_POINTER [INTEGER]; a_size: TYPED_POINTER [INTEGER]; a_var_len: TYPED_POINTER [POINTER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get environment variables associated with current process and store them in `a_pointer'.
			-- Length of `a_pointer' in bytes is stored in `a_len'.
			-- `a_count' indicates the number of environment variables.
			-- `a_var_len' is a list of integer, giving the length in bytes of every environment variable.
			-- `a_size' is the size in bytes of an integer in `a_ver_len'.
			-- If succeeded, set `a_succ' to True, otherwise False.
		external
			"C inline"
		alias
			"[
				{
					LPVOID lpvEnv;
					LPTSTR lpszVariable; 
					DWORD *buf;
					int cnt, len, size;
					cnt = 0;
					len = 0;
					lpvEnv = GetEnvironmentStrings();
					if(lpvEnv) {
						*$a_pointer = lpvEnv;
						lpszVariable = (LPTSTR)lpvEnv;
						size = sizeof(*lpszVariable);
						for (;*lpszVariable; lpszVariable++) 
						{ 
						   while (*lpszVariable) {
						      lpszVariable++;
						      len+=size;
						    }
						    len+=size;
						    cnt++;						    				  
						}
						len+=sizeof(*lpszVariable);
						*$a_len = len;
						*$a_count = cnt;
						buf = (DWORD *)malloc(cnt * sizeof(DWORD));
						cnt = 0;
						lpszVariable = (LPTSTR)lpvEnv;
						for (; *lpszVariable; lpszVariable++) 
						{ 
						   len = 0;
						   while (*lpszVariable) {
						      lpszVariable++;
						      len++;
						    }
						    buf[cnt] = len * size + 2;
						    cnt++;						    				  
						}						
						*$a_var_len = buf;
						*$a_size = sizeof(DWORD);
						*$a_succ = 1;
					} else {
						*$a_succ = 0;
					}
				}
			]"
		end

	cwin_free_environment_strings (a_pointer: POINTER) is
			-- Free `a_pointer' as environment strings.
		external
			"C inline"
		alias
			"[
				{
					FreeEnvironmentStrings ($a_pointer);	
				}
			]"
		end

	cwin_free_pointer(ptr: POINTER) is
			--
		external
			"C inline"
		alias
			"[
				{
					free ($ptr);
				}
			]"
		end

end
