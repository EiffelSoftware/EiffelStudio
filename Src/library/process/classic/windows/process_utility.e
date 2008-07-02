indexing
	description: "Process utilities to go through all processes running on current system"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_UTILITY

inherit
	WEL_PROCESS_TOOLHELP_CONSTANTS

feature -- Access

	process_id_pair_list: LINKED_LIST [TUPLE [parent_id: INTEGER; process_id: INTEGER]] is
			-- List of process id pairs taken from a system snapshot.
			-- first item of a pair is parent process id, second item of a pair is process id.
		local
			ptr: POINTER
			entry: POINTER
			succ: BOOLEAN
			pid1, pid2: INTEGER
			l_count: INTEGER
			l_size: INTEGER
			l_list: MANAGED_POINTER
			i: INTEGER
			l_is_nt: BOOLEAN
		do
			create Result.make
			check_nt_platform ($l_is_nt, $succ)
			if not succ or not l_is_nt then
				cwin_create_toolhelp32_snapshot (toolhelp_handle, 0, $ptr)
				if ptr /= default_pointer then
					from
						cwin_process32_first (toolhelp_handle, ptr, $entry, $succ)
					until
						succ = False
					loop
						cwin_get_process_id_and_parent_id (entry, $pid1, $pid2)
						Result.extend ([pid2, pid1])
						cwin_process32_next (toolhelp_handle, ptr, $entry, $succ)
					end
					if entry /= default_pointer then
						cwin_free_pointer (entry)
					end
					cwin_close_handle (ptr)
				end
			else
				cwin_nt_get_process_list (ntps_handle, $ptr, $l_count, $l_size, $succ)
				if succ then
					create l_list.make_from_pointer (ptr, l_count * l_size)
					from
						i := 0
					until
						i >= l_count
					loop
						pid1 := l_list.read_integer_32 (i * l_size)
						cwin_nt_get_parent_id (ntdll_handle, pid1, $pid2, $succ)
						if succ then
							Result.extend ([pid2, pid1])
						end
						i := i + 1
					end
					cwin_free_pointer (ptr)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	check_nt_platform (a_result, a_succ: TYPED_POINTER [BOOLEAN]) is
			-- If current system is Microsoft NT system, set `a_result' to True, otherwise False.
			-- If succeeded, set `a_succ' to True.
		external
			"C inline use <windows.h>"
		alias
			"[
				{
   					OSVERSIONINFOEX osvi;
   					BOOL bOsVersionInfoEx;
   					BOOL ok = TRUE;

				   ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
   				   osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
				   if( !(bOsVersionInfoEx = GetVersionEx ((OSVERSIONINFO *) &osvi)) ) {
      					osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
      					if (! GetVersionEx ( (OSVERSIONINFO *) &osvi) )
   							ok = FALSE;
   					}
   					if(ok) {
   						if(osvi.dwPlatformId = VER_PLATFORM_WIN32_NT && osvi.dwMajorVersion <= 4 ) {
   							*$a_result = 1;
   						} else {
   							*$a_result = 0;
   						}

						*$a_succ = 1;
   					} else {
   						*$a_succ = 0;
   					}
				}
			]"
		end

feature{NONE} -- Initialization

	toolhelp_handle: POINTER is
			-- Handle using toolhelp API
		once
			Result := (create {WEL_DLL}.make ("Kernel32.dll")).item
		end

	ntps_handle: POINTER is
			-- PSAPI handle used in NT platform
		once
			Result := (create {WEL_DLL}.make ("psapi.dll")).item
		end

	ntdll_handle: POINTER is
			-- NTDLL Handle used in NT platform
		once
			Result := (create {WEL_DLL}.make ("ntdll.dll")).item
		end

