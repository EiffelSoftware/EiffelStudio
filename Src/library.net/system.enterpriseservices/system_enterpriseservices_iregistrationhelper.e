indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.IRegistrationHelper"

deferred external class
	SYSTEM_ENTERPRISESERVICES_IREGISTRATIONHELPER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	install_assembly (assembly: STRING; application: STRING; tlb: STRING; install_flags: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS) is
		external
			"IL deferred signature (System.String, System.String&, System.String&, System.EnterpriseServices.InstallationFlags): System.Void use System.EnterpriseServices.IRegistrationHelper"
		alias
			"InstallAssembly"
		end

	uninstall_assembly (assembly: STRING; application: STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.EnterpriseServices.IRegistrationHelper"
		alias
			"UninstallAssembly"
		end

end -- class SYSTEM_ENTERPRISESERVICES_IREGISTRATIONHELPER
