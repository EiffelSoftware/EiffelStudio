indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.InstallerTypeAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INSTALLER_TYPE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_installer_type_attribute_1,
	make_system_dll_installer_type_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_installer_type_attribute_1 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.InstallerTypeAttribute"
		end

	frozen make_system_dll_installer_type_attribute (installer_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.InstallerTypeAttribute"
		end

feature -- Access

	get_installer_type: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.InstallerTypeAttribute"
		alias
			"get_InstallerType"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.InstallerTypeAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.InstallerTypeAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_INSTALLER_TYPE_ATTRIBUTE
