indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IServerWebConfig"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ISERVER_WEB_CONFIG

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_ (file_path: SYSTEM_STRING; file_root_name: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IServerWebConfig"
		alias
			"Create"
		end

	add_element (file_path: SYSTEM_STRING; assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; prog_id: SYSTEM_STRING; mode: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IServerWebConfig"
		alias
			"AddElement"
		end

end -- class ENT_SERV_ISERVER_WEB_CONFIG
