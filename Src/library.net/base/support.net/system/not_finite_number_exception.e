indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.NotFiniteNumberException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	NOT_FINITE_NUMBER_EXCEPTION

inherit
	ARITHMETIC_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_not_finite_number_exception,
	make_not_finite_number_exception_3,
	make_not_finite_number_exception_2,
	make_not_finite_number_exception_1,
	make_not_finite_number_exception_4

feature {NONE} -- Initialization

	frozen make_not_finite_number_exception is
		external
			"IL creator use System.NotFiniteNumberException"
		end

	frozen make_not_finite_number_exception_3 (message: SYSTEM_STRING; offending_number: DOUBLE) is
		external
			"IL creator signature (System.String, System.Double) use System.NotFiniteNumberException"
		end

	frozen make_not_finite_number_exception_2 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.NotFiniteNumberException"
		end

	frozen make_not_finite_number_exception_1 (offending_number: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.NotFiniteNumberException"
		end

	frozen make_not_finite_number_exception_4 (message: SYSTEM_STRING; offending_number: DOUBLE; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Double, System.Exception) use System.NotFiniteNumberException"
		end

feature -- Access

	frozen get_offending_number: DOUBLE is
		external
			"IL signature (): System.Double use System.NotFiniteNumberException"
		alias
			"get_OffendingNumber"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.NotFiniteNumberException"
		alias
			"GetObjectData"
		end

end -- class NOT_FINITE_NUMBER_EXCEPTION
