indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IComSoapPublisher"

deferred external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPPUBLISHER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	create_mail_box (root_mail_server: STRING; mail_box: STRING; smtp_name: STRING; domain: STRING; physical_path: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"CreateMailBox"
		end

	process_server_tlb (prog_id: STRING; src_tlb_path: STRING; physical_path: STRING; mode: STRING; assembly_name: STRING; type_name: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"ProcessServerTlb"
		end

	delete_mail_box (root_mail_server: STRING; mail_box: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"DeleteMailBox"
		end

	get_type_name_from_prog_id (assembly_path: STRING; prog_id: STRING): STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"GetTypeNameFromProgId"
		end

	create_virtual_root (root_web_server: STRING; full_url: STRING; base_url: STRING; virtual_root: STRING; physical_path: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"CreateVirtualRoot"
		end

	delete_virtual_root (root_web_server: STRING; full_url: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"DeleteVirtualRoot"
		end

	process_client_tlb (prog_id: STRING; src_tlb_path: STRING; physical_path: STRING; vroot: STRING; base_url: STRING; mode: STRING; transport: STRING; assembly_name: STRING; type_name: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapPublisher"
		alias
			"ProcessClientTlb"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPPUBLISHER
