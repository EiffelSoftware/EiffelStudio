indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.IRegistrationHelper"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_IREGISTRATION_HELPER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	install_assembly (assembly: SYSTEM_STRING; application: SYSTEM_STRING; tlb: SYSTEM_STRING; install_flags: ENT_SERV_INSTALLATION_FLAGS) is
		external
			"IL deferred signature (System.String, System.String&, System.String&, System.EnterpriseServices.InstallationFlags): System.Void use System.EnterpriseServices.IRegistrationHelper"
		alias
			"InstallAssembly"
		end

	uninstall_assembly (assembly: SYSTEM_STRING; application: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.EnterpriseServices.IRegistrationHelper"
		alias
			"UninstallAssembly"
		end

end -- class ENT_SERV_IREGISTRATION_HELPER
