indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.GenerateMetadata"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_GENERATEMETADATA

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPMETADATA

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

	frozen search_path (path: STRING; file_name: STRING; extension: STRING; num_buffer_chars: INTEGER; buffer: STRING; file_part: ARRAY [INTEGER]): INTEGER is
		external
			"IL static signature (System.String, System.String, System.String, System.Int32, System.String, System.Int32[]): System.Int32 use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"SearchPath"
		end

	frozen generate_meta_data (str_src_type_lib: STRING; out_path: STRING; public_key: ARRAY [INTEGER_8]; key_pair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR): STRING is
		external
			"IL signature (System.String, System.String, System.Byte[], System.Reflection.StrongNameKeyPair): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"GenerateMetaData"
		end

	frozen generate (str_src_type_lib: STRING; out_path: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"Generate"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"ToString"
		end

	frozen generate_signed (str_src_type_lib: STRING; out_path: STRING; install_gac: BOOLEAN; error: STRING): STRING is
		external
			"IL signature (System.String, System.String, System.Boolean, System.String&): System.String use System.EnterpriseServices.Internal.GenerateMetadata"
		alias
			"GenerateSigned"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_GENERATEMETADATA
