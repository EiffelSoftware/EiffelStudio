indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.CustomAttributeFormatException"

external class
	SYSTEM_REFLECTION_CUSTOMATTRIBUTEFORMATEXCEPTION

inherit
	SYSTEM_FORMATEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_customattributeformatexception_2,
	make_customattributeformatexception_1,
	make_customattributeformatexception

feature {NONE} -- Initialization

	frozen make_customattributeformatexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.CustomAttributeFormatException"
		end

	frozen make_customattributeformatexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.CustomAttributeFormatException"
		end

	frozen make_customattributeformatexception is
		external
			"IL creator use System.Reflection.CustomAttributeFormatException"
		end

end -- class SYSTEM_REFLECTION_CUSTOMATTRIBUTEFORMATEXCEPTION
