indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.RegistrationHelperTx"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_REGISTRATION_HELPER_TX

inherit
	ENT_SERV_SERVICED_COMPONENT
		redefine
			deactivate,
			activate
		end
	ENT_SERV_IREMOTE_DISPATCH
		rename
			remote_dispatch_not_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done,
			remote_dispatch_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done
		end
	IDISPOSABLE
	ENT_SERV_ISERVICED_COMPONENT_INFO
		rename
			get_component_info as system_enterprise_services_iserviced_component_info_get_component_info
		end

create
	make_ent_serv_registration_helper_tx

feature {NONE} -- Initialization

	frozen make_ent_serv_registration_helper_tx is
		external
			"IL creator use System.EnterpriseServices.RegistrationHelperTx"
		end

feature -- Basic Operations

	frozen uninstall_assembly (assembly: SYSTEM_STRING; application: SYSTEM_STRING; sync: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"UninstallAssembly"
		end

	frozen uninstall_assembly_string_string_string (assembly: SYSTEM_STRING; application: SYSTEM_STRING; partition: SYSTEM_STRING; sync: SYSTEM_OBJECT) is
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

	frozen install_assembly (assembly: SYSTEM_STRING; application: SYSTEM_STRING; tlb: SYSTEM_STRING; install_flags: ENT_SERV_INSTALLATION_FLAGS; sync: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String&, System.String&, System.EnterpriseServices.InstallationFlags, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"InstallAssembly"
		end

	frozen install_assembly_string_string_string (assembly: SYSTEM_STRING; application: SYSTEM_STRING; partition: SYSTEM_STRING; tlb: SYSTEM_STRING; install_flags: ENT_SERV_INSTALLATION_FLAGS; sync: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String&, System.String, System.String&, System.EnterpriseServices.InstallationFlags, System.Object): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"InstallAssembly"
		end

feature {NONE} -- Implementation

	activate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"Activate"
		end

	deactivate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.RegistrationHelperTx"
		alias
			"Deactivate"
		end

end -- class ENT_SERV_REGISTRATION_HELPER_TX
