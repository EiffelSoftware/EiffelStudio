indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.TypedDataSetGeneratorException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_TYPED_DATA_SET_GENERATOR_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_data_typed_data_set_generator_exception_1,
	make_data_typed_data_set_generator_exception

feature {NONE} -- Initialization

	frozen make_data_typed_data_set_generator_exception_1 (list: ARRAY_LIST) is
		external
			"IL creator signature (System.Collections.ArrayList) use System.Data.TypedDataSetGeneratorException"
		end

	frozen make_data_typed_data_set_generator_exception is
		external
			"IL creator use System.Data.TypedDataSetGeneratorException"
		end

feature -- Access

	frozen get_error_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.TypedDataSetGeneratorException"
		alias
			"get_ErrorList"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.TypedDataSetGeneratorException"
		alias
			"GetObjectData"
		end

end -- class DATA_TYPED_DATA_SET_GENERATOR_EXCEPTION
