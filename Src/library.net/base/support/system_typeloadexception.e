indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.TypeLoadException"

external class
	SYSTEM_TYPELOADEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_typeloadexception_2,
	make_typeloadexception,
	make_typeloadexception_1

feature {NONE} -- Initialization

	frozen make_typeloadexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.TypeLoadException"
		end

	frozen make_typeloadexception is
		external
			"IL creator use System.TypeLoadException"
		end

	frozen make_typeloadexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.TypeLoadException"
		end

feature -- Access

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.TypeLoadException"
		alias
			"get_TypeName"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.TypeLoadException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.TypeLoadException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_TYPELOADEXCEPTION
