indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.RegistryKey"

frozen external class
	MICROSOFT_WIN32_REGISTRYKEY

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize,
			to_string
		end
	SYSTEM_IDISPOSABLE
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

	frozen get_name: STRING is
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

	frozen open_sub_key_string_boolean (name: STRING; writable: BOOLEAN): MICROSOFT_WIN32_REGISTRYKEY is
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

	frozen open_sub_key (name: STRING): MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL signature (System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenSubKey"
		end

	frozen open_remote_base_key (h_key: MICROSOFT_WIN32_REGISTRYHIVE; machine_name: STRING): MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static signature (Microsoft.Win32.RegistryHive, System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenRemoteBaseKey"
		end

	frozen delete_value (name: STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteValue"
		end

	frozen create_sub_key (subkey: STRING): MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL signature (System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"CreateSubKey"
		end

	frozen get_value_string_object (name: STRING; default_value: ANY): ANY is
		external
			"IL signature (System.String, System.Object): System.Object use Microsoft.Win32.RegistryKey"
		alias
			"GetValue"
		end

	frozen delete_value_string_boolean (name: STRING; throw_on_missing_value: BOOLEAN) is
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

	frozen get_sub_key_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use Microsoft.Win32.RegistryKey"
		alias
			"GetSubKeyNames"
		end

	frozen delete_sub_key_tree (subkey: STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKeyTree"
		end

	frozen delete_sub_key (subkey: STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKey"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use Microsoft.Win32.RegistryKey"
		alias
			"ToString"
		end

	frozen delete_sub_key_string_boolean (subkey: STRING; throw_on_missing_sub_key: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKey"
		end

	frozen set_value (name: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"SetValue"
		end

	frozen get_value_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use Microsoft.Win32.RegistryKey"
		alias
			"GetValueNames"
		end

	frozen get_value (name: STRING): ANY is
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

end -- class MICROSOFT_WIN32_REGISTRYKEY
