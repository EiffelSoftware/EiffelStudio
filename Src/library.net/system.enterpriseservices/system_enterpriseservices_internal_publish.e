indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.Publish"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_PUBLISH

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPPUBLISHER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.Publish"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.Publish"
		alias
			"ToString"
		end

	frozen process_server_tlb (prog_id: STRING; src_tlb_path: STRING; physical_path: STRING; mode: STRING; str_assembly_name: STRING; type_name: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"ProcessServerTlb"
		end

	frozen create_virtual_root (root_web_server: STRING; full_url: STRING; base_url: STRING; virtual_root: STRING; physical_path: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"CreateVirtualRoot"
		end

	frozen get_client_physical_path (create_dir: BOOLEAN): STRING is
		external
			"IL static signature (System.Boolean): System.String use System.EnterpriseServices.Internal.Publish"
		alias
			"GetClientPhysicalPath"
		end

	frozen create_mail_box (root_mail_server: STRING; mail_box: STRING; smtp_name: STRING; domain: STRING; physical_path: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String&, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"CreateMailBox"
		end

	frozen delete_mail_box (root_mail_server: STRING; mail_box: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"DeleteMailBox"
		end

	frozen parse_url (full_url: STRING; base_url: STRING; virtual_root: STRING) is
		external
			"IL static signature (System.String, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"ParseUrl"
		end

	frozen process_client_tlb (prog_id: STRING; src_tlb_path: STRING; physical_path: STRING; vroot: STRING; base_url: STRING; mode: STRING; transport: STRING; assembly_name: STRING; type_name: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String&, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"ProcessClientTlb"
		end

	frozen get_type_name_from_prog_id (assembly_path: STRING; prog_id: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.Publish"
		alias
			"GetTypeNameFromProgId"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.Publish"
		alias
			"Equals"
		end

	frozen delete_virtual_root (root_web_server: STRING; full_url: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"DeleteVirtualRoot"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.Publish"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.Publish"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_PUBLISH
