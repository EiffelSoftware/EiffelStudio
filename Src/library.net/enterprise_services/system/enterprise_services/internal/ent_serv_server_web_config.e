indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.ServerWebConfig"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_SERVER_WEB_CONFIG

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ENT_SERV_ISERVER_WEB_CONFIG

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ServerWebConfig"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"GetHashCode"
		end

	frozen create_ (file_path: SYSTEM_STRING; file_prefix: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"Create"
		end

	frozen add_element (file_path: SYSTEM_STRING; assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; prog_id: SYSTEM_STRING; wko_mode: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"AddElement"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"Finalize"
		end

end -- class ENT_SERV_SERVER_WEB_CONFIG
