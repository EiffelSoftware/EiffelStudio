indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.TypedDataSetGeneratorException"

external class
	SYSTEM_DATA_TYPEDDATASETGENERATOREXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
		redefine
			get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_typeddatasetgeneratorexception_1,
	make_typeddatasetgeneratorexception,
	make_typeddatasetgeneratorexception_2

feature {NONE} -- Initialization

	frozen make_typeddatasetgeneratorexception_1 is
		external
			"IL creator use System.Data.TypedDataSetGeneratorException"
		end

	frozen make_typeddatasetgeneratorexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.TypedDataSetGeneratorException"
		end

	frozen make_typeddatasetgeneratorexception_2 (list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL creator signature (System.Collections.ArrayList) use System.Data.TypedDataSetGeneratorException"
		end

feature -- Access

	frozen get_error_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.TypedDataSetGeneratorException"
		alias
			"get_ErrorList"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.TypedDataSetGeneratorException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_DATA_TYPEDDATASETGENERATOREXCEPTION
