indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IComSoapPublisher"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ICOM_SOAP_PUBLISHER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	gac_remove (assembly_path: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"GacRemove"
		end

	process_server_tlb (prog_id: SYSTEM_STRING; src_tlb_path: SYSTEM_STRING; physical_path: SYSTEM_STRING; operation: SYSTEM_STRING; assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"ProcessServerTlb"
		end

	create_virtual_root (operation: SYSTEM_STRING; full_url: SYSTEM_STRING; base_url: SYSTEM_STRING; virtual_root: SYSTEM_STRING; physical_path: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"CreateVirtualRoot"
		end

	gac_install (assembly_path: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"GacInstall"
		end

	un_register_assembly (assembly_path: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"UnRegisterAssembly"
		end

	create_mail_box (root_mail_server: SYSTEM_STRING; mail_box: SYSTEM_STRING; smtp_name: SYSTEM_STRING; domain: SYSTEM_STRING; physical_path: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"CreateMailBox"
		end

	delete_mail_box (root_mail_server: SYSTEM_STRING; mail_box: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"DeleteMailBox"
		end

	process_client_tlb (prog_id: SYSTEM_STRING; src_tlb_path: SYSTEM_STRING; physical_path: SYSTEM_STRING; vroot: SYSTEM_STRING; base_url: SYSTEM_STRING; mode: SYSTEM_STRING; transport: SYSTEM_STRING; assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"ProcessClientTlb"
		end

	get_type_name_from_prog_id (assembly_path: SYSTEM_STRING; prog_id: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"GetTypeNameFromProgId"
		end

	register_assembly (assembly_path: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"RegisterAssembly"
		end

	get_assembly_name_for_cache (type_lib_path: SYSTEM_STRING; cache_path: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"GetAssemblyNameForCache"
		end

	delete_virtual_root (root_web_server: SYSTEM_STRING; full_url: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"DeleteVirtualRoot"
		end

end -- class ENT_SERV_ICOM_SOAP_PUBLISHER
