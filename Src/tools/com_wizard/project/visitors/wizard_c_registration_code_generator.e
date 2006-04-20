indexing
	description: "Objects that generate component registration code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_C_REGISTRATION_CODE_GENERATOR

inherit
	WIZARD_REGISTRATION_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR

	WIZARD_GUID_GENERATOR

feature -- Access

	c_writer: WIZARD_WRITER_C_FILE
			-- Writer of C file.

	ccom_dll_register_server_function: STRING is "ccom_dll_register_server_function"
			-- Used for code generation.

	ccom_dll_unregister_server_function: STRING is "ccom_dll_unregister_server_function"
			-- Used for code generation.

	ccom_dll_get_class_object_function: STRING is "ccom_dll_get_class_object_function"
			-- Used for code generation.

	ccom_dll_can_unload_now_function: STRING is "ccom_dll_can_unload_now_function"
			-- Used for code generation.

	Ccom_initialize_com_function: STRING is "ccom_initialize_com_function"
			-- Used for code generation.

	Ccom_cleanup_com_function: STRING is "ccom_cleanup_com_function"
			-- Used for code generation.

	Ccom_register_server_function: STRING is "ccom_register_server_function"
			-- Used for code generation.

	Ccom_unregister_server_function: STRING is "ccom_unregister_server_function"
			-- Used for code generation.

feature -- Basic operations

	generate is
			-- Generate Registration code.
		local
			l_body: STRING
			l_coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
		do
			create c_writer.make

			c_writer.set_header_file_name (Server_registration_header_file_name)
			c_writer.set_header ("Component registration code")

			l_coclasses := system_descriptor.coclasses
			from
				l_coclasses.start
			until
				l_coclasses.after
			loop
				if not Non_generated_type_libraries.has (l_coclasses.item.type_library_descriptor.guid) then
					-- Import/include header file
					-- Coclass header file
					c_writer.add_import (l_coclasses.item.c_declaration_header_file_name)

					-- Class factory header file
					create l_body.make (100)
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_factory.h")
					c_writer.add_import (l_body)

					create l_body.make (100)
					l_body.append ("DWORD dwRegister_")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append (";%N")

					c_writer.add_other_source (l_body)

					create l_body.make (100)
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_factory ")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object;")
					c_writer.add_other_source (l_body)

				end
				l_coclasses.forth
			end
			
			-- Global variables

			-- (TCHAR file_name[MAX_PATH])

			create l_body.make (100)
			l_body.append ("TCHAR file_name[MAX_PATH];")

			c_writer.add_other_source (l_body)

			-- (OLECHAR ws_file_name[MAX_PATH])
			create l_body.make (100)
			l_body.append ("OLECHAR ws_file_name[MAX_PATH];")
			c_writer.add_other_source (l_body)
			
			-- REG_DATA structure
			c_writer.add_other (reg_data_struct)

			-- REG_DATA entries
			c_writer.add_other_source (registry_entries_data)

			-- Entries count
			c_writer.add_other_source (entries_count)

			c_writer.add_function (unregister_feature)
			c_writer.add_function (register_feature)

			if environment.is_in_process then
				c_writer.add_function (dll_get_class_object_feature)
				c_writer.add_function (dll_register_server_feature)
				c_writer.add_function (dll_unregister_server_feature)
				c_writer.add_function (dll_can_unload_now_feature)

				c_writer.add_other (dll_get_class_object_macro)
				c_writer.add_other (dll_register_server_macro)
				c_writer.add_other (dll_unregister_server_macro)
				c_writer.add_other (dll_can_unload_now_macro)
				c_writer.add_other (hInstance_set_up)


				c_writer.add_function (dll_unlock_module_feature)
				c_writer.add_function (dll_lock_module_feature)

				create l_body.make (100)
				l_body.append ("long lock_count = 0;")
				c_writer.add_other_source (l_body)
			else
				c_writer.add_other_source ("DWORD threadID = GetCurrentThreadId ();")
				c_writer.add_function (exe_lock_module_feature)
				c_writer.add_function (exe_unlock_module_feature)
				c_writer.add_function (ccom_regserver_feature)
				c_writer.add_function (ccom_unregserver_feature)
 				c_writer.add_function (ccom_initialize_com_feature)
 				c_writer.add_function (ccom_cleanup_com_feature)

				c_writer.add_other (ccom_regserver_macro)
				c_writer.add_other (ccom_unregserver_macro)
 				c_writer.add_other (ccom_initialize_com_macro)
 				c_writer.add_other (ccom_cleanup_com_macro)
			end

			check
				can_generate_code: c_writer.can_generate
			end

			Shared_file_name_factory.create_registration_file_name (Current, c_writer)
			c_writer.save_file (Shared_file_name_factory.last_created_file_name)
			c_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_registration_code
		end

