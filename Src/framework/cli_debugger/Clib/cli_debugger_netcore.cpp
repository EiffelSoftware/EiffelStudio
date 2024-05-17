
#include "cli_debugger_netcore.h"

//#include <dbgshim.h>

#ifdef _cplusplus
extern "C" {
#endif

typedef VOID (*PSTARTUP_CALLBACK)(IUnknown *pCordb, PVOID parameter, HRESULT hr);	

rt_private EIF_OBJECT dbg_startup_cb_obj;	
rt_private EIF_POINTER dbg_startup_cb_fct;

/**************************************************************************/
/* dbgshim    */

rt_private PVOID m_unregister_token;
rt_private IUnknown *m_pCordb;
rt_private ICorDebug *m_iCorDebug;
rt_private bool m_pCordb_set;

rt_private HRESULT unregister_for_runtime_startup (PVOID a_token);

rt_public void* get_icor_debug()
{
	if (m_iCorDebug) {
		return m_iCorDebug;
	} else {
		return (void*) 0;
	}
}

rt_private void StartupCallback(IUnknown *pCordb, PVOID parameter, HRESULT hr)
{
	DBGTRACE_PTR("[DEBUGGER] StartupCallback <enter> ... pCordb=", (char*) pCordb);
	if (pCordb) {
		m_pCordb = pCordb;
		m_pCordb_set = true;
		pCordb->QueryInterface(IID_ICorDebug, (void **)&m_iCorDebug);
	} else {
		m_pCordb = (ICorDebug* )0;
		m_pCordb_set = false;
	}

	if (m_unregister_token) {
		HRESULT l_hr;
		l_hr = unregister_for_runtime_startup(m_unregister_token);
		m_unregister_token = (PVOID) 0;
	} else {
		DBGTRACE("[DEBUGGER] StartupCallback... no m_unregister_token !");
	}
	printf("[DEBUGGER] StartupCallBack <exit>.\n");
}

rt_public EIF_INTEGER initialize_debug_session (LPWSTR a_command_line, LPVOID a_env, LPCWSTR a_curr_dir, PDWORD p_proc_id, EIF_OBJECT cb_obj, EIF_POINTER cb_fct)
{
	HRESULT hr = S_FALSE;
	HMODULE dbgshim_module;

#ifdef DBGTRACE_ENABLED
	trace_init();
#endif

	dbg_startup_cb_obj = eif_adopt (cb_obj);
	dbg_startup_cb_fct = cb_fct;

	DBGTRACE("[DEBUGGER] initialize_debug_session (...) ...");

	DBGTRACE("[DEBUGGER] Loading dbgshim dyn lib");
	dbgshim_module = LoadLibrary(L"dbgshim.dll");
	if (dbgshim_module != NULL) {
		rt_private FARPROC create_process_for_launch_address = GetProcAddress (dbgshim_module, "CreateProcessForLaunch");
		if (create_process_for_launch_address) {
    		HANDLE resume_handle = 0; // Fake thread handle for the process resume
			hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (LPWSTR, bool, LPVOID, LPCWSTR, PDWORD, HANDLE*)) create_process_for_launch_address)(
						a_command_line,
						(BOOL) TRUE,
						a_env, a_curr_dir, 
						p_proc_id, &resume_handle
					);
			DBGTRACE_HR("[DEBUGGER] CreateProcessForLaunch(..) : hr=", hr);
			DBGTRACE_HR("[DEBUGGER]  -> Process ID(..) : pid=", *p_proc_id);

			rt_private FARPROC register_for_runtime_startup_address = GetProcAddress (dbgshim_module, "RegisterForRuntimeStartup");
			if (register_for_runtime_startup_address) {
				PVOID parameter=0;
				m_unregister_token = (PVOID) 0;
				hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (DWORD, PSTARTUP_CALLBACK, PVOID, PVOID*)) register_for_runtime_startup_address)(
							*p_proc_id,
							StartupCallback,
							parameter,
							&m_unregister_token
						);
				DBGTRACE_HR("[DEBUGGER] RegisterForRuntimeStartup(..) : hr = ", hr);
				rt_private FARPROC resume_process_address = GetProcAddress (dbgshim_module, "ResumeProcess");
				if (resume_process_address) {
					hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (HANDLE)) resume_process_address)(resume_handle);
					DBGTRACE_HR("[DEBUGGER] ResumeProcess(..) : hr = ", hr);
				} else {
					DBGTRACE("[DEBUGGER] Not Found: ResumeProcess");
				}
			} else {
				DBGTRACE("[DEBUGGER] Not Found: RegisterForRuntimeStartup");
			}
		} else {
			DBGTRACE("[DEBUGGER] Not Found: CreateProcessForLaunch");
		}

		CHECKHR ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), hr, "Could not CreateProcessForLaunch");
	} else {
		CHECK (((dbgshim_module != NULL) ? 0 : 1), "Could not load dbgshim.dll");
		hr = -1;
	}
	return hr;
}

rt_private HRESULT unregister_for_runtime_startup (PVOID a_token)
{
	HRESULT hr = S_FALSE;

	rt_private FARPROC unregister_for_runtime_startup_address;
	HMODULE dbgshim_module;

	DBGTRACE("[DEBUGGER] Loading dbgshim dyn lib");
	dbgshim_module = LoadLibrary(L"dbgshim.dll");
	CHECK (((dbgshim_module != NULL) ? 0 : 1), "Could not load dbgshim.dll");

	unregister_for_runtime_startup_address = GetProcAddress (dbgshim_module, "UnregisterForRuntimeStartup");

	if (unregister_for_runtime_startup_address) {
		hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (PVOID)) unregister_for_runtime_startup_address)(
					(PVOID) a_token
				);
		DBGTRACE_HR("[DEBUGGER] UnregisterForRuntimeStartup(..) : hr = ", hr);
	} else {
		DBGTRACE("[DEBUGGER] Not Found: UnregisterForRuntimeStartup");
	}

	CHECKHR ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), hr, "Could not UnregisterForRuntimeStartup");
	return hr;

}

#ifdef _cplusplus
}
#endif
