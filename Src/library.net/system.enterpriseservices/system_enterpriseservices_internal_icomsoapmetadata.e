indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IComSoapMetadata"

deferred external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPMETADATA

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	generate (src_type_lib_file_name: STRING; out_path: STRING): STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.IComSoapMetadata"
		alias
			"Generate"
		end

	generate_signed (src_type_lib_file_name: STRING; out_path: STRING; install_gac: BOOLEAN; error: STRING): STRING is
		external
			"IL deferred signature (System.String, System.String, System.Boolean, System.String&): System.String use System.EnterpriseServices.Internal.IComSoapMetadata"
		alias
			"GenerateSigned"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPMETADATA
