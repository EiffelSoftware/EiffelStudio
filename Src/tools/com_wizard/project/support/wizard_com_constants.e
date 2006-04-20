indexing
	description: "COM constants and functions name"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COM_CONSTANTS

feature -- COM constants/ function names

	Failed: STRING is "FAILED"

	Hresult_code: STRING is "HRESULT_CODE"

	Hresult_facility: STRING is "HRESULT_FACILITY"

	Appid: STRING is "AppID"

	Prog_id: STRING is "ProgID"

	Current_version: STRING is "CurVer"

	Version_independent_prog_id: STRING is "VersionIndependentProgID"

	Unicode: STRING is "UNICODE"

	Inproc_server32: STRING is "InprocServer32"

	Local_server32: STRING is "LocalServer32"

	Hkey_class_root: STRING is "HKEY_CLASSES_ROOT"

	Class_factory: STRING is "IClassFactory"

	Inprocess_server: STRING is "CLSCTX_INPROC_SERVER"

	Remote_server: STRING is "CLSCTX_LOCAL_SERVER|CLSCTX_REMOTE_SERVER"

	Coserverinfo: STRING is "COSERVERINFO"

	E_no_interface: STRING is "E_NOINTERFACE"

	Class_e_noaggregation: STRING is "CLASS_E_NOAGGREGATION"

	S_ok: STRING is "S_OK"

	S_false: STRING is "S_FALSE"

	E_out_of_memory: STRING is "E_OUTOFMEMORY"

	Ulong_std_method_imp: STRING is "STDMETHODIMP_(ULONG)"

	Std_method_imp: STRING is "STDMETHODIMP"

	Type_lib_type: STRING is "ITypeLib *"

	Type_lib_variable_name: STRING is "pTypeLib"

	Olestr: STRING is "OLESTR"

	E_pointer: STRING is "E_POINTER"

	Tchar: STRING is "TCHAR *"

	Tchar_type: STRING is "TCHAR"

	Automation_marshaler_guid: STRING is "{00020424-0000-0000-C000-000000000046}"

	Class_e_class_not_available: STRING is "CLASS_E_CLASSNOTAVAILABLE"

	Register_server_option_a: STRING is "/REGSERVER"

	Register_server_option_b: STRING is "-REGSERVER"

	Unregister_server_option_a: STRING is "/UNREGSERVER"

	Unregister_server_option_b: STRING is "-UNREGSERVER"

	Embedding_option_a: STRING is "/EMBEDDING"

	Embedding_option_b: STRING is "-EMBEDDING"

	Std_api: STRING is "STDAPI"

	Clsctx_local_server: STRING is "CLSCTX_LOCAL_SERVER"

	Regcls_multiple_use: STRING is "REGCLS_MULTIPLEUSE"

	Regcls_single_use: STRING is "REGCLS_SINGLEUSE"

	Tchar_creation_function: STRING is "__TEXT"

	Interlocked_increment: STRING is "InterlockedIncrement"

	Interlocked_decrement: STRING is "InterlockedDecrement"

	Get_message: STRING is "GetMessage"

	Dispatch_message: STRING is "DispatchMessage"

	Co_task_mem_free: STRING is "CoTaskMemFree"

	Co_task_mem_alloc: STRING is "CoTaskMemAlloc"

	Get_module_file_name: STRING is "GetModuleFileName"

	Dll_register_server: STRING is "DllRegisterServer"

	Dll_unregister_server: STRING is "DllUnregisterServer"

	Dll_get_class_object: STRING is "DllGetClassObject"

	Dll_can_unload_now: STRING is "DllCanUnloadNow"

	Co_initialize: STRING is "CoInitialize (0)"

	Succeeded: STRING is "SUCCEEDED"

	Co_register_class_object: STRING is "CoRegisterClassObject"

	Co_revoke_class_object: STRING is "CoRevokeClassObject"

	Proxy_stub_clsid_32: STRING is "ProxyStubClsid32"

	Type_library: STRING is "TypeLib"

	Num_methods: STRING is "NumMethods";

indexing
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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
