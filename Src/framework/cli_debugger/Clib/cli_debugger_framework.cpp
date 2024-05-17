#include <objbase.h>
#include <eif_lmalloc.h>

#include "cli_common.h"
#include "cli_debugger_framework.h"

#ifdef _cplusplus
extern "C" {
#endif

#ifdef EIF_ASSERTIONS
	/* Error message for exceptions */
rt_private char message [1024];
rt_private void raise_error (HRESULT hr,char *pref, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "%s 0x%x: %s", pref, hr, msg);
	eraise (message, EN_PROG);
}
#define CHECK(hr,msg) if (hr) raise_error (hr, "check", msg);
#define CHECKHR(cond, hr, msg) if (cond) raise_error (hr, "check", msg);
#define REQUIRE(cond,msg) if (!cond) raise_error (-1, "require", msg);
#define ENSURE(cond,msg) if (!cond) raise_error (-1, "ensure", msg);
#else
#define CHECK(hr,msg)
#define CHECKHR(cond,hr,msg)
#define REQUIRE(cond,msg)
#define ENSURE(cond,msg)
#endif

/**************************************************************************/
/* ICorDebug  */

rt_private LPWSTR dbg_debuggee_version;

rt_public EIF_INTEGER get_cordebug (LPWSTR a_dbg_version, EIF_POINTER ** icd)
	/* Create new instance of ICorDebug */
{
	HRESULT hr;
#ifdef DBGTRACE_ENABLED
	trace_init();
#endif

	rt_private FARPROC create_debug_address;
	HMODULE mscoree_module;

	dbg_debuggee_version = a_dbg_version;

	mscoree_module = NULL;
	mscoree_module = LoadLibrary(L"mscoree.dll");
	CHECK (((mscoree_module != NULL) ? 0 : 1), "Could not load mscoree.dll");

	create_debug_address = NULL;
	create_debug_address = GetProcAddress (mscoree_module, "CreateDebuggingInterfaceFromVersion");

	if (create_debug_address) {
		/*
		 * from cordebug.idl :
		 *	CorDebugInvalidVersion = 0,
		 *	CorDebugVersion_1_0 = CorDebugInvalidVersion + 1, = 1
		 *	CorDebugVersion_1_1 = CorDebugVersion_1_0 + 1,    = 2
		 *	CorDebugVersion_2_0 = CorDebugVersion_1_1 + 1,    = 3
		 *	CorDebugVersion_3_0 = CorDebugVersion_2_0 + 1,    = 4
		 *
		 */
		hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (int, LPCWSTR, IUnknown**)) create_debug_address)(
					4, /* ie CorDebugLatestVersion */
					a_dbg_version,
					(IUnknown**) icd
				);
		DBGTRACE_HR("[DEBUGGER] CreateDebuggingInterfaceFromVersion CorDebugVersion_3_0 : hr = ", hr);
		DBGTRACE_PTR("[DEBUGGER] CreateDebuggingInterfaceFromVersion CorDebugVersion_3_0 : icd = ", icd);
		if (hr != S_OK) {
			hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (int, LPCWSTR, IUnknown**)) create_debug_address)(
						3, /* ie CorDebugLatestVersion */
						a_dbg_version,
						(IUnknown**) icd
					);
			DBGTRACE_HR("[DEBUGGER] CreateDebuggingInterfaceFromVersion CorDebugVersion_2_0 : hr = ", hr);
		}
	} else {
		hr = CoCreateInstance (
					CLSID_CorDebug,
					NULL,
					CLSCTX_INPROC_SERVER,
					IID_ICorDebug,
					(void **) icd
				);
		DBGTRACE_HR("[DEBUGGER] CoCreateInstance (.. CorDebug ...) : hr = ", hr);
	}

	CHECKHR ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), hr, "Could not create ICorDebug");
	return hr;
}

#ifdef _cplusplus
}
#endif

