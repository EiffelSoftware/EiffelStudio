indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ArgumentException"

external class
	SYSTEM_ARGUMENTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_argumentexception,
	make_argumentexception_4,
	make_argumentexception_1,
	make_argumentexception_2,
	make_argumentexception_3

feature {NONE} -- Initialization

	frozen make_argumentexception is
		external
			"IL creator use System.ArgumentException"
		end

	frozen make_argumentexception_4 (message: STRING; param_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentException"
		end

	frozen make_argumentexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentException"
		end

	frozen make_argumentexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArgumentException"
		end

	frozen make_argumentexception_3 (message: STRING; param_name: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.ArgumentException"
		end

feature -- Access

	get_param_name: STRING is
		external
			"IL signature (): System.String use System.ArgumentException"
		alias
			"get_ParamName"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.ArgumentException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ArgumentException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_ARGUMENTEXCEPTION
