indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.ComManagedImportUtil"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_COM_MANAGED_IMPORT_UTIL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ENT_SERV_ICOM_MANAGED_IMPORT_UTIL

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ComManagedImportUtil"
		end

feature -- Basic Operations

	frozen get_component_info (assembly_path: SYSTEM_STRING; num_components: SYSTEM_STRING; component_info: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"GetComponentInfo"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"ToString"
		end

	frozen install_assembly (asmpath: SYSTEM_STRING; parname: SYSTEM_STRING; appname: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"InstallAssembly"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"Finalize"
		end

end -- class ENT_SERV_COM_MANAGED_IMPORT_UTIL
