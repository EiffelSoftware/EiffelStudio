indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.RegistrationHelper"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_REGISTRATION_HELPER

inherit
	MARSHAL_BY_REF_OBJECT
	ENT_SERV_IREGISTRATION_HELPER

create
	make_ent_serv_registration_helper

feature {NONE} -- Initialization

	frozen make_ent_serv_registration_helper is
		external
			"IL creator use System.EnterpriseServices.RegistrationHelper"
		end

feature -- Basic Operations

	frozen uninstall_assembly_string_string_string (assembly: SYSTEM_STRING; application: SYSTEM_STRING; partition: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"UninstallAssembly"
		end

	frozen install_assembly_string_string_string (assembly: SYSTEM_STRING; application: SYSTEM_STRING; partition: SYSTEM_STRING; tlb: SYSTEM_STRING; install_flags: ENT_SERV_INSTALLATION_FLAGS) is
		external
			"IL signature (System.String, System.String&, System.String, System.String&, System.EnterpriseServices.InstallationFlags): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"InstallAssembly"
		end

	frozen install_assembly (assembly: SYSTEM_STRING; application: SYSTEM_STRING; tlb: SYSTEM_STRING; install_flags: ENT_SERV_INSTALLATION_FLAGS) is
		external
			"IL signature (System.String, System.String&, System.String&, System.EnterpriseServices.InstallationFlags): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"InstallAssembly"
		end

	frozen uninstall_assembly (assembly: SYSTEM_STRING; application: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"UninstallAssembly"
		end

end -- class ENT_SERV_REGISTRATION_HELPER
