indexing
	description: "Registration routines"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_REGISTRATION

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

	WEL_MAIN_ARGUMENTS
		export
			{NONE} all
		end

	EOLE_SYS_KIND

	EOLE_SERVER_CONFIGURATION

feature -- Basic operations

	on_register_server (server_type: STRING): INTEGER is
			-- Instructs an server to create its registry entries 
			-- for all classes supported in this server module
		local
			key, subkey: INTEGER
			key_name, version_component_name: STRING
			key_val: WEL_REGISTRY_KEY_VALUE
			wel_string: WEL_STRING
		do
			Result := S_ok
			!!key_name.make (38)
			key_name.append ("CLSID\")
			key_name.append ( clsid)
			key := create_key (Hkey_classes_root, key_name, Key_set_value)

			if key /= 0 then
				!!key_val.make
				key_val.set_type (Reg_sz)
				key_val.set_string_value ( component_name)
				set_key_value (key, Void, key_val)

				subkey := create_key (key, "Control", Key_set_value)

				subkey := create_key (key, "Programmable", Key_set_value)

				subkey := create_key (key, server_type, Key_set_value)
				
				if subkey /= 0 then

					key_val.set_string_value (current_instance.name)
					set_key_value (subkey, Void, key_val)
					if server_type.is_equal ("InprocServer32") then
						key_val.set_string_value ("Apartment")
						set_key_value (subkey, "ThreadingModel", key_val)
					end
					close_key (subkey)
				else 
					Result := Selfreg_e_class
				end
				

				subkey := create_key (key, "ProgID", Key_set_value)

				if subkey /= 0 then
					!!version_component_name.make (100)
					version_component_name.append ( company_name)
					version_component_name.append (".")
					version_component_name.append ( product_name)
					version_component_name.append (".")
					version_component_name.append_integer ( major_version_number)

					key_val.set_string_value (version_component_name)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else
					Result := Selfreg_e_class
				end
				

				subkey := create_key (key, "VersionIndependentProgID", Key_set_value)

				if subkey /= 0 then
					!!version_component_name.make (100)
					version_component_name.append ( company_name)
					version_component_name.append (".")
					version_component_name.append ( product_name)

					key_val.set_string_value (version_component_name)
					set_key_value (subkey, Void, key_val)
					close_key (subkey)
				else
					Result := Selfreg_e_class
				end

				subkey := create_key (key, "TYPELIB", Key_set_value)

				if subkey /= 0 then
					key_val.set_string_value ( typelib_id)
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
				key_val.set_string_value ( component_name)
				set_key_value (key, Void, key_val)

				subkey := create_key (key, "CLSID", Key_set_value)

				if subkey /= 0 then
					key_val.set_string_value ( clsid)
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

	on_unregister_server (server_type: STRING): INTEGER is
			-- entries created through `DllRegisterServer'
		local
			key, subkey: INTEGER
			key_name, version_component_name: STRING
		do
			if unregister_type_library /= S_ok then
				Result := Selfreg_e_class
			end
			!!version_component_name.make (100)
			version_component_name.append ( company_name)
			version_component_name.append (".")
			version_component_name.append ( product_name)
			version_component_name.append (" ")
			version_component_name.append_integer ( major_version_number)
			version_component_name.append (".")
			version_component_name.append_integer ( minor_version_number)

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
			key_name.append ( clsid)

			subkey := open_key (Hkey_classes_root, key_name, Key_set_value)
			if subkey /= 0 then
				if not (
					delete_key (subkey, "VersionIndependentProgID") and
					delete_key (subkey, "ProgID") and 
					delete_key (subkey, server_type) and
					delete_key (subkey, "Control") and
					delete_key (subkey, "Programmable"))
				then
					Result := Selfreg_e_class 
				else
					close_key (subkey)
					if not (delete_key (key,  clsid)) then

						Result := Selfreg_e_class
					end
				end
			end
			close_key (key)
		end

feature {NONE} -- Implementation

	register_type_library: INTEGER is
			-- Register component's type library
		local
			wel_string: WEL_STRING
			type_lib_ptr: POINTER
		do
			!!wel_string.make (current_instance.name)

			type_lib_ptr := ole2_typelib_load_type_lib (wel_string.item)

			Result := c_eole_register_typlib (type_lib_ptr, wel_string.item)
		end


	unregister_type_library: INTEGER is
			-- Unregister component's type library
		local
			wel_string: WEL_STRING
		do
			!!wel_string.make ( typelib_id)
			Result := c_eole_unregister_typelib (wel_string.item,
					 major_version_number, 
					 minor_version_number,
					Sys_win32)
		end


feature {NONE} -- Externals

	c_eole_register_typlib (a_typelib, a_path: POINTER): INTEGER is
		external
			"C [macro %"activex.h%"]"
		end

	c_eole_unregister_typelib (a_typelib_id: POINTER; a_major_version, 
					a_minor_version, a_syskind: INTEGER): INTEGER is
		external
			"C"
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

end -- class EOLE_REGISTRATION
