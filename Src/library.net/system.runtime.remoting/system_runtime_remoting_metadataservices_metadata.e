indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.MetadataServices.MetaData"

external class
	SYSTEM_RUNTIME_REMOTING_METADATASERVICES_METADATA

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.MetadataServices.MetaData"
		end

feature -- Basic Operations

	frozen convert_code_source_stream_to_assembly_file (out_code_stream_list: SYSTEM_COLLECTIONS_ARRAYLIST; assembly_path: STRING; strong_name_filename: STRING) is
		external
			"IL static signature (System.Collections.ArrayList, System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertCodeSourceStreamToAssemblyFile"
		end

	frozen convert_schema_stream_to_code_source_stream (client_proxy: BOOLEAN; output_directory: STRING; input_stream: SYSTEM_IO_STREAM; out_code_stream_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL static signature (System.Boolean, System.String, System.IO.Stream, System.Collections.ArrayList): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertSchemaStreamToCodeSourceStream"
		end

	frozen save_stream_to_file (input_stream: SYSTEM_IO_STREAM; path: STRING) is
		external
			"IL static signature (System.IO.Stream, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"SaveStreamToFile"
		end

	frozen retrieve_schema_from_url_to_file (url: STRING; path: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"RetrieveSchemaFromUrlToFile"
		end

	frozen convert_types_to_schema_to_file_array_type (types: ARRAY [SYSTEM_TYPE]; sdl_type: SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLTYPE; path: STRING) is
		external
			"IL static signature (System.Type[], System.Runtime.Remoting.MetadataServices.SdlType, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToFile"
		end

	frozen convert_types_to_schema_to_stream (service_types: ARRAY [SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SERVICETYPE]; sdl_type: SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLTYPE; output_stream: SYSTEM_IO_STREAM) is
		external
			"IL static signature (System.Runtime.Remoting.MetadataServices.ServiceType[], System.Runtime.Remoting.MetadataServices.SdlType, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToStream"
		end

	frozen convert_types_to_schema_to_file (types: ARRAY [SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SERVICETYPE]; sdl_type: SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLTYPE; path: STRING) is
		external
			"IL static signature (System.Runtime.Remoting.MetadataServices.ServiceType[], System.Runtime.Remoting.MetadataServices.SdlType, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToFile"
		end

	frozen convert_schema_stream_to_code_source_stream_boolean_string_stream_array_list_string_string (client_proxy: BOOLEAN; output_directory: STRING; input_stream: SYSTEM_IO_STREAM; out_code_stream_list: SYSTEM_COLLECTIONS_ARRAYLIST; proxy_url: STRING; proxy_namespace: STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.IO.Stream, System.Collections.ArrayList, System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertSchemaStreamToCodeSourceStream"
		end

	frozen retrieve_schema_from_url_to_stream (url: STRING; output_stream: SYSTEM_IO_STREAM) is
		external
			"IL static signature (System.String, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"RetrieveSchemaFromUrlToStream"
		end

	frozen convert_schema_stream_to_code_source_stream_boolean_string_stream_array_list_string (client_proxy: BOOLEAN; output_directory: STRING; input_stream: SYSTEM_IO_STREAM; out_code_stream_list: SYSTEM_COLLECTIONS_ARRAYLIST; proxy_url: STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.IO.Stream, System.Collections.ArrayList, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertSchemaStreamToCodeSourceStream"
		end

	frozen convert_types_to_schema_to_stream_array_type (types: ARRAY [SYSTEM_TYPE]; sdl_type: SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLTYPE; output_stream: SYSTEM_IO_STREAM) is
		external
			"IL static signature (System.Type[], System.Runtime.Remoting.MetadataServices.SdlType, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToStream"
		end

	frozen convert_code_source_file_to_assembly_file (code_path: STRING; assembly_path: STRING; strong_name_filename: STRING) is
		external
			"IL static signature (System.String, System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertCodeSourceFileToAssemblyFile"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATASERVICES_METADATA
