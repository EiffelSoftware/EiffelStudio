indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IComManagedImportUtil"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ICOM_MANAGED_IMPORT_UTIL

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_component_info (assembly_path: SYSTEM_STRING; num_components: SYSTEM_STRING; component_info: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComManagedImportUtil"
		alias
			"GetComponentInfo"
		end

	install_assembly (filename: SYSTEM_STRING; parname: SYSTEM_STRING; appname: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Void use System.EnterpriseServices.Internal.IComManagedImportUtil"
		alias
			"InstallAssembly"
		end

end -- class ENT_SERV_ICOM_MANAGED_IMPORT_UTIL
