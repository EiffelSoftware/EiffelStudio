indexing
	description: "Root class of ActiveX component"
	note: "Should not to be modified. Do not inherit from this class. Implement EOLE_ACTIVEX instead"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"
 
class
	EOLE_ACTIVEX_SERVER

inherit
	EOLE_ERROR_CODE

	EOLE_INTERFACE_IDENT

	WEL_REGISTRY
		export
			{NONE} all
		end

	WEL_REGISTRY_KEY_VALUE_TYPE
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	EOLE_SYS_KIND

creation

	make

feature -- Initialization

	make is
			-- Do nothing
			-- This is statless object
		do
			
		end;

feature -- Access

	activex_component: EOLE_ACTIVEX is
			-- Implementation of ActiveX component
		once
			!!Result.make
			Result.co_make
			Result.clsid.to_upper
			Result.typelib_id.to_upper
			Result.dispinterface_id.to_upper
		end
	
	DllGetClassObject (a_clsid: POINTER; a_riid: POINTER; ppv: POINTER): INTEGER is
			-- Retrieves the class object from a DLL object handler or object application,
			-- is called from within the `CoGetClassObject' function.
		local
			string: STRING
		do
			string := c_eole_guid_to_eiffel_string (a_clsid)
			string.to_upper
			if activex_component.clsid.is_equal(string) then
				string := c_eole_guid_to_eiffel_string (a_riid)
				string.to_upper
				if string.is_equal (Iid_class_factory) or
					string.is_equal (Iid_unknown) then	
					!!ole_call_dispatcher.make
				
					if activex_component.ole_interface_ptr = default_pointer then
						activex_component.create_ole_interface_ptr
					end	
					activex_component.add_ref			
					c_eole_dll_get_class_object (ppv, activex_component.ole_interface_ptr)
					Result := S_ok
				else
					c_eole_dll_get_class_object (ppv, Default_pointer)
					Result := E_nointerface
				end
			else
				c_eole_dll_get_class_object (ppv, Default_pointer)
				Result := Class_e_classnotavailable
			end
		end

feature -- Basic operations

	DllRegisterServer: INTEGER is
			-- Instructs an in-process server to create its registry entries 
			-- for all classes supported in this server module
		local
			key, subkey: INTEGER
			key_name, path_to_server, version_component_name: STRING
			key_val: WEL_REGISTRY_KEY_VALUE
			wel_string: WEL_STRING
		do
			Result := S_ok
			!!key_name.make (38)
			key_name.append ("CLSID\")
			key_name.append (activex_component.clsid)
			key := create_key (Hkey_classes_root, key_name, Key_set_value)

			if key /= 0 then
				!!key_val.make
				key_val.set_type (Reg_sz)
				key_val.set_string_value (activex_component.component_name)
				set_key_value (key, Void, key_val)

				subkey := create_key (key, "Control", Key_set_value)

				subkey := create_key (key, "Programmable", Key_set_value)

				subkey := create_key (key, "InprocServer32", Key_set_value)
				
				if subkey /= 0 then
					!!path_to_server.make (200)
					path_to_server.append (current_working_directory)
					path_to_server.append ("\")
					path_to_server.append (activex_component.filename)

					key_val.set_string_value (path_to_server)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else 
					Result := Selfreg_e_class
				end
				

				subkey := create_key (key, "ProgID", Key_set_value)

				if subkey /= 0 then
					!!version_component_name.make (100)
					version_component_name.append (activex_component.company_name)
					version_component_name.append (".")
					version_component_name.append (activex_component.product_name)
					version_component_name.append (".")
					version_component_name.append_integer (activex_component.major_version_number)

					key_val.set_string_value (version_component_name)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else
					Result := Selfreg_e_class
				end
				

				subkey := create_key (key, "VersionIndependentProgID", Key_set_value)

				if subkey /= 0 then
					!!version_component_name.make (100)
					version_component_name.append (activex_component.company_name)
					version_component_name.append (".")
					version_component_name.append (activex_component.product_name)

					key_val.set_string_value (version_component_name)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else
					Result := Selfreg_e_class
				end

				subkey := create_key (key, "TYPELIB", Key_set_value)

				if subkey /= 0 then
					key_val.set_string_value (activex_component.typelib_id)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else
					Result := Selfreg_e_class
				end

				close_key (key)
				key_val.destroy

			else
				Result := Selfreg_e_class
			end
			
			!!key_name.make (38)
			key_name.append (version_component_name)
			key := create_key (Hkey_classes_root, key_name, Key_set_value)

			if key /= 0 then
				!!key_val.make
				key_val.set_type (Reg_sz)
				key_val.set_string_value (activex_component.component_name)
				set_key_value (key, Void, key_val)

				subkey := create_key (key, "CLSID", Key_set_value)

				if subkey /= 0 then
					key_val.set_string_value (activex_component.clsid)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else
					Result := Selfreg_e_class
				end
				close_key (key)
				key_val.destroy
			else
				Result := Selfreg_e_class
			end

			if register_type_library /= S_ok then
				Result := Selfreg_e_class
			end

		end

	DllUnregisterServer: INTEGER is
			-- Instructs an in-process server to remove only those 
			-- entries created through `DllRegisterServer'
		local
			key, subkey: INTEGER
			key_name, version_component_name: STRING
		do
			if unregister_type_library /= S_ok then
				Result := Selfreg_e_class
			end
			!!version_component_name.make (100)
			version_component_name.append (activex_component.company_name)
			version_component_name.append (".")
			version_component_name.append (activex_component.product_name)
			version_component_name.append (" ")
			version_component_name.append_integer (activex_component.major_version_number)
			version_component_name.append (".")
			version_component_name.append_integer (activex_component.minor_version_number)

			!!key_name.make (38)
			key_name.append (version_component_name)
			key := open_key (Hkey_classes_root, key_name, Key_set_value)

			if key /= 0 then
				if not (delete_key (key, "CLSID")
						and delete_key (key, Void)) then
					Result := Selfreg_e_class
				end
			end
			close_key (key)


			!!key_name.make (38)
			key_name.append ("CLSID\")
			
			key := open_key (Hkey_classes_root, key_name, Key_set_value)
			key_name.append (activex_component.clsid)

			subkey := open_key (Hkey_classes_root, key_name, Key_set_value)
			if subkey /= 0 then
				if not (
					delete_key (subkey, "VersionIndependentProgID") and
					delete_key (subkey, "ProgID") and 
					delete_key (subkey, "InprocServer32") and
					delete_key (subkey, "Control") and
					delete_key (subkey, "Programmable"))
				then
					Result := Selfreg_e_class 
				else
					close_key (subkey)
					if not (delete_key (key, activex_component.clsid)) then
						Result := Selfreg_e_class
					end
				end
			end
			close_key (key)
		end

feature -- Status report

	DllCanUnloadNow: INTEGER is
			-- This function is used to determine whether
			-- the DLL is in use.
			-- COM calls it througha call to `CoFreeUnusedLibraries' function.
		do
			if activex_component.reference_counter = 0 and 
					activex_component.server_locks = 0 then
				Result := S_ok
			else
				Result := S_false
			end
		end

feature {NONE} -- Implementation

	ole_call_dispatcher: EOLE_CALL_DISPATCHER
			-- C - Eiffel dispatcher
			-- Should be initialized to allow clients to call back the server.

	register_type_library: INTEGER is
			-- Register component's type library
		local
			wel_string: WEL_STRING
			path_to_server: STRING
			type_lib_ptr: POINTER
		do
			!!path_to_server.make (200)
			path_to_server.append (current_working_directory)
			path_to_server.append ("\")
			path_to_server.append (activex_component.filename)

			!!wel_string.make (path_to_server)

			type_lib_ptr := ole2_typelib_load_type_lib (wel_string.item)

			Result := c_eole_register_typlib (type_lib_ptr, wel_string.item)
		end


	unregister_type_library: INTEGER is
			-- Unregister component's type library
		local
			wel_string: WEL_STRING
		do
			!!wel_string.make (activex_component.typelib_id)
			Result := c_eole_unregister_typelib (wel_string.item,
					activex_component.major_version_number, 
					activex_component.minor_version_number,
					Sys_win32)
		end

feature {NONE} -- Externals

	c_eole_dll_get_class_object (a_ppv: POINTER; a_pv: POINTER) is
		external
			"C [macro %"activex.h%"]"
		end

	c_eole_is_equal_clsid (a_clsid1, a_clsid2: POINTER): BOOLEAN is
		external
			"C [macro %"activex.h%"]"
		end

	c_eole_register_typlib (a_typelib, a_path: POINTER): INTEGER is
		external
			"C [macro %"activex.h%"]"
		end

	c_eole_unregister_typelib (a_typelib_id: POINTER; a_major_version, 
					a_minor_version, a_syskind: INTEGER): INTEGER is
		external
			"C"
		end

	c_eole_get_path_filename (a_file_name: POINTER): STRING is
		external
			"C"
		end

	c_eole_guid_to_eiffel_string (guid: POINTER): STRING is
		external
			"C"
		alias
			"GuidToEiffelString"
		end

	ole2_typelib_load_type_lib (filename: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_load_type_lib"
		end

	c_ole_to_ole_string (a_string: POINTER): POINTER is
		external
			"C"
		alias
			"Eif2OleString"
		end

end -- class EOLE_ACTIVEX_SERVER
