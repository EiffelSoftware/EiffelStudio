indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.RunInstallerAttribute"

external class
	SYSTEM_COMPONENTMODEL_RUNINSTALLERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_runinstallerattribute

feature {NONE} -- Initialization

	frozen make_runinstallerattribute (run_installer: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.RunInstallerAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_RUNINSTALLERATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RunInstallerAttribute use System.ComponentModel.RunInstallerAttribute"
		alias
			"Default"
		end

	frozen get_run_installer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RunInstallerAttribute"
		alias
			"get_RunInstaller"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_RUNINSTALLERATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RunInstallerAttribute use System.ComponentModel.RunInstallerAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_RUNINSTALLERATTRIBUTE is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.RunInstallerAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_RUNINSTALLERATTRIBUTE
