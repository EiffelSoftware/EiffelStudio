indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.GenerateMetadata"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_GENERATE_METADATA

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ENT_SERV_ICOM_SOAP_METADATA

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.GenerateMetadata"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"GetHashCode"
		end

	frozen search_path (path: SYSTEM_STRING; file_name: SYSTEM_STRING; extension: SYSTEM_STRING; num_buffer_chars: INTEGER; buffer: SYSTEM_STRING; file_part: NATIVE_ARRAY [INTEGER]): INTEGER is
		external
			"IL static signature (System.String, System.String, System.String, System.Int32, System.String, System.Int32[]): System.Int32 use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"SearchPath"
		end

	frozen generate_meta_data (str_src_type_lib: SYSTEM_STRING; out_path: SYSTEM_STRING; public_key: NATIVE_ARRAY [INTEGER_8]; key_pair: STRONG_NAME_KEY_PAIR): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String, System.Byte[], System.Reflection.StrongNameKeyPair): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"GenerateMetaData"
		end

	frozen generate (str_src_type_lib: SYSTEM_STRING; out_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"Generate"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"ToString"
		end

	frozen generate_signed (str_src_type_lib: SYSTEM_STRING; out_path: SYSTEM_STRING; install_gac: BOOLEAN; error: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String, System.Boolean, System.String&): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"GenerateSigned"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"Finalize"
		end

end -- class ENT_SERV_GENERATE_METADATA
