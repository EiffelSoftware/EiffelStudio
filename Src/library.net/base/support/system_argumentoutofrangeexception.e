indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ArgumentOutOfRangeException"

external class
	SYSTEM_ARGUMENTOUTOFRANGEEXCEPTION

inherit
	SYSTEM_ARGUMENTEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_argument_out_of_range_exception_1,
	make_argument_out_of_range_exception_2,
	make_argument_out_of_range_exception_3,
	make_argument_out_of_range_exception

feature {NONE} -- Initialization

	frozen make_argument_out_of_range_exception_1 (param_name2: STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentOutOfRangeException"
		end

	frozen make_argument_out_of_range_exception_2 (param_name2: STRING; message2: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentOutOfRangeException"
		end

	frozen make_argument_out_of_range_exception_3 (param_name2: STRING; actual_value2: ANY; message2: STRING) is
		external
			"IL creator signature (System.String, System.Object, System.String) use System.ArgumentOutOfRangeException"
		end

	frozen make_argument_out_of_range_exception is
		external
			"IL creator use System.ArgumentOutOfRangeException"
		end

feature -- Access

	get_actual_value: ANY is
		external
			"IL signature (): System.Object use System.ArgumentOutOfRangeException"
		alias
			"get_ActualValue"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.ArgumentOutOfRangeException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ArgumentOutOfRangeException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_ARGUMENTOUTOFRANGEEXCEPTION
