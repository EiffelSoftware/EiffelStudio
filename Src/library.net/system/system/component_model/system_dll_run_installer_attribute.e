indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.RunInstallerAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_run_installer_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_run_installer_attribute (run_installer: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.RunInstallerAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RunInstallerAttribute use System.ComponentModel.RunInstallerAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RunInstallerAttribute use System.ComponentModel.RunInstallerAttribute"
		alias
			"Yes"
		end

	frozen get_run_installer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RunInstallerAttribute"
		alias
			"get_RunInstaller"
		end

	frozen no: SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RunInstallerAttribute use System.ComponentModel.RunInstallerAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RunInstallerAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.RunInstallerAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.RunInstallerAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE
