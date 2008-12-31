note
	description: "COM constants and functions name"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COM_CONSTANTS

feature -- COM constants/ function names

	Failed: STRING = "FAILED"

	Hresult_code: STRING = "HRESULT_CODE"

	Hresult_facility: STRING = "HRESULT_FACILITY"

	Appid: STRING = "AppID"

	Prog_id: STRING = "ProgID"

	Current_version: STRING = "CurVer"

	Version_independent_prog_id: STRING = "VersionIndependentProgID"

	Unicode: STRING = "UNICODE"

	Inproc_server32: STRING = "InprocServer32"

	Local_server32: STRING = "LocalServer32"

	Hkey_class_root: STRING = "HKEY_CLASSES_ROOT"

	Class_factory: STRING = "IClassFactory"

	Inprocess_server: STRING = "CLSCTX_INPROC_SERVER"

	Remote_server: STRING = "CLSCTX_LOCAL_SERVER|CLSCTX_REMOTE_SERVER"

	Coserverinfo: STRING = "COSERVERINFO"

	E_no_interface: STRING = "E_NOINTERFACE"

	Class_e_noaggregation: STRING = "CLASS_E_NOAGGREGATION"

	S_ok: STRING = "S_OK"

	S_false: STRING = "S_FALSE"

	E_out_of_memory: STRING = "E_OUTOFMEMORY"

	Ulong_std_method_imp: STRING = "STDMETHODIMP_(ULONG)"

	Std_method_imp: STRING = "STDMETHODIMP"

	Type_lib_type: STRING = "ITypeLib *"

	Type_lib_variable_name: STRING = "pTypeLib"

	Olestr: STRING = "OLESTR"

	E_pointer: STRING = "E_POINTER"

	Tchar: STRING = "TCHAR *"

	Tchar_type: STRING = "TCHAR"

	Automation_marshaler_guid: STRING = "{00020424-0000-0000-C000-000000000046}"

	Class_e_class_not_available: STRING = "CLASS_E_CLASSNOTAVAILABLE"

	Register_server_option_a: STRING = "/REGSERVER"

	Register_server_option_b: STRING = "-REGSERVER"

	Unregister_server_option_a: STRING = "/UNREGSERVER"

	Unregister_server_option_b: STRING = "-UNREGSERVER"

	Embedding_option_a: STRING = "/EMBEDDING"

	Embedding_option_b: STRING = "-EMBEDDING"

	Std_api: STRING = "STDAPI"

	Clsctx_local_server: STRING = "CLSCTX_LOCAL_SERVER"

	Regcls_multiple_use: STRING = "REGCLS_MULTIPLEUSE"

	Regcls_single_use: STRING = "REGCLS_SINGLEUSE"

	Tchar_creation_function: STRING = "__TEXT"

	Interlocked_increment: STRING = "InterlockedIncrement"

	Interlocked_decrement: STRING = "InterlockedDecrement"

	Get_message: STRING = "GetMessage"

	Dispatch_message: STRING = "DispatchMessage"

	Co_task_mem_free: STRING = "CoTaskMemFree"

	Co_task_mem_alloc: STRING = "CoTaskMemAlloc"

	Get_module_file_name: STRING = "GetModuleFileName"

	Dll_register_server: STRING = "DllRegisterServer"

	Dll_unregister_server: STRING = "DllUnregisterServer"

	Dll_get_class_object: STRING = "DllGetClassObject"

	Dll_can_unload_now: STRING = "DllCanUnloadNow"

	Co_initialize: STRING = "CoInitialize (0)"

	Succeeded: STRING = "SUCCEEDED"

	Co_register_class_object: STRING = "CoRegisterClassObject"

	Co_revoke_class_object: STRING = "CoRevokeClassObject"

	Proxy_stub_clsid_32: STRING = "ProxyStubClsid32"

	Type_library: STRING = "TypeLib"

	Num_methods: STRING = "NumMethods";

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_COM_CONSTANTS

