indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.TypeInitializationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TYPE_INITIALIZATION_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_type_initialization_exception

feature {NONE} -- Initialization

	frozen make_type_initialization_exception (full_type_name: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.TypeInitializationException"
		end

feature -- Access

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.TypeInitializationException"
		alias
			"get_TypeName"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.TypeInitializationException"
		alias
			"GetObjectData"
		end

end -- class TYPE_INITIALIZATION_EXCEPTION
