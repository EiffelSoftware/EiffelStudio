indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IServerWebConfig"

deferred external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ISERVERWEBCONFIG

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	add_element (file_path: STRING; assembly_name: STRING; type_name: STRING; prog_id: STRING; mode: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IServerWebConfig"
		alias
			"AddElement"
		end

	Create_ (file_path: STRING; file_root_name: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IServerWebConfig"
		alias
			"Create"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_ISERVERWEBCONFIG
