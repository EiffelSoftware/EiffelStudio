indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ArgumentOutOfRangeException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ARGUMENT_OUT_OF_RANGE_EXCEPTION

inherit
	ARGUMENT_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_argument_out_of_range_exception,
	make_argument_out_of_range_exception_1,
	make_argument_out_of_range_exception_2,
	make_argument_out_of_range_exception_3

feature {NONE} -- Initialization

	frozen make_argument_out_of_range_exception is
		external
			"IL creator use System.ArgumentOutOfRangeException"
		end

	frozen make_argument_out_of_range_exception_1 (param_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentOutOfRangeException"
		end

	frozen make_argument_out_of_range_exception_2 (param_name: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentOutOfRangeException"
		end

	frozen make_argument_out_of_range_exception_3 (param_name: SYSTEM_STRING; actual_value: SYSTEM_OBJECT; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Object, System.String) use System.ArgumentOutOfRangeException"
		end

feature -- Access

	get_actual_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ArgumentOutOfRangeException"
		alias
			"get_ActualValue"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ArgumentOutOfRangeException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ArgumentOutOfRangeException"
		alias
			"GetObjectData"
		end

end -- class ARGUMENT_OUT_OF_RANGE_EXCEPTION
