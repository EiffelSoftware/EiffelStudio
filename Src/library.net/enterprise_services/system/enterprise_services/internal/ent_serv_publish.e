indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.Publish"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_PUBLISH

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ENT_SERV_ICOM_SOAP_PUBLISHER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.Publish"
		end

feature -- Basic Operations

	frozen delete_virtual_root (root_web_server: SYSTEM_STRING; full_url: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"DeleteVirtualRoot"
		end

	frozen delete_mail_box (root_mail_server: SYSTEM_STRING; mail_box: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"DeleteMailBox"
		end

	frozen get_assembly_name_for_cache (type_lib_path: SYSTEM_STRING; cache_path: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"GetAssemblyNameForCache"
		end

	frozen parse_url (full_url: SYSTEM_STRING; base_url: SYSTEM_STRING; virtual_root: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"ParseUrl"
		end

	frozen process_server_tlb (prog_id: SYSTEM_STRING; src_tlb_path: SYSTEM_STRING; physical_path: SYSTEM_STRING; operation: SYSTEM_STRING; str_assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"ProcessServerTlb"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.Publish"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.Publish"
		alias
			"GetHashCode"
		end

	frozen gac_remove (assembly_path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"GacRemove"
		end

	frozen create_virtual_root (operation: SYSTEM_STRING; full_url: SYSTEM_STRING; base_url: SYSTEM_STRING; virtual_root: SYSTEM_STRING; physical_path: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"CreateVirtualRoot"
		end

	frozen process_client_tlb (prog_id: SYSTEM_STRING; src_tlb_path: SYSTEM_STRING; physical_path: SYSTEM_STRING; vroot: SYSTEM_STRING; base_url: SYSTEM_STRING; mode: SYSTEM_STRING; transport: SYSTEM_STRING; assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"ProcessClientTlb"
		end

	frozen get_type_name_from_prog_id (assembly_path: SYSTEM_STRING; prog_id: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.Publish"
		alias
			"GetTypeNameFromProgId"
		end

	frozen un_register_assembly (assembly_path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"UnRegisterAssembly"
		end

	frozen get_client_physical_path (create_dir: BOOLEAN): SYSTEM_STRING is
		external
			"IL static signature (System.Boolean): System.String use System.EnterpriseServices.Internal.Publish"
		alias
			"GetClientPhysicalPath"
		end

	frozen register_assembly (assembly_path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"RegisterAssembly"
		end

	frozen create_mail_box (root_mail_server: SYSTEM_STRING; mail_box: SYSTEM_STRING; smtp_name: SYSTEM_STRING; domain: SYSTEM_STRING; physical_path: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"CreateMailBox"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.Publish"
		alias
			"ToString"
		end

	frozen gac_install (assembly_path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"GacInstall"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"Finalize"
		end

end -- class ENT_SERV_PUBLISH
