indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.RegistrationHelper"

frozen external class
	SYSTEM_ENTERPRISESERVICES_REGISTRATIONHELPER

inherit
	SYSTEM_ENTERPRISESERVICES_IREGISTRATIONHELPER
	SYSTEM_MARSHALBYREFOBJECT

create
	make_registrationhelper

feature {NONE} -- Initialization

	frozen make_registrationhelper is
		external
			"IL creator use System.EnterpriseServices.RegistrationHelper"
		end

feature -- Basic Operations

	frozen uninstall_assembly_string_string_string (assembly: STRING; application: STRING; partition: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"UninstallAssembly"
		end

	frozen install_assembly_string_string_string (assembly: STRING; application: STRING; partition: STRING; tlb: STRING; install_flags: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS) is
		external
			"IL signature (System.String, System.String&, System.String, System.String&, System.EnterpriseServices.InstallationFlags): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"InstallAssembly"
		end

	frozen install_assembly (assembly: STRING; application: STRING; tlb: STRING; install_flags: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS) is
		external
			"IL signature (System.String, System.String&, System.String&, System.EnterpriseServices.InstallationFlags): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"InstallAssembly"
		end

	frozen uninstall_assembly (assembly: STRING; application: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.EnterpriseServices.RegistrationHelper"
		alias
			"UninstallAssembly"
		end

end -- class SYSTEM_ENTERPRISESERVICES_REGISTRATIONHELPER
