indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.NotSupportedException"

external class
	SYSTEM_NOTSUPPORTEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_notsupportedexception,
	make_notsupportedexception_1,
	make_notsupportedexception_2

feature {NONE} -- Initialization

	frozen make_notsupportedexception is
		external
			"IL creator use System.NotSupportedException"
		end

	frozen make_notsupportedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.NotSupportedException"
		end

	frozen make_notsupportedexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.NotSupportedException"
		end

end -- class SYSTEM_NOTSUPPORTEDEXCEPTION