feature {NONE} -- Access

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor

	coclass_guid: STRING
			-- Coclass's guid in string format

	type_library_name: STRING
			-- Name of type library the coclass is in

	type_library_guid: STRING
			-- Type library's guid

feature {NONE} -- Implementation

	ccom_initialize_com_feature: WIZARD_WRITER_C_FUNCTION is
			-- Administration function to register class object.
			-- Only generated if is outproc server.
		local
			l_body: STRING
			l_coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
		do
			create Result.make
			Result.set_name ("ccom_initialize_com_function")
			Result.set_comment ("Initialize server.")
			Result.set_result_type (Void_c_keyword)


			-- HRESULT hr = CoInitialize (0)
			create l_body.make (100)
			l_body.append ("%THRESULT hr = CoInitialize (0);%N%T")
			l_body.append (examine_hresult (Hresult_variable_name))
			l_body.append ("%N%T")

			l_coclasses := system_descriptor.coclasses
			from
				l_coclasses.start
			until
				l_coclasses.after
			loop
				if not Non_generated_type_libraries.has (l_coclasses.item.type_library_descriptor.guid) then
					-- hr = CoRegisterClassObject ('Class_id', static_case<IClassFactory*> ('class_object'),
					-- CLSCTX_LOCAL_SERVER, REGCLS_MULTIPLEUSE, &'class_object_registration_token')
					-- ** Allow the implementors to choice between REGCLS_SINGLEUSE or REGCLS_MULTIPLEUSE later.

					l_body.append ("if (!(")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object.IsInitialized))%N%T%T%T")

					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object.Initialize();%N%T%T")

					l_body.append ("hr = CoRegisterClassObject (")
					l_body.append (clsid_name(l_coclasses.item.c_type_name))
					l_body.append (", static_cast<IClassFactory*>(&")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object), CLSCTX_LOCAL_SERVER, REGCLS_MULTIPLEUSE, &dwRegister_")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append (");%N%T")

					l_body.append ("if (FAILED (hr))%N%T{%N%T%Tcom_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T}%N%T")
				end
				
				l_coclasses.forth
			end
			
			Result.set_body (l_body)
		end

	ccom_initialize_com_macro: STRING is "#define ccom_initialize_com (ccom_initialize_com_function())"
			-- Macro for `ccom_initialize_com' function.

	ccom_cleanup_com_feature: WIZARD_WRITER_C_FUNCTION is
			-- Administration function to unregister class object.
			-- Only generated if is outproc server.
		local
			l_body: STRING
			l_coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
		do
			create Result.make
			Result.set_name ("ccom_cleanup_com_function")
			Result.set_comment ("Clean up COM.")
			Result.set_result_type ("void")

			create l_body.make (10000)
			l_body.append ("%T")
			l_coclasses := system_descriptor.coclasses
			from
				l_coclasses.start
			until
				l_coclasses.after
			loop
				if not Non_generated_type_libraries.has (l_coclasses.item.type_library_descriptor.guid) then
					l_body.append ("CoRevokeClassObject (dwRegister_")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append (");%N%N%T")
				end
				l_coclasses.forth
			end
			l_body.append ("CoUninitialize ();")
			Result.set_body (l_body)
		end

	ccom_cleanup_com_macro: STRING is "#define ccom_cleanup_com (ccom_cleanup_com_function())"
			-- Macro for `ccom_cleanup_com' function.

	ccom_unregserver_feature: WIZARD_WRITER_C_FUNCTION is
			-- Administration function to register or unregister server
			-- Only generated if is outproc server
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_unregister_server_function)
           	Result.set_comment ("Unregister server.")
			Result.set_result_type (Void_c_keyword)
			create l_body.make (100)
			l_body.append ("%THRESULT hr = CoInitialize (0);%N%N%T")
			l_body.append ("Unregister (reg_entries, com_entries_count);%N%T")
			l_body.append ("CoUninitialize ();%N%T")
			l_body.append ("return;")
			Result.set_body (l_body)
		end

	ccom_unregserver_macro: STRING is "#define ccom_unregister_server (ccom_unregister_server_function())"
			-- Macro for `ccom_unregister_server' function.

	ccom_regserver_feature: WIZARD_WRITER_C_FUNCTION is
			-- Administration function to register or unregister server
			-- Only generated if is outproc server
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name ("ccom_register_server_function")
			Result.set_comment ("Register server.")
			Result.set_result_type ("void")
			create l_body.make (500)
			l_body.append ("%THRESULT hr = CoInitialize (0);%N%T")
			l_body.append ("if (FAILED (hr))%N%T")
			l_body.append ("{%N%T%T")
			l_body.append ("com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));%N%T")
			l_body.append ("}%N%T")
			l_body.append (exe_module_file_name_set_up)
			l_body.append ("%N%TRegister (reg_entries, com_entries_count);%N%TCoUninitialize ();")
			Result.set_body (l_body)
		end

	ccom_regserver_macro: STRING is "#define ccom_register_server (ccom_register_server_function())";
			-- Macro for `ccom_register_server' function.

	dll_get_class_object_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllGetClassObject code
		local
			l_body: STRING
			l_coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
			l_coclass: WIZARD_COCLASS_DESCRIPTOR
		do
			create Result.make

			Result.set_name ("ccom_dll_get_class_object_function")
			Result.set_comment ("DLL get class object funcion")
			Result.set_result_type ("EIF_INTEGER")
			Result.set_signature ("CLSID * rclsid, IID * riid, void **ppv")

			create l_body.make (10000)
			l_body.append ("%T")

			l_coclasses := system_descriptor.coclasses
			from
				l_coclasses.start
			until
				l_coclasses.after
			loop
				l_coclass := l_coclasses.item
				if not Non_generated_type_libraries.has (l_coclass.type_library_descriptor.guid) then
					l_body.append ("if (IsEqualGUID (* rclsid, ")
					l_body.append (clsid_name (l_coclasses.item.c_type_name))
					l_body.append ("))%N%T{%N%T%Tif (!(")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object.IsInitialized))%N%T%T%T")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object.Initialize();%N%T%Treturn ")
					l_body.append (l_coclasses.item.c_type_name)
					l_body.append ("_cls_object.QueryInterface (* riid, ppv);%N%T}%N%Telse ")
				end
				l_coclasses.forth
			end
			l_body.append ("%N%T%Treturn (*ppv = 0), CLASS_E_CLASSNOTAVAILABLE;")
			Result.set_body (l_body)
		end

	exe_module_file_name_set_up: STRING is
			-- Code to set up module file name
		once
			create Result.make (200)
			Result.append ("%TGetModuleFileName (0, file_name, MAX_PATH);%N")
			Result.append ("#ifdef UNICODE%N%T")
			Result.append ("lstrcpy (ws_file_name, file_name);%N")
			Result.append ("#else%N%T")
			Result.append ("mbstowcs (ws_file_name, file_name, MAX_PATH);%N")
			Result.append ("#endif")
		end

	dll_module_file_name_set_up: STRING is
			-- Code to set up module file name
		once
			create Result.make (200)
			Result.append ("%TGetModuleFileName (eif_hInstance, file_name, MAX_PATH);%N")
			Result.append ("#ifdef UNICODE%N%T")
			Result.append ("lstrcpy (ws_file_name, file_name);%N")
			Result.append ("#else%N%T")
			Result.append ("mbstowcs (ws_file_name, file_name, MAX_PATH);%N")
			Result.append ("#endif")
		end
		
	dll_get_class_object_macro: STRING is "#define ccom_dll_get_class_object(_arg1_, _arg2_, _arg3_) %
											%(ccom_dll_get_class_object_function ((CLSID*)_arg1_, (IID*)_arg2_, (void**)_arg3_))"
			-- Macro for `ccom_dll_get_class_object' function.

	dll_register_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllRegisterServer
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name ("ccom_dll_register_server_function")
			Result.set_comment ("Register DLL server.")
			Result.set_result_type ("EIF_INTEGER")
			Result.set_signature ("void")

			create l_body.make (1000)
			l_body.append ("%T")
			l_body.append (dll_module_file_name_set_up)
			l_body.append ("%N%Treturn Register (reg_entries, com_entries_count);")

			Result.set_body (l_body)
		end

	dll_register_server_macro: STRING is "#define ccom_dll_register_server (ccom_dll_register_server_function())"
			-- Macro for `ccom_dll_register_server' function.

	dll_unregister_server_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllUnregisterServer
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_dll_unregister_server_function)
			Result.set_comment ("Unregister Server.")
			Result.set_result_type ("EIF_INTEGER")
			Result.set_signature ("void")

			create l_body.make (1000)
			l_body.append ("%Treturn Unregister (reg_entries, com_entries_count);")
			Result.set_body (l_body)
		end

	dll_unregister_server_macro: STRING is "#define ccom_dll_unregister_server (ccom_dll_unregister_server_function())";
			-- Macro for `ccom_dll_unregister_server' function.

	dll_can_unload_now_feature: WIZARD_WRITER_C_FUNCTION is
			-- DllCanUnloadNow function
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_dll_can_unload_now_function)
			Result.set_comment ("Whether component can be unloaded?")
			Result.set_result_type (Eif_integer)
			Result.set_signature (Void_c_keyword)

			create l_body.make (1000)
			l_body.append ("%Treturn lock_count ? S_FALSE : S_OK;")
			Result.set_body (l_body)
		end

	dll_can_unload_now_macro: STRING is "#define ccom_dll_can_unload_now (ccom_dll_can_unload_now_function())"
			-- Macro for `ccom_dll_can_unload_now' function.

	exe_lock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- Exe implementation of LockModule
		do
			create Result.make
			Result.set_name ("LockModule")
			Result.set_comment ("Lock module.")
			Result.set_result_type ("void")
			Result.set_signature ("void")

			Result.set_body ("%TCoAddRefServerProcess ();")
		end

	exe_unlock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- Exe implementation of UnlockModule
		do
			create Result.make
			Result.set_name ("UnlockModule")
			Result.set_comment ("Unlock module.")
			Result.set_result_type ("void")
			Result.set_signature ("void")
			Result.set_body ("%Tif (CoReleaseServerProcess () == 0)%N%T%TPostThreadMessage (threadID, WM_QUIT, 0, 0);")
		end

	dll_unlock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- DLL implementation of UnlockModule
		do
			create Result.make
			Result.set_name ("UnlockModule")
			Result.set_comment ("Unlock module.")
			Result.set_result_type ("void")
			Result.set_signature ("void")
			Result.set_body ("%TInterlockedDecrement (&lock_count);")
		end

	dll_lock_module_feature: WIZARD_WRITER_C_FUNCTION is
			-- DLL implementation of LockModule
		do
			create Result.make
			Result.set_name ("LockModule")
			Result.set_comment ("Lock module.")
			Result.set_result_type ("void")
			Result.set_signature ("void")
			Result.set_body ("%TInterlockedIncrement (&lock_count);")
		end

	unregister_feature: WIZARD_WRITER_C_FUNCTION is
			-- Code to unregister server/component
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (Unregister)
			Result.set_comment ("Unregister Server/Component")
			Result.set_result_type (Eif_integer)
			Result.set_signature ("const REG_DATA *rgEntries, int cEntries")
			create l_body.make (10000)
			l_body.append ("%T")
			l_body.append (libid_definition (system_descriptor.name, system_descriptor.type_lib_guid))
			l_body.append ("%N%THRESULT hr = UnRegisterTypeLib (")
			l_body.append (libid_name (system_descriptor.name))
			l_body.append (", 1, 0, 0, SYS_WIN32);")
			l_body.append ("%N%TBOOL bSuccess = SUCCEEDED (hr);")
			l_body.append ("%N%Tfor (int i= cEntries -1; i >= 0; i--)")
			l_body.append ("%N%Tif (rgEntries[i].pDelOnUnregister)")
			l_body.append ("%N%T%TbSuccess = (RegDeleteKey (HKEY_CLASSES_ROOT, rgEntries[i].pKeyName) == ERROR_SUCCESS);")
			l_body.append ("%N%Treturn bSuccess ? S_OK : S_FALSE;")
			Result.set_body (l_body)
		end

	register_feature: WIZARD_WRITER_C_FUNCTION is
			-- Code to register server
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (Register)
			Result.set_comment ("Register Server")
			Result.set_result_type ("EIF_INTEGER")
			Result.set_signature ("const REG_DATA *rgEntries, int cEntries")
			create l_body.make (900)
			l_body.append ("%TBOOL bSuccess = TRUE;%N%T")
			l_body.append ("const REG_DATA *pEntry = rgEntries;%N%T")
			l_body.append ("while (pEntry < rgEntries + cEntries)%N%T{%N%T%T")
			l_body.append ("HKEY hkey;%N%T%T")
			l_body.append ("LONG err = RegCreateKey (HKEY_CLASSES_ROOT, pEntry->pKeyName, &hkey);%N%T%T")
			l_body.append ("if (err == ERROR_SUCCESS)%N%T%T{%N%T%T%T")
			l_body.append ("if (pEntry->pValue)%N%T%T%T%T")
			l_body.append ("err = RegSetValueEx (hkey, pEntry->pValueName, 0, REG_SZ, (const BYTE*)pEntry->pValue, (lstrlen (pEntry->pValue) + 1) * sizeof (TCHAR));%N%T%T%T%T")
			l_body.append ("if (err != ERROR_SUCCESS)%N%T%T%T%T{%N%T%T%T%T%T")
			l_body.append ("bSuccess = FALSE;%N%T%T%T%T%T")
			l_body.append ("Unregister (rgEntries, 1 + pEntry - rgEntries);%N%T%T%T%T}%N%T%T%T%T")
			l_body.append ("RegCloseKey (hkey);%N%T%T%T}%N%T%T%T")
			l_body.append ("if (err != ERROR_SUCCESS)%N%T%T%T{%N%T%T%T%T")
			l_body.append ("bSuccess = FALSE;%N%T%T%T%T")
			l_body.append ("if (pEntry != rgEntries)%N%T%T%T%T%T")
			l_body.append ("Unregister (rgEntries, pEntry - rgEntries);%N%T%T%T}%N%T%T")
			l_body.append ("pEntry++;%N%T}%N%T")
			l_body.append ("if (!bSuccess)%N%T")
			l_body.append ("return E_FAIL;%N%N%T")
			l_body.append ("ITypeLib *ptl = 0;%N%T")
			l_body.append ("HRESULT hr = LoadTypeLib (ws_file_name, &ptl);%N%T")
			l_body.append ("if (SUCCEEDED (hr))%N%T{%N%T%T")
			l_body.append ("hr = RegisterTypeLib (ptl, ws_file_name, 0);%N%T%T")
			l_body.append ("ptl->Release ();%N%T}%N%T")
			l_body.append ("return hr;")
			Result.set_body (l_body)
		end

	entries_count: STRING is "const int com_entries_count = sizeof (reg_entries)/sizeof (*reg_entries);"
			-- Entries count

	dll_specific_registry_entries: STRING is
			-- Dll specific registry entries
		require
			non_void_guid: coclass_guid /= Void
			valid_guid: not coclass_guid.is_empty
		local
			l_entry: STRING
		do
			create l_entry.make (100)
			l_entry.append ("CLSID\\")
			l_entry.append (coclass_guid)
			l_entry.append ("\\InprocServer32")
			create Result.make (1000)
			Result.append (struct_creator (tchar_creator (l_entry), "0", Module_file_name, "TRUE"))
			Result.append (", %N%T")
			Result.append (struct_creator (tchar_creator (l_entry), tchar_creator ("ThreadingModel"), tchar_creator ("Apartment"), "TRUE"))
		end

	application_specific_registry_entries: STRING is 
			-- Application specific registry entries
		require
			non_void_guid: coclass_guid /= Void
			valid_guid: not coclass_guid.is_empty
			non_void_name: coclass_descriptor.name /= Void
			valid_coclass_name: not coclass_descriptor.name.is_empty
		local
			l_string_one, l_string_two: STRING
		do
			create l_string_one.make (500)
			l_string_one.append ("AppID\\")
			l_string_one.append (coclass_guid)

			create l_string_two.make (500)
			l_string_two.append ("%"")
			l_string_two.append (coclass_descriptor.name)
			l_string_two.append (" Application%"")

			Result := struct_creator (tchar_creator (l_string_one), "0", l_string_two, "TRUE")
			Result.append (",%N%T")

			create l_string_one.make (500)
			l_string_one.append ("AppID\\")
			l_string_one.append (environment.project_name)

			Result.append (struct_creator (tchar_creator (l_string_one), tchar_creator ("AppID"), tchar_creator (coclass_guid), "TRUE"))
 			Result.append (",%N%T")

			create l_string_one.make (500)
			l_string_one.append ("CLSID\\")
			l_string_one.append (coclass_guid)
			l_string_one.append ("\\LocalServer32")

			Result.append (struct_creator (tchar_creator (l_string_one), "0", "file_name", "TRUE"))
			Result.append (",%N%T")

			Result.append (struct_creator (tchar_creator (l_string_one), tchar_creator ("ThreadingModel"), tchar_creator ("Apartment"), "TRUE"))
			Result.append (",%N%T")

			create l_string_one.make (500)
			l_string_one.append ("CLSID\\")
			l_string_one.append (coclass_guid)

			Result.append (struct_creator (tchar_creator (l_string_one), tchar_creator ("AppID"), tchar_creator (coclass_guid), "TRUE"))
		end

	tchar_creator (value: STRING): STRING is
			-- Tchar creator __TEXT("value")
		require
			non_void_string: value /= Void
		do
			create Result.make (value.count + 10)
			Result.append ("__TEXT(%"")
			Result.append (value)
			Result.append ("%")")
		end

	registry_entries_data: STRING is
			-- Registry entries for both dll and application
		local
			l_string_one, l_string_two: STRING
			l_coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
		do
			create Result.make (10000)
			Result.append ("const REG_DATA reg_entries[] = %N{%N%T")
			l_coclasses := system_descriptor.coclasses
			from
				l_coclasses.start
			until
				l_coclasses.after
			loop
				if not Non_generated_type_libraries.has (system_descriptor.coclasses.item.type_library_descriptor.guid) then
					coclass_descriptor := system_descriptor.coclasses.item
					coclass_guid := coclass_descriptor.guid.to_string.twin
					type_library_name := coclass_descriptor.type_library_descriptor.name
					type_library_guid := coclass_descriptor.type_library_descriptor.guid.to_string

					create l_string_one.make (500)
					l_string_one.append ("CLSID\\")
					l_string_one.append (coclass_guid)

					create l_string_two.make (500)
					l_string_two.append (system_descriptor.coclasses.item.name)
					l_string_two.append (" Class")

					Result.append ("%N%T")
					Result.append (struct_creator (tchar_creator (l_string_one), "0", tchar_creator (l_string_two), "TRUE"))
					Result.append (",%N%T")

					if environment.is_in_process then
						Result.append (dll_specific_registry_entries)
					else
						Result.append (application_specific_registry_entries)
					end
					Result.append (",%N%T")

					create l_string_one.make (500)
					l_string_one.append ("CLSID\\")
					l_string_one.append (coclass_guid)				
					l_string_one.append ("\\ProgID")

					create l_string_two.make (500)
					l_string_two.append (type_library_name)
					l_string_two.append (".")
					l_string_two.append (coclass_descriptor.name)
					l_string_two.append (".1")

					Result.append (struct_creator (tchar_creator (l_string_one), "0", tchar_creator (l_string_two), "TRUE"))
					Result.append (",%N%T")

					create l_string_one.make (500)
					l_string_one.append ("CLSID\\")
					l_string_one.append (coclass_guid)
					l_string_one.append ("\\VersionIndependentProgID")

					create l_string_two.make (500)
					l_string_two.append (type_library_name)
					l_string_two.append (".")
					l_string_two.append (coclass_descriptor.name)

					Result.append (struct_creator (tchar_creator (l_string_one), "0", tchar_creator (l_string_two), "TRUE"))
					Result.append (",%N%T")

					l_string_two.append (".1")

					Result.append (struct_creator (tchar_creator (l_string_two), "0", tchar_creator (coclass_descriptor.name), "TRUE"))
					Result.append (",%N%T")

					l_string_two.append ("\\CLSID")

					Result.append (struct_creator (tchar_creator (l_string_two), "0", tchar_creator (coclass_guid), "TRUE"))
					Result.append (",%N%T")

					create l_string_one.make (500)
					l_string_one.append (type_library_name)
					l_string_one.append (".")
					l_string_one.append (coclass_descriptor.name)

					Result.append (struct_creator (tchar_creator (l_string_one), "0", tchar_creator (coclass_descriptor.name), "TRUE"))
					Result.append (",%N%T")

					create l_string_two.make (500)
					l_string_two.append (l_string_one)
					l_string_two.append ("\\CLSID")

					Result.append (struct_creator (tchar_creator (l_string_two), "0", tchar_creator (coclass_guid), "TRUE"))
					Result.append (",%N%T")

					create l_string_two.make (500)
					l_string_two.append (l_string_one)
					l_string_one.append ("\\CurVer.1")

					Result.append (struct_creator (tchar_creator (l_string_one), "0", tchar_creator (l_string_two), "TRUE"))
					Result.append (",")
				end
				system_descriptor.coclasses.forth
			end

			Result.remove (Result.count)
			Result.append ("%N};")
		end

	universal_marshaling_registration_code: STRING is
		require
			non_void_descriptor: coclass_descriptor /= Void
		local
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			create Result.make (10000)
			l_descriptors := coclass_descriptor.interface_descriptors
			from
				l_descriptors.start
			until
				l_descriptors.off
			loop
				Result.append (universal_marshaling_interface_registration_code (l_descriptors.item))
				l_descriptors.forth
			end
		end

	universal_marshaling_interface_registration_code (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR): STRING is
		require
			non_void_descriptor: interface_descriptor /= Void
		local
			l_string_one, l_string_two, l_guid: STRING
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			l_guid := interface_descriptor.guid.to_string.twin

			create l_string_one.make (500)
			l_string_one.append ("Interface\\")
			l_string_one.append (l_guid)

			create Result.make (10000)
			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_string_one), "0", tchar_creator (interface_descriptor.c_type_name), "TRUE"))

			l_string_one.append (Registry_field_seperator)

			create l_string_two.make (500)
			l_string_two.append (l_string_one)
			l_string_two.append ("ProxyStubClsid32")

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_string_two), "0", tchar_creator (Automation_marshaler_guid), "TRUE"))

			create l_string_two.make (1000)
			l_string_two.append (l_string_one)
			l_string_two.append ("TypeLib")

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_string_two), "0", tchar_creator (type_library_guid), "TRUE"))

			create l_string_two.make (1000)
			l_string_two.append (l_string_one)
			l_string_two.append ("NumMethods")

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_string_two), "0", tchar_creator (interface_descriptor.functions_count.out), "TRUE"))

			l_interface := interface_descriptor.inherited_interface
			if not l_interface.is_well_known_interface then
				Result.append (universal_marshaling_interface_registration_code (l_interface))
			end
		end

	standard_marshaling_registration_code: STRING is
			-- Registration code for standard marshalling
		require
			non_void_descriptor: coclass_descriptor /= Void
		local
			l_one, l_two, l_file_name: STRING
			l_new_guid: ECOM_GUID
			i, l_count: INTEGER
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			create Result.make (10000)

			-- Register interfaces
			l_descriptors := coclass_descriptor.interface_descriptors
			from
				l_descriptors.start
			until
				l_descriptors.after
			loop
				Result.append (standard_marshaling_interface_registration_code (l_descriptors.item))
				l_descriptors.forth
			end

			-- Register proxy and stub dll
			create l_new_guid.make
			l_new_guid.generate

			create l_one.make (1000)
			l_one.append ("CLSID\\")
			l_one.append (l_new_guid.to_string)

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_one), "0", tchar_creator ("Proxy/Stub "), "TRUE"))

			l_one.append ("\\InprocServer32")

			l_file_name := environment.proxy_stub_file_name
			create l_two.make (10000)
			from
				i := 1
				l_count := l_file_name.count
			until
				i > l_count
			loop
				if l_file_name.item (i).is_equal ('\') then
					l_two.append ("\\")
				else
					l_two.append_character (l_file_name.item (i))
				end
				i := i + 1
			end

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_one), "0", tchar_creator (l_two), "TRUE"))
			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_one), tchar_creator ("ThreadingModel"), tchar_creator ("Both"), "TRUE"))
		end

	standard_marshaling_interface_registration_code (interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Registration code for interface
		require
			non_void_descriptor: interface_descriptor /= Void
		local
			l_guid, l_one, l_two: STRING
		do
			l_guid := interface_descriptor.guid.to_string.twin

			create l_one.make (1000)
			l_one.append ("Interface\\")
			l_one.append (l_guid)

			create Result.make (10000)
			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_one), "0", tchar_creator (interface_descriptor.c_type_name), "TRUE"))

			l_one.append ("\\")

			create l_two.make (1000)
			l_two.append (l_one)
			l_two.append ("ProxyStubClsid32")

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_two), "0", tchar_creator (l_guid), "TRUE"))

			create l_two.make (1000)
			l_two.append (l_one)
			l_two.append ("TypeLib")

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_two), "0", tchar_creator (type_library_guid), "TRUE"))

			create l_two.make (1000)
			l_two.append (l_one)
			l_two.append ("NumMethods")

			Result.append (",%N%T")
			Result.append (struct_creator (tchar_creator (l_two), "0", tchar_creator (interface_descriptor.functions_count.out), "TRUE"))

			if not interface_descriptor.inherited_interface.c_type_name.is_equal (Iunknown_type) and 
					not interface_descriptor.inherited_interface.c_type_name.is_equal (Idispatch_type) then
				Result.append (standard_marshaling_interface_registration_code (interface_descriptor.inherited_interface))
			end
		end
	
	struct_creator (first_field, second_field, third_field, forth_field: STRING): STRING is
			-- Reg data struct creator
		do
			create Result.make (10000)
			Result.append ("{%N%T%T")
			Result.append (first_field)
			Result.append (",%N%T%T")
			Result.append (second_field)
			Result.append (",%N%T%T")
			Result.append (third_field)
			Result.append (",%N%T%T")
			Result.append (forth_field)
			Result.append ("%N%T}")
		end

	reg_data_struct: STRING is
			-- Structure code
			-- Use add_other
		once
			create Result.make (110)
			Result.append ("struct REG_DATA%N{%N%T")
			Result.append ("const TCHAR *pKeyName;%N%T")
			Result.append ("const TCHAR *pValueName;%N%T")
			Result.append ("const TCHAR *pValue;%N%T")
			Result.append ("BOOL pDelOnUnregister;%N};")
		end

	hInstance_set_up: STRING is
			-- Set up hInstance
		once
			Result := "RT_LNK HINSTANCE eif_hInstance;%N"
		end

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
end -- class WIZARD_C_REGISTRATION_CODE_GENERATOR

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

