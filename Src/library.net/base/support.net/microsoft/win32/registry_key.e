indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.RegistryKey"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REGISTRY_KEY

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			to_string
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create {NONE}

feature -- Access

	frozen get_value_count: INTEGER is
		external
			"IL signature (): System.Int32 use Microsoft.Win32.RegistryKey"
		alias
			"get_ValueCount"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Microsoft.Win32.RegistryKey"
		alias
			"get_Name"
		end

	frozen get_sub_key_count: INTEGER is
		external
			"IL signature (): System.Int32 use Microsoft.Win32.RegistryKey"
		alias
			"get_SubKeyCount"
		end

feature -- Basic Operations

	frozen open_sub_key_string_boolean (name: SYSTEM_STRING; writable: BOOLEAN): REGISTRY_KEY is
		external
			"IL signature (System.String, System.Boolean): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenSubKey"
		end

	frozen close is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"Close"
		end

	frozen open_sub_key (name: SYSTEM_STRING): REGISTRY_KEY is
		external
			"IL signature (System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenSubKey"
		end

	frozen open_remote_base_key (h_key: REGISTRY_HIVE; machine_name: SYSTEM_STRING): REGISTRY_KEY is
		external
			"IL static signature (Microsoft.Win32.RegistryHive, System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenRemoteBaseKey"
		end

	frozen delete_value (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteValue"
		end

	frozen create_sub_key (subkey: SYSTEM_STRING): REGISTRY_KEY is
		external
			"IL signature (System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"CreateSubKey"
		end

	frozen get_value_string_object (name: SYSTEM_STRING; default_value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Object): System.Object use Microsoft.Win32.RegistryKey"
		alias
			"GetValue"
		end

	frozen delete_value_string_boolean (name: SYSTEM_STRING; throw_on_missing_value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteValue"
		end

	frozen flush is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"Flush"
		end

	frozen get_sub_key_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use Microsoft.Win32.RegistryKey"
		alias
			"GetSubKeyNames"
		end

	frozen delete_sub_key_tree (subkey: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKeyTree"
		end

	frozen delete_sub_key (subkey: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKey"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Microsoft.Win32.RegistryKey"
		alias
			"ToString"
		end

	frozen delete_sub_key_string_boolean (subkey: SYSTEM_STRING; throw_on_missing_sub_key: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKey"
		end

	frozen set_value (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"SetValue"
		end

	frozen get_value_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use Microsoft.Win32.RegistryKey"
		alias
			"GetValueNames"
		end

	frozen get_value (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use Microsoft.Win32.RegistryKey"
		alias
			"GetValue"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"System.IDisposable.Dispose"
		end

end -- class REGISTRY_KEY
