indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.RegistrationHelperTx"

frozen external class
	SYSTEM_ENTERPRISESERVICES_REGISTRATIONHELPERTX

inherit
	SYSTEM_ENTERPRISESERVICES_IREMOTEDISPATCH
		rename
			remote_dispatch_not_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done,
			remote_dispatch_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENT
		redefine
			deactivate,
			activate
		end

create
	make_registrationhelpertx

feature {NONE} -- Initialization

	frozen make_registrationhelpertx is
		external
			"IL creator use System.EnterpriseServices.RegistrationHelperTx"
		end

feature -- Basic Operations

	frozen uninstall_assembly_string_string_string (assembly: STRING; application: STRING; partition: STRING; sync: ANY) is
		external
			"IL signature (System.String, System.String, System.String, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"UninstallAssembly"
		end

	frozen is_in_transaction: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"IsInTransaction"
		end

	frozen install_utility_application (t: STRING) is
		external
			"IL static signature (System.String): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"InstallUtilityApplication"
		end

	frozen install_assembly_string_string_string (assembly: STRING; application: STRING; partition: STRING; tlb: STRING; install_flags: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS; sync: ANY) is
		external
			"IL signature (System.String, System.String&, System.String, System.String&, System.EnterpriseServices.InstallationFlags, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"InstallAssembly"
		end

	frozen install_assembly (assembly: STRING; application: STRING; tlb: STRING; install_flags: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS; sync: ANY) is
		external
			"IL signature (System.String, System.String&, System.String&, System.EnterpriseServices.InstallationFlags, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"InstallAssembly"
		end

	activate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"Activate"
		end

	frozen uninstall_assembly (assembly: STRING; application: STRING; sync: ANY) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"UninstallAssembly"
		end

	deactivate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"Deactivate"
		end

end -- class SYSTEM_ENTERPRISESERVICES_REGISTRATIONHELPERTX
