indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IComSoapMetadata"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ICOM_SOAP_METADATA

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	generate (src_type_lib_file_name: SYSTEM_STRING; out_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.IComSoapMetadata"
		alias
			"Generate"
		end

	generate_signed (src_type_lib_file_name: SYSTEM_STRING; out_path: SYSTEM_STRING; install_gac: BOOLEAN; error: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String, System.Boolean, System.String&): System.String use System.EnterpriseServices.Internal.IComSoapMetadata"
		alias
			"GenerateSigned"
		end

end -- class ENT_SERV_ICOM_SOAP_METADATA
