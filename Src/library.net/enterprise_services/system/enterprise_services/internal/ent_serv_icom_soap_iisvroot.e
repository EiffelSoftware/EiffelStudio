indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IComSoapIISVRoot"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ICOM_SOAP_IISVROOT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_ (root_web: SYSTEM_STRING; physical_directory: SYSTEM_STRING; virtual_directory: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapIISVRoot"
		alias
			"Create"
		end

	delete (root_web: SYSTEM_STRING; physical_directory: SYSTEM_STRING; virtual_directory: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapIISVRoot"
		alias
			"Delete"
		end

end -- class ENT_SERV_ICOM_SOAP_IISVROOT