feature{NONE} -- Toolhelp API

	cwin_create_toolhelp32_snapshot (a_toolhelp_handle: POINTER; a_prc_id: INTEGER; a_handle: TYPED_POINTER [POINTER]) is
			-- Get system information snapshot and store result in `a_handle'.
			-- After use, call `cwin_close_handle' to close `a_handle'.
		require
			a_toolhelp_handle_valid: a_toolhelp_handle /= default_pointer
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					FARPROC snapshotCreator = NULL;
					HMODULE toolhelpModule = (HMODULE) $a_toolhelp_handle;
					
					snapshotCreator = GetProcAddress (toolhelpModule, "CreateToolhelp32Snapshot");					
					if(snapshotCreator) {
						*$a_handle = (FUNCTION_CAST_TYPE (HANDLE, WINAPI, (DWORD, DWORD)) snapshotCreator) (TH32CS_SNAPPROCESS, $a_prc_id);
						if(*$a_handle == INVALID_HANDLE_VALUE) {
							*$a_handle = 0;
						}						
					}
				}
			]"
		end

	cwin_process32_first (a_toolhelp_handle: POINTER; a_snapshot: POINTER; a_prc_entry: TYPED_POINTER [POINTER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get information of the first process in `a_snapshot' and store result in `a_prc_entry'.
			-- If successed, set `a_succ' to True, otherwise to False.
			-- This feature will create a POINTER object `a_prc_entry' if successful,
			-- so, after use, call `cwin_free_pointer' to destroy `a_prc_entry'.
		require
			a_toolhelp_handle_valid: a_toolhelp_handle /= default_pointer
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					FARPROC process32First = NULL;
					HMODULE toolhelpModule = (HMODULE) $a_toolhelp_handle;					
					PROCESSENTRY32 *pe32;
					BOOL ok = FALSE;
										
					pe32 = (PROCESSENTRY32 *)malloc (sizeof (PROCESSENTRY32));
					pe32->dwSize = sizeof( PROCESSENTRY32 );
					
					process32First = GetProcAddress (toolhelpModule, "Process32First");
					if(process32First) {
						if ((FUNCTION_CAST_TYPE (BOOL, WINAPI, (HANDLE, LPPROCESSENTRY32)) process32First) ($a_snapshot, pe32)) {
							*$a_succ = 1;
							*$a_prc_entry = (EIF_POINTER)pe32;
							ok = TRUE;
	 					}
	 				}
					if(!ok) {
 						*$a_prc_entry = 0;
 						*$a_succ = 0;
 						free (pe32);						 				
					}
				}
			]"
		end

	cwin_process32_next (a_toolhelp_handle: POINTER; a_snapshot: POINTER; a_prc_entry: TYPED_POINTER [POINTER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get information of the next process in `a_snapshot' and store result in `a_prc_entry'.
			-- If successed, set `a_succ' to True, otherwise to False.
			-- After use, call `cwin_free_pointer' to dispose `a_prc_entry'.
		require
			a_toolhelp_handle_valid: a_toolhelp_handle /= default_pointer
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					FARPROC process32Next = NULL;
					HMODULE toolhelpModule = (HMODULE) $a_toolhelp_handle;
				
					process32Next = GetProcAddress (toolhelpModule, "Process32Next");
					
					if(process32Next)
					{
						if ((FUNCTION_CAST_TYPE (BOOL, WINAPI, (HANDLE, LPPROCESSENTRY32)) process32Next) ($a_snapshot, (PROCESSENTRY32 *)(*$a_prc_entry))) {
							*$a_succ = 1;
						}
						else {
							*$a_succ = 0;
						}						
					}
					else {
						*$a_succ = 0;
					}
				}
			]"
		end

	cwin_get_process_id_and_parent_id (a_prc_entry: POINTER; a_pid: TYPED_POINTER [INTEGER]; a_parent_pid: TYPED_POINTER [INTEGER]) is
			-- Get process id and its parent process id from `prc_entry'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					*$a_pid = ((PROCESSENTRY32 *)($a_prc_entry))->th32ProcessID;
					*$a_parent_pid = ((PROCESSENTRY32 *)($a_prc_entry))->th32ParentProcessID;
				}
			]"
		end

feature{NONE} -- NT API

	cwin_nt_get_parent_id (a_ntdll_handle: POINTER; a_pid: INTEGER; a_parent_id: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN])
			-- Store parent process id of process whose id is `a_pid' in `a_parent_id'.
			-- If succeeded, set `a_a_succ' to True.
		require
			a_ntdll_handle_attached: a_ntdll_handle /= default_pointer
		external
			"C inline use %"eif_process.h%""
		alias
			"[
				{
					FARPROC queryProcess = NULL;
					HMODULE ntdllModule = (HMODULE) $a_ntdll_handle;
					BOOL ok = FALSE;
					EIF_PROCESS_BASIC_INFORMATION pbi;
					LONG ntStatus;
					ULONG ulRetLen;
					
					HANDLE hProcess = OpenProcess (PROCESS_QUERY_INFORMATION, FALSE, $a_pid);
					if (hProcess) {
						queryProcess = GetProcAddress (ntdllModule, "NtQueryInformationProcess");
						if (queryProcess) {							
							ntStatus = ((FUNCTION_CAST_TYPE (LONG, WINAPI, (HANDLE, EIF_PROCESSINFOCLASS, PVOID, ULONG, PULONG))
									   queryProcess)
									   (hProcess, 
									    eif_ProcessBasicInformation, 
									    (PVOID *)&pbi, 
									    sizeof(EIF_PROCESS_BASIC_INFORMATION),
									    &ulRetLen 
									   ));
							if (!ntStatus) {
								*$a_parent_id = pbi.InheritedFromUniqueProcessId;
								ok = TRUE;
							}
						}
						CloseHandle (hProcess);
					}
					if (ok) {
						*$a_succ = 1;
					} else {
						*$a_succ = 0;
					}					
				}
			]"
		end

	cwin_nt_get_process_list (a_ntps_handle: POINTER; a_list: TYPED_POINTER [POINTER]; a_count: TYPED_POINTER [INTEGER]; a_size: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Store list of running process ids in `a_list'.
			-- Length of `a_list' is stored in `a_count' and size of every item is stored in `a_size'.
			-- If succeed, set `a_succ' to True.
			-- After use, call `cwin_free_pointer' to dispose `a_list'.
		require
			a_ntps_handle_attached: a_ntps_handle /= default_pointer
		external
			"C inline"
		alias
			"[
				{
					DWORD *prc_list;
					DWORD size = 1024;
					DWORD bytesReturned;
					BOOL ok = FALSE;
					FARPROC enumProcesses = NULL;
					HMODULE ntpsModule = (HMODULE) $a_ntps_handle;
					DWORD rlt;
				
					enumProcesses = GetProcAddress (ntpsModule, "EnumProcesses");
					if(enumProcesses) {					
						/* Return list of running processes. */	
						for(;;) {
							prc_list = (DWORD*)malloc (size);
							rlt = (FUNCTION_CAST_TYPE (BOOL, WINAPI, (DWORD*, DWORD, DWORD*))enumProcesses) (prc_list, size, &bytesReturned);
							if(rlt) {
								if(bytesReturned < size) {
									ok = TRUE;
									break;									
								} else {
									free (prc_list);
									size*=2;
								}
							} else {
								free (prc_list);
								break;
							}
						}							
					}
					if(ok) {
						*$a_list = prc_list;
						*$a_count = bytesReturned / sizeof(DWORD);
						*$a_size = sizeof(DWORD);
						*$a_succ = TRUE;			
					} else {
						*$a_list = NULL;
						*$a_count = 0;
						*$a_succ = FALSE;
					}
				}
			]"
		end


feature{NONE} -- Implementation

	cwin_open_process (desired_access: INTEGER; inheritable: BOOLEAN;  prc_id: INTEGER): POINTER is
			-- After use, call `cwin_close_handle' to close retrieved handle.
		external
			"C signature (DWORD, BOOL, DWORD): HANDLE use <Tlhelp32.h>"
		alias
			"OpenProcess"
		end

	cwin_free_pointer(ptr: POINTER) is
			-- Free pointer `ptr'.
		external
			"C inline"
		alias
			"[
				{
					free ($ptr);
				}
			]"
		end

	cwin_close_handle (a_handle: POINTER) is
			-- SDK CloseHandle.
		external
			"C [macro <winbase.h>] (HANDLE)"
		alias
			"CloseHandle"
		end

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
