indexing
	Generator: "Eiffel Emitter 2.5b2"
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
			dispose as disposable_dispose
		end

create {NONE}

feature -- Access

	frozen get_value_count: INTEGER is
		external
			"IL signature (): System.Int32 use Microsoft.Win32.RegistryKey"
		alias
			"get_ValueCount"
		end

	frozen get_sub_key_count: INTEGER is
		external
			"IL signature (): System.Int32 use Microsoft.Win32.RegistryKey"
		alias
			"get_SubKeyCount"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use Microsoft.Win32.RegistryKey"
		alias
			"get_Name"
		end

feature -- Basic Operations

	frozen set_value (name2: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"SetValue"
		end

	frozen delete_value (name2: STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteValue"
		end

	frozen delete_value_raise_excepction (name2: STRING; throw_on_missing_value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteValue"
		end

	frozen close is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"Close"
		end

	frozen create_sub_key (subkey: STRING): MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL signature (System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"CreateSubKey"
		end

	frozen get_value (name2: STRING): ANY is
		external
			"IL signature (System.String): System.Object use Microsoft.Win32.RegistryKey"
		alias
			"GetValue"
		end

	frozen get_value_or_default (name2: STRING; default_value: ANY): ANY is
		external
			"IL signature (System.String, System.Object): System.Object use Microsoft.Win32.RegistryKey"
		alias
			"GetValue"
		end

	frozen open_write_sub_key (name2: STRING; writable: BOOLEAN): MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL signature (System.String, System.Boolean): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenSubKey"
		end

	frozen delete_sub_key (subkey: STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKey"
		end

	frozen delete_sub_key_raise_exception (subkey: STRING; throw_on_missing_sub_key: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKey"
		end

	frozen get_sub_key_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use Microsoft.Win32.RegistryKey"
		alias
			"GetSubKeyNames"
		end

	frozen flush is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"Flush"
		end

	frozen delete_sub_key_tree (subkey: STRING) is
		external
			"IL signature (System.String): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"DeleteSubKeyTree"
		end

	frozen open_sub_key (name2: STRING): MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL signature (System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenSubKey"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use Microsoft.Win32.RegistryKey"
		alias
			"ToString"
		end

	frozen open_remote_base_key (h_key: INTEGER; machine_name: STRING): MICROSOFT_WIN32_REGISTRYKEY is
			-- Valid values for `h_key' are:
			-- ClassesRoot = -2147483648
			-- CurrentUser = -2147483647
			-- LocalMachine = -2147483646
			-- Users = -2147483645
			-- PerformanceData = -2147483644
			-- CurrentConfig = -2147483643
			-- DynData = -2147483642
		require
			valid_registry_hive: h_key = -2147483648 or h_key = -2147483647 or h_key = -2147483646 or h_key = -2147483645 or h_key = -2147483644 or h_key = -2147483643 or h_key = -2147483642
		external
			"IL static signature (enum Microsoft.Win32.RegistryHive, System.String): Microsoft.Win32.RegistryKey use Microsoft.Win32.RegistryKey"
		alias
			"OpenRemoteBaseKey"
		end

	frozen get_value_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use Microsoft.Win32.RegistryKey"
		alias
			"GetValueNames"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"Finalize"
		end

	frozen disposable_dispose is
		external
			"IL signature (): System.Void use Microsoft.Win32.RegistryKey"
		alias
			"System.IDisposable.Dispose"
		end

end -- class MICROSOFT_WIN32_REGISTRYKEY
