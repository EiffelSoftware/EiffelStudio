indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.FieldAccessException"

external class
	SYSTEM_FIELDACCESSEXCEPTION

inherit
	SYSTEM_MEMBERACCESSEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_fieldaccessexception_2,
	make_fieldaccessexception,
	make_fieldaccessexception_1

feature {NONE} -- Initialization

	frozen make_fieldaccessexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.FieldAccessException"
		end

	frozen make_fieldaccessexception is
		external
			"IL creator use System.FieldAccessException"
		end

	frozen make_fieldaccessexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.FieldAccessException"
		end

end -- class SYSTEM_FIELDACCESSEXCEPTION
