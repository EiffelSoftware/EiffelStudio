indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.NotFiniteNumberException"

external class
	SYSTEM_NOTFINITENUMBEREXCEPTION

inherit
	SYSTEM_ARITHMETICEXCEPTION
		redefine
			get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_notfinitenumberexception_2,
	make_notfinitenumberexception_1,
	make_notfinitenumberexception,
	make_notfinitenumberexception_3,
	make_notfinitenumberexception_4

feature {NONE} -- Initialization

	frozen make_notfinitenumberexception_2 (message: STRING) is
		external
			"IL creator signature (System.String) use System.NotFiniteNumberException"
		end

	frozen make_notfinitenumberexception_1 (offending_number: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.NotFiniteNumberException"
		end

	frozen make_notfinitenumberexception is
		external
			"IL creator use System.NotFiniteNumberException"
		end

	frozen make_notfinitenumberexception_3 (message: STRING; offending_number: DOUBLE) is
		external
			"IL creator signature (System.String, System.Double) use System.NotFiniteNumberException"
		end

	frozen make_notfinitenumberexception_4 (message: STRING; offending_number: DOUBLE; inner_exception: SYSTEM_EXCEPTION) is
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

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.NotFiniteNumberException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_NOTFINITENUMBEREXCEPTION
