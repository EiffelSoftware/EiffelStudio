indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.MetadataServices.MetaData"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_META_DATA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.MetadataServices.MetaData"
		end

feature -- Basic Operations

	frozen convert_code_source_stream_to_assembly_file (out_code_stream_list: ARRAY_LIST; assembly_path: SYSTEM_STRING; strong_name_filename: SYSTEM_STRING) is
		external
			"IL static signature (System.Collections.ArrayList, System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertCodeSourceStreamToAssemblyFile"
		end

	frozen convert_schema_stream_to_code_source_stream (client_proxy: BOOLEAN; output_directory: SYSTEM_STRING; input_stream: SYSTEM_STREAM; out_code_stream_list: ARRAY_LIST) is
		external
			"IL static signature (System.Boolean, System.String, System.IO.Stream, System.Collections.ArrayList): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertSchemaStreamToCodeSourceStream"
		end

	frozen save_stream_to_file (input_stream: SYSTEM_STREAM; path: SYSTEM_STRING) is
		external
			"IL static signature (System.IO.Stream, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"SaveStreamToFile"
		end

	frozen retrieve_schema_from_url_to_file (url: SYSTEM_STRING; path: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"RetrieveSchemaFromUrlToFile"
		end

	frozen convert_types_to_schema_to_file_array_type (types: NATIVE_ARRAY [TYPE]; sdl_type: RT_REMOTING_SDL_TYPE; path: SYSTEM_STRING) is
		external
			"IL static signature (System.Type[], System.Runtime.Remoting.MetadataServices.SdlType, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToFile"
		end

	frozen convert_types_to_schema_to_stream (service_types: NATIVE_ARRAY [RT_REMOTING_SERVICE_TYPE]; sdl_type: RT_REMOTING_SDL_TYPE; output_stream: SYSTEM_STREAM) is
		external
			"IL static signature (System.Runtime.Remoting.MetadataServices.ServiceType[], System.Runtime.Remoting.MetadataServices.SdlType, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToStream"
		end

	frozen convert_types_to_schema_to_file (types: NATIVE_ARRAY [RT_REMOTING_SERVICE_TYPE]; sdl_type: RT_REMOTING_SDL_TYPE; path: SYSTEM_STRING) is
		external
			"IL static signature (System.Runtime.Remoting.MetadataServices.ServiceType[], System.Runtime.Remoting.MetadataServices.SdlType, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToFile"
		end

	frozen convert_schema_stream_to_code_source_stream_boolean_string_stream_array_list_string_string (client_proxy: BOOLEAN; output_directory: SYSTEM_STRING; input_stream: SYSTEM_STREAM; out_code_stream_list: ARRAY_LIST; proxy_url: SYSTEM_STRING; proxy_namespace: SYSTEM_STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.IO.Stream, System.Collections.ArrayList, System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertSchemaStreamToCodeSourceStream"
		end

	frozen retrieve_schema_from_url_to_stream (url: SYSTEM_STRING; output_stream: SYSTEM_STREAM) is
		external
			"IL static signature (System.String, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"RetrieveSchemaFromUrlToStream"
		end

	frozen convert_schema_stream_to_code_source_stream_boolean_string_stream_array_list_string (client_proxy: BOOLEAN; output_directory: SYSTEM_STRING; input_stream: SYSTEM_STREAM; out_code_stream_list: ARRAY_LIST; proxy_url: SYSTEM_STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.IO.Stream, System.Collections.ArrayList, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertSchemaStreamToCodeSourceStream"
		end

	frozen convert_types_to_schema_to_stream_array_type (types: NATIVE_ARRAY [TYPE]; sdl_type: RT_REMOTING_SDL_TYPE; output_stream: SYSTEM_STREAM) is
		external
			"IL static signature (System.Type[], System.Runtime.Remoting.MetadataServices.SdlType, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertTypesToSchemaToStream"
		end

	frozen convert_code_source_file_to_assembly_file (code_path: SYSTEM_STRING; assembly_path: SYSTEM_STRING; strong_name_filename: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String, System.String): System.Void use System.Runtime.Remoting.MetadataServices.MetaData"
		alias
			"ConvertCodeSourceFileToAssemblyFile"
		end

end -- class RT_REMOTING_META_DATA
