indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.FormatException"

external class
	SYSTEM_FORMATEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_formatexception,
	make_formatexception_1,
	make_formatexception_2

feature {NONE} -- Initialization

	frozen make_formatexception is
		external
			"IL creator use System.FormatException"
		end

	frozen make_formatexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.FormatException"
		end

	frozen make_formatexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.FormatException"
		end

end -- class SYSTEM_FORMATEXCEPTION
